---
type: Operations
title: Portable OpenCode Development Operations
description: Personal-first workflow for understanding, changing, verifying and handing off the repository.
status: active
---

# Operations

## 1. Operating objective

Move from intent to a verified repository change with the least process that preserves safety, evidence and continuity.

```text
orient
→ define outcome
→ inspect evidence
→ plan
→ change
→ verify
→ synchronize
→ close
```

## 2. Current operating mode

The repository is in definition and **contract design**.

Binding facts:

- Windows native, PowerShell and Windows Terminal;
- root `opencode.jsonc` plus `.opencode/` assets;
- native agents plus non-mutating `review`/`verify`;
- `main`, `reason`, `fast` semantic roles;
- Graphify minimal output allowlist;
- minimal context metadata schema;
- declarative three-preset reconciliation;
- explicit managed-resource materialization and proven-ownership mutation;
- proposed native Phoenix lifecycle with private SQLite and 30-day retention;
- the TUI is deferred;
- all owner-level defaults are resolved;
- `DEC-009`, `DEC-010` and `DEC-012` remain evidence-gated;
- metadata migration is pending, so `docs-only` has not passed.

## 3. Starting a session

Read the smallest authoritative set:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. task-specific source documents;
5. accepted, proposed and superseded relevant decisions.

Identify observable outcome, owning source, required evidence and Windows constraints.

## 4. Evidence discipline

```text
current repository context
→ accepted decisions
→ current primary upstream documentation
→ bounded Windows-native experiment
→ implementation fixtures and tests
```

Do not infer unsupported surfaces, duplicate native capabilities, commit every generated artefact or add metadata without a consumer.

## 5. Standard workflow

### Orient
Read state and relevant sources.

### Define outcome
Describe an observable result rather than an activity.

### Inspect evidence
Use official documentation and reproducible PowerShell experiments. For a reported defect, first reproduce it through the closest feasible end-user or end-to-end path; otherwise record why reproduction is unavailable and what evidence substitutes for it.

### Plan
Identify files, decisions, risks, validation and rollback/discard boundary.

### Change
Make the smallest coherent change. Avoid profiles, unsupported paths, duplicate agents, unused abstractions, hidden platform expansion, unnecessary generated output and false implementation claims. Never hand-edit generated artefacts: change their canonical source, generator or inputs and regenerate them. Preserve unrelated findings for a separate change unless they block the current outcome.

### Verify
Match checks to risk:

- docs: metadata schema, reserved files, links and state consistency;
- config: schema, discovery, precedence, provenance, materialization, ownership and drift;
- agents: modes, permissions and invocation;
- presets: normalized diff, versioning, tools, privacy and fallback;
- observability: protocol, redaction, PIDs, ports, retention, storage, context pressure and compaction correlation where available;
- Graphify: scope, allowlist, determinism and manifest portability;
- Windows: paths, quoting, exit codes, processes and locked files;
- security: denied actions, redaction and backups.

### Synchronize
Update only sources whose meaning changed.

### Close
Leave verified state, explicit gaps and one discoverable next action.

## 6. Metadata migration

The accepted schema applies immediately to new and substantially edited documents.

Repository-wide migration:

1. remove `created`, `modified` and generic `verified`;
2. remove frontmatter from `index.md` and `log.md`;
3. convert only material `sources` to `{resource, title}` objects;
4. delete non-material source lists;
5. preserve IDs and status;
6. validate against `schemas/context-document.schema.json`;
7. repair links without rewriting bodies.

Use an isolated branch and do not mark `docs-only` successful until all checks pass.

## 7. Git and Codex

Use direct `main` for low-risk documentation/state synchronization. Use branches for spikes, executable work, migrations and risky changes. PRs are useful when review, CI or Codex work benefits from an explicit merge boundary.

Delegate only bounded tasks specifying outcome, sources, decisions, scope, forbidden operations, required Windows evidence, expected documentation/state updates and branch boundary.

## 8. Spike workflow

Each spike records question, relevance, hypotheses, tested versions, reproducible procedure, evidence, limitations, decision impact, recommendation and discard boundary.

- SPIKE-001: OpenCode lifecycle;
- SPIKE-002: OpenRouter presets and policy;
- SPIKE-003: proxy and Phoenix acceptance;
- SPIKE-004: Graphify and RTK.

A spike validates mechanism; it does not silently redesign policy.

## 9. Verification profiles

### Active: `docs-only`

Pending metadata migration, link checks, schema validation, decision/state consistency and secret scan.

### Future: `repo`

Formatting, linting, type checking, unit/integration tests, schema validation and build.

### Future: `canonical-journey`

```text
clean Windows
→ inspect and plan
→ install
→ healthy environment
→ scaffold and initialize
→ ready project
→ rerun without corruption
→ later session recovers state
```

## 10. Failure, recovery and secrets

Stop broad mutation, preserve original errors, detect partial changes, restore known backups, mark state honestly, provide narrow remediation and avoid blind retries.

Never version credentials, real `.env`, SSH keys, private overrides, observability databases, raw traces, Graphify cost/query logs, caches or unsanitized failure output.

## 11. Current next sequence

1. translate DESIGN-007 into concrete global/project resource manifests and schemas;
2. define CLI commands, diagnostics, outputs and the minimal PowerShell bootstrap/recovery scripts;
3. create missing state and resource schemas;
4. execute metadata migration and validation;
5. map matrix evidence gates to spikes/tests;
6. synchronize specification v0.3;
7. approve the matrix and delegate SPIKE-001 through SPIKE-004.
