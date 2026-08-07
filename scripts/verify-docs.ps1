[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$requirements = Join-Path $PSScriptRoot 'requirements-docs.txt'
$python = Get-Command python -ErrorAction SilentlyContinue

if (-not $python) {
    Write-Error 'Python is required for repository validation. CI provisions Python explicitly; locally install Python 3.13 or a compatible supported interpreter.'
    exit 2
}

& $python.Path -c 'import yaml, json5, jsonschema' 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Repository validation dependencies are missing. Run: python -m pip install -r `"$requirements`""
    exit 2
}

$validator = @'
from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse

import json5
import jsonschema
import yaml
from jsonschema import FormatChecker

root = Path(sys.argv[1]).resolve()
errors: list[str] = []
warnings: list[str] = []


def rel(path: Path) -> str:
    return path.resolve().relative_to(root).as_posix()


def fail(path: Path | str, message: str) -> None:
    label = rel(path) if isinstance(path, Path) else path
    errors.append(f"{label}: {message}")


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig")


def tracked_paths() -> list[Path]:
    result = subprocess.run(
        ["git", "-C", str(root), "ls-files", "-z"],
        check=True,
        capture_output=True,
    )
    names = result.stdout.decode("utf-8").split("\0")
    return [root / name for name in names if name]


tracked = tracked_paths()
tracked_existing = [path for path in tracked if path.exists()]
tracked_rel = {rel(path) for path in tracked_existing}

# Parse every tracked JSON/JSONC document first. This makes syntax failures explicit
# before schema or cross-document checks run.
parsed: dict[Path, object] = {}
for path in tracked_existing:
    suffix = path.suffix.lower()
    if suffix not in {".json", ".jsonc"}:
        continue
    try:
        text = read_text(path)
        parsed[path.resolve()] = json.loads(text) if suffix == ".json" else json5.loads(text)
    except Exception as exc:  # noqa: BLE001 - validation must aggregate failures
        fail(path, f"cannot parse {suffix[1:].upper()}: {exc}")

# Load and self-check repository-owned JSON Schemas. Schema definitions stay in
# schema files; this validator only interprets them.
schema_paths = [
    path.resolve()
    for path in tracked_existing
    if path.name.endswith(".schema.json")
]
schemas: dict[Path, dict] = {}
store: dict[str, dict] = {}
for path in schema_paths:
    value = parsed.get(path)
    if not isinstance(value, dict):
        continue
    try:
        validator_cls = jsonschema.validators.validator_for(value)
        validator_cls.check_schema(value)
        schemas[path] = value
        store[path.as_uri()] = value
        if isinstance(value.get("$id"), str):
            store[value["$id"]] = value
    except Exception as exc:  # noqa: BLE001
        fail(path, f"invalid JSON Schema: {exc}")


def validate_instance(instance: object, schema_path: Path, instance_path: Path, label: str = "document") -> None:
    schema_path = schema_path.resolve()
    schema = schemas.get(schema_path)
    if schema is None:
        fail(instance_path, f"declared schema is unavailable or invalid: {rel(schema_path)}")
        return
    try:
        validator_cls = jsonschema.validators.validator_for(schema)
        resolver = jsonschema.RefResolver.from_schema(schema, store=store)
        validator = validator_cls(
            schema,
            resolver=resolver,
            format_checker=FormatChecker(),
        )
        validation_errors = sorted(validator.iter_errors(instance), key=lambda item: list(item.path))
        for error in validation_errors:
            location = ".".join(str(part) for part in error.path) or "<root>"
            fail(instance_path, f"{label} schema violation at {location}: {error.message}")
    except Exception as exc:  # noqa: BLE001
        fail(instance_path, f"schema validation could not complete: {exc}")


# Any tracked JSON/JSONC instance declaring a repository-relative $schema is
# validated automatically. Remote meta-schema references on schema documents are
# intentionally not fetched.
for path, value in parsed.items():
    if path in schemas or not isinstance(value, dict):
        continue
    schema_ref = value.get("$schema")
    if not isinstance(schema_ref, str):
        continue
    parsed_uri = urlparse(schema_ref)
    if parsed_uri.scheme in {"http", "https"}:
        continue
    schema_path = (path.parent / schema_ref).resolve()
    if not schema_path.exists():
        fail(path, f"declared local schema does not exist: {schema_ref}")
        continue
    validate_instance(value, schema_path, path)

context_schema_path = (root / "schemas" / "context-document.schema.json").resolve()
context_schema = schemas.get(context_schema_path)
if context_schema is None:
    fail("schemas/context-document.schema.json", "context metadata schema is unavailable or invalid")

curated_roots = (
    "docs/context/",
    "docs/design/",
    "docs/features/",
    "docs/research/",
    "docs/spikes/",
)
reserved = {"docs/context/index.md", "docs/context/log.md"}
frontmatter_by_path: dict[Path, dict] = {}
ids: dict[str, Path] = {}
deprecated_fields = {"created", "modified", "verified"}
status_values = {"active", "proposed", "draft", "deferred", "superseded", "deprecated", "archived"}

for path in tracked_existing:
    relative = rel(path)
    if path.suffix.lower() != ".md" or not relative.startswith(curated_roots):
        continue

    text = read_text(path)
    if relative in reserved:
        if text.startswith("---\n") or text.startswith("---\r\n"):
            fail(path, "reserved index.md/log.md must not contain YAML frontmatter")
        continue

    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        fail(path, "curated Markdown requires YAML frontmatter")
        continue
    try:
        closing = next(index for index in range(1, len(lines)) if lines[index].strip() == "---")
    except StopIteration:
        fail(path, "frontmatter opening delimiter has no closing delimiter")
        continue

    raw_frontmatter = "\n".join(lines[1:closing])
    try:
        metadata = yaml.safe_load(raw_frontmatter)
    except Exception as exc:  # noqa: BLE001
        fail(path, f"frontmatter is not valid YAML: {exc}")
        continue
    if not isinstance(metadata, dict):
        fail(path, "frontmatter must parse to an object")
        continue

    frontmatter_by_path[path.resolve()] = metadata
    for field in sorted(deprecated_fields.intersection(metadata)):
        fail(path, f"deprecated metadata field is forbidden: {field}")

    if context_schema is not None:
        validate_instance(metadata, context_schema_path, path, label="frontmatter")

    doc_id = metadata.get("id")
    if isinstance(doc_id, str):
        previous = ids.get(doc_id)
        if previous:
            fail(path, f"duplicate document id {doc_id}; already used by {rel(previous)}")
        else:
            ids[doc_id] = path

    expected_prefix = None
    if relative.startswith("docs/design/"):
        expected_prefix = "DESIGN-"
    elif relative.startswith("docs/features/"):
        expected_prefix = "FEAT-"
    elif relative.startswith("docs/research/"):
        expected_prefix = "RESEARCH-"
    elif relative.startswith("docs/spikes/"):
        expected_prefix = "SPIKE-"

    if expected_prefix:
        if not isinstance(doc_id, str) or not re.fullmatch(re.escape(expected_prefix) + r"\d{3}", doc_id):
            fail(path, f"documents in this directory require an id matching {expected_prefix}NNN")
        if expected_prefix == "SPIKE-" and isinstance(doc_id, str) and not path.name.startswith(doc_id):
            fail(path, f"spike filename must begin with its id {doc_id}")

    if metadata.get("status") not in status_values:
        fail(path, "frontmatter status is outside the repository lifecycle vocabulary")

    sources = metadata.get("sources")
    if isinstance(sources, list):
        for index, source in enumerate(sources):
            if not isinstance(source, dict):
                continue
            resource = source.get("resource")
            if not isinstance(resource, str) or not resource.strip():
                continue
            uri = urlparse(resource)
            if uri.scheme in {"http", "https"}:
                continue
            source_target = (path.parent / unquote(resource.split("#", 1)[0])).resolve()
            if not source_target.exists():
                fail(path, f"sources[{index}].resource does not resolve: {resource}")

# Resolve repository-local Markdown links. External URLs and same-document anchors
# are outside this deterministic repository check.
link_pattern = re.compile(r"(?<!!)\[[^\]]*\]\(([^)]+)\)")
for path in tracked_existing:
    if path.suffix.lower() != ".md":
        continue
    text = read_text(path)
    for match in link_pattern.finditer(text):
        raw_target = match.group(1).strip()
        if not raw_target or raw_target.startswith("#"):
            continue
        if raw_target.startswith("<") and raw_target.endswith(">"):
            raw_target = raw_target[1:-1]
        target_without_anchor = raw_target.split("#", 1)[0].strip()
        uri = urlparse(target_without_anchor)
        if uri.scheme in {"http", "https", "mailto", "tel"}:
            continue
        if not target_without_anchor:
            continue
        decoded = unquote(target_without_anchor)
        target = (root / decoded.lstrip("/")) if decoded.startswith("/") else (path.parent / decoded)
        if not target.resolve().exists():
            fail(path, f"internal Markdown link does not resolve: {raw_target}")

# Validate document references recorded in machine-readable project state.
state_path = (root / ".portable-opencode" / "state.json").resolve()
state = parsed.get(state_path)
if isinstance(state, dict):
    def walk_state(value: object, key: str | None = None) -> None:
        if isinstance(value, dict):
            for child_key, child_value in value.items():
                walk_state(child_value, child_key)
        elif isinstance(value, list):
            for child in value:
                walk_state(child, key)
        elif isinstance(value, str) and key in {"document", "documents", "design", "schema"}:
            candidate = (root / value).resolve()
            # State also contains symbolic design/status strings; only path-like values are checked.
            if ("/" in value or "\\" in value or value.endswith((".md", ".json", ".jsonc"))) and not candidate.exists():
                fail(state_path, f"state reference does not resolve: {value}")

    walk_state(state)

# Deterministic private-boundary checks on tracked paths. This intentionally avoids
# heuristic secret-value scanning that could produce false positives in documentation.
allowed_portable_state = {
    ".portable-opencode/state.json",
    ".portable-opencode/state.schema.json",
    ".portable-opencode/verification.json",
}
private_basenames = {".env", "id_rsa", "id_ed25519"}
private_suffixes = {".pem", ".key", ".p12", ".pfx"}
for relative in sorted(tracked_rel):
    lower = relative.lower()
    path = Path(relative)
    if lower.startswith(".portable-opencode/") and relative not in allowed_portable_state:
        fail(relative, "unexpected private portable state is tracked")
    if path.name.lower() in private_basenames and not path.name.lower().endswith(".example"):
        fail(relative, "secret-bearing filename must not be tracked")
    if path.suffix.lower() in private_suffixes:
        fail(relative, "private key/certificate material must not be tracked")
    if lower.startswith("graphify-out/cache/") or lower.endswith("graphify-out/cost.json"):
        fail(relative, "private/disposable Graphify output must not be tracked")

if warnings:
    print("Repository validation warnings:")
    for warning in warnings:
        print(f"  WARN  {warning}")

if errors:
    print(f"Repository validation failed with {len(errors)} error(s):")
    for error in errors:
        print(f"  ERROR {error}")
    sys.exit(1)

print("Repository validation passed.")
print(f"  tracked files: {len(tracked_existing)}")
print(f"  parsed JSON/JSONC: {len(parsed)}")
print(f"  checked schemas: {len(schemas)}")
print(f"  curated frontmatter documents: {len(frontmatter_by_path)}")
print(f"  unique document ids: {len(ids)}")
'@

$validator | & $python.Path - $repoRoot
$exitCode = $LASTEXITCODE
if ($exitCode -ne 0) {
    exit $exitCode
}

exit 0
