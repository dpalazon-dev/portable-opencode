---
type: Design
id: DESIGN-011
title: PowerShell Script Inventory
description: Minimal Windows script inventory and the boundary between bootstrap, repository validation, CLI lifecycle and break-glass recovery.
status: active
sources:
  - resource: CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
---

# PowerShell script inventory

## 1. Objective

Prevent PowerShell wrappers from becoming a second implementation of the portable lifecycle.

The canonical product remains the CLI. Scripts exist only where the CLI cannot yet exist, where repository development needs a small local helper, or where a future packaging failure proves that break-glass recovery cannot be performed through the CLI itself.

## 2. Initial inventory

| Path | Status | Responsibility | Product behaviour? |
|---|---|---|---|
| `scripts/bootstrap.ps1` | required | make the pinned CLI runnable after clone | bootstrap only |
| `scripts/verify-docs.ps1` | implemented repository helper | validate this repository's Markdown metadata, links and JSON/JSONC schemas before the production CLI exists | no |
| `scripts/recover-cli.ps1` | deferred | break-glass repair of a missing/corrupt CLI installation only if final packaging proves it necessary | only if DEC-012 evidence requires it |

No other PowerShell wrapper is part of the initial contract.

## 3. `bootstrap.ps1`

Binding behaviour is defined in `DESIGN-009`.

It may establish the CLI and verify that it starts. It must not install/configure OpenCode, reconcile OpenRouter, manage Graphify/RTK/Phoenix, scaffold projects or write portable lifecycle state beyond bootstrap-specific private evidence required by the accepted packaging mechanism.

## 4. `verify-docs.ps1`

This is a development helper for the `portable-opencode` repository while the CLI does not yet implement repository verification.

Implemented checks:

```text
required/minimal frontmatter
reserved index.md/log.md without frontmatter
JSON and JSONC parsing
repository-owned JSON Schema validation
internal Markdown link resolution
source-resource resolution
forbidden deprecated metadata
document ID uniqueness/directory conventions
machine-readable state path references
deterministic private-file boundary checks
```

Rules:

- it is deterministic and non-mutating;
- it does not become a generated-project dependency;
- schema definitions remain in repository schema files rather than being duplicated in PowerShell;
- repository-validation dependencies are isolated in `scripts/requirements-docs.txt` and are development tooling, not product runtime dependencies;
- when the CLI later owns equivalent validation, keep the script only as a thin invocation wrapper or remove it;
- do not duplicate schema definitions inside PowerShell.

### CI execution

`.github/workflows/ci.yml` is intentionally a thin adapter:

```text
pull request or push to main
→ windows-latest
→ checkout
→ provision Python used only by the repository validator
→ install pinned scripts/requirements-docs.txt
→ run scripts/verify-docs.ps1
```

The workflow contains no parallel validation rules. Local and CI validation therefore use the same repository helper.

The temporary Python validation dependencies do not resolve `DEC-009`; they are pre-implementation repository tooling only. Product language/runtime remains evidence-gated.

## 5. `recover-cli.ps1`

Do not implement this script yet.

Create it only if `DEC-012` evidence shows a realistic failure mode where:

- the CLI binary/package is unavailable or corrupt;
- normal `portable-opencode plan/apply/doctor` cannot run;
- the bootstrap path cannot safely restore the CLI;
- a narrowly scoped break-glass wrapper materially improves recovery.

If created later, it may repair only the CLI installation itself. It must not repair managed OpenCode/OpenRouter/project state directly.

## 6. Verification and recovery ownership

Normal verification belongs to:

```text
portable-opencode doctor
portable-opencode project doctor
.opencode/agents/verify.md
.portable-opencode/verification.json
```

Normal recovery belongs to:

```text
inspect
→ plan
→ apply
→ doctor
```

and accepted component lifecycle commands such as observability start/stop/purge.

PowerShell is not a parallel recovery engine.

## 7. Completion gate

This inventory is complete for pre-spike delegation when:

- SPIKE-001 knows it must determine the minimum bootstrap primitives;
- no spike is allowed to add convenience scripts as canonical product surface;
- repository validation runs through the same `verify-docs.ps1` locally and in CI;
- break-glass recovery remains evidence-gated rather than speculative.
