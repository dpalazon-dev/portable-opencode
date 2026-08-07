---
type: Roadmap
title: Portable OpenCode Roadmap
description: Personal-first Windows-native delivery path from validated design to a complete CLI-driven workflow.
status: active
---

# Roadmap

## 1. Delivery principle

```text
define contracts
→ validate the Codex development factory
→ close repository-validation housekeeping
→ verify upstream behaviour on Windows
→ build a small CLI core
→ configure the personal machine
→ initialize a new project
→ support daily continuity
→ harden and release
```

All owner-level product defaults are resolved. Language, packaging and Phoenix acceptance are evidence-gated rather than preference questions.

## 2. Phase 0 — Canonical specification and contracts

**Goal:** make implementation possible without asking an agent to invent product behaviour.

### Completed product defaults

- [x] personal-first scope;
- [x] Windows native, PowerShell and Windows Terminal;
- [x] root `opencode.jsonc` plus `.opencode/` assets;
- [x] native OpenCode agents plus `review` and `verify`;
- [x] `main`, `reason` and `fast` semantic roles;
- [x] Graphify minimal versioned output allowlist;
- [x] minimal context metadata schema;
- [x] Phoenix intended Windows lifecycle and 30-day retention;
- [x] declarative OpenRouter preset reconciliation;
- [x] explicit managed-resource materialization and proven-ownership mutation;
- [x] configuration matrix reduced to 81 contracts.

### Contract work remaining

- [ ] migrate inherited context frontmatter and validate `schemas/context-document.schema.json`;
- [ ] publish and synchronize the full personal-first specification v0.3;
- [x] define canonical global and project file trees;
- [x] define generated, copied, linked, queried and private ownership;
- [x] instantiate those rules as concrete environment/project resource catalogs;
- [x] define the private local override file and precedence;
- [x] create the evidence-gated supported-component manifest before implementation;
- [x] create `.portable-opencode/state.schema.json`;
- [x] define private environment state, managed-resource, inventory and verification schemas;
- [ ] create the concrete OpenRouter preset manifest after SPIKE-002 model-policy evidence;
- [x] define diagnostic codes, operation outcomes and exit classes;
- [x] define exact CLI commands, arguments and non-interactive behaviour;
- [x] inventory PowerShell bootstrap, repository verification and break-glass recovery boundaries;
- [x] map every `S` contract to a spike or implementation test;
- [x] write executable briefs for SPIKE-001 through SPIKE-004;
- [x] define repository-local Codex master/specialist orchestration, Work Packages and Receipts;
- [x] write executable `SPIKE-000` to validate the Codex development hierarchy before relying on it;
- [ ] approve `DESIGN-001` after these contracts are reviewable.

### New contract artefacts

```text
DESIGN-007  Managed Configuration Materialization
DESIGN-008  Canonical Resource Catalog and File Trees
DESIGN-009  CLI Operation Contracts
DESIGN-010  Evidence and Spike Mapping
DESIGN-011  PowerShell Script Inventory
DESIGN-012  Codex Development Orchestration

config/components.jsonc
config/resources/environment.jsonc
config/resources/project.jsonc

.portable-opencode/state.schema.json
schemas/environment-state.schema.json
schemas/managed-resource.schema.json
schemas/managed-resource-inventory.schema.json
schemas/resource-catalog.schema.json
schemas/operation-result.schema.json
schemas/supported-components.schema.json
schemas/verification-manifest.schema.json
schemas/codex-work-package.schema.json
schemas/codex-task-receipt.schema.json
```

### Exit criteria

- every managed file has one owner and lifecycle;
- every CLI command has an explicit input, plan, mutation and output contract;
- schemas exist for machine-edited state and manifests;
- no product default is left for an implementation agent to guess;
- SPIKE-001 through SPIKE-004 can be assigned as bounded runtime experiments;
- Codex development work has one explicit master, bounded specialist roles and machine-checkable delegation/receipt contracts.

The operational-contract and spike-definition portions of Phase 0 are complete. Metadata migration, specification v0.3 synchronization and owner approval of the resulting matrix remain before Phase 0 is formally closed.

## 3. Phase 1 — Technical validation

### Development preflight — SPIKE-000

Canonical brief: [`docs/spikes/SPIKE-000_CODEX_ORCHESTRATION.md`](../spikes/SPIKE-000_CODEX_ORCHESTRATION.md)

Before assigning runtime spikes to Codex, validate the development factory itself:

- repository-local `.codex/config.toml` discovery;
- `development-orchestrator` discovery/invocation;
- named specialist discovery/invocation;
- parent-mediated depth-1 behavior;
- Work Package validation;
- worker Receipt round trip;
- fresh independent `code-reviewer`;
- observable failure rather than silent role substitution when routing is unavailable.

This is a development-process gate, not a product runtime contract. If partially supported, record exactly which guarantees are structural versus prompt/policy enforced. If it fails, do not autonomously build a custom dispatcher.

### Repository-validation gate

After `SPIKE-000` establishes how Codex orchestration actually behaves:

```text
migrate inherited metadata
→ run scripts/verify-docs.ps1
→ obtain the first green repository CI
```

The metadata migration remains bounded housekeeping and must not redesign context policy.

### SPIKE-001 — OpenCode lifecycle

Canonical brief: [`docs/spikes/SPIKE-001_OPENCODE_LIFECYCLE.md`](../spikes/SPIKE-001_OPENCODE_LIFECYCLE.md)

Validate on Windows:

- install/version detection;
- global and root project config discovery and precedence;
- `.opencode/` assets;
- built-in/custom agents, commands and permissions;
- environment and managed override provenance;
- copied, rendered and linked materialization behaviour on Windows;
- `pwsh`, LSP, formatter, compaction and watcher behaviour;
- plugin stability, parallel-session usability and session/context metadata;
- context-pressure and compaction visibility without fabricated estimates;
- minimum bootstrap constraints for the future CLI.

### SPIKE-002 — OpenRouter policy

Canonical brief: [`docs/spikes/SPIKE-002_OPENROUTER_POLICY.md`](../spikes/SPIKE-002_OPENROUTER_POLICY.md)

Validate:

- exact OpenCode representation of presets;
- three role/preset mappings;
- preset normalization and idempotent reconciliation;
- create/new-version APIs and partial failure;
- routing, fallbacks, tools, privacy and usage metadata.

### SPIKE-003 — Observability

Canonical brief: [`docs/spikes/SPIKE-003_OBSERVABILITY.md`](../spikes/SPIKE-003_OBSERVABILITY.md)

Validate `DESIGN-005`:

- isolated native Phoenix installation;
- proxy transparency and OTLP HTTP ingestion;
- loopback, SQLite and 30-day retention;
- telemetry/external-resource disabling;
- correlation of inference usage with reliable context-pressure and compaction metadata when OpenCode exposes it;
- metadata-only persistence and redaction;
- start, stop, PIDs, ports, locked files and recovery;
- acceptable resource use.

Accept or reject `DEC-010` from evidence.

### SPIKE-004 — Graphify and RTK

Canonical brief: [`docs/spikes/SPIKE-004_GRAPHIFY_RTK.md`](../spikes/SPIKE-004_GRAPHIFY_RTK.md)

Validate:

- native installation and integrations;
- ignore semantics and explicit updates;
- Graphify output determinism and manifest portability;
- clone/incremental update behaviour;
- graph quality and private-output boundaries;
- RTK rewriting, exclusions, tee output and recovery;
- optional hooks only after explicit workflows are reliable.

### Recommended execution order

```text
SPIKE-000
→ metadata migration + green CI
→ SPIKE-001
→ SPIKE-002
→ SPIKE-004
→ SPIKE-003
```

SPIKE-002 and SPIKE-004 may run in parallel after SPIKE-001 if branch and global-configuration isolation are preserved. `DESIGN-010` owns the complete product contract-to-evidence map; `DESIGN-012` owns the Codex development-orchestration preflight.

### Exit criteria

- Codex development orchestration is either validated or its exact routing limitations are recorded before runtime delegation;
- repository validation reaches green after the controlled metadata migration;
- all runtime spikes reproduce from PowerShell without WSL;
- uncertain matrix contracts become accepted, revised or deferred;
- exact tested versions/mechanisms replace `pending` entries in `config/components.jsonc` only from evidence;
- `DEC-009`, `DEC-010` and `DEC-012` are resolved from evidence;
- no spike code is mistaken for production architecture.

## 4. Phase 2 — CLI, configuration and state foundation

Build:

```text
portable-opencode status
portable-opencode inspect
portable-opencode plan
portable-opencode apply
portable-opencode doctor
```

Required properties:

- deterministic plans and provenance;
- no mutation during inspect/plan;
- backups and managed-resource inventory with proven ownership;
- no replacement, detachment or removal of unmanaged or ambiguous resources;
- idempotent reruns and drift reporting;
- structured JSON and stable exit codes;
- safe interruption and partial outcomes;
- native Windows path/process primitives;
- schema validation and automated tests;
- no TUI or WSL dependency.

`DESIGN-009` is the command contract; implementation must not silently expand the initial CLI surface.

## 5. Phase 3 — Personal machine installation

Build:

```text
portable-opencode install
portable-opencode observability start|stop|status|open|purge
```

Converge the global OpenCode environment, authentication, three managed OpenRouter presets, RTK, Graphify, proxy, proposed Phoenix backend, backups and health state.

A clean supported Windows environment must reach `healthy` or explain a precise blocked/degraded state.

## 6. Phase 4 — New-project bootstrap

Build:

```text
portable-opencode init-project <path>
portable-opencode project status
portable-opencode project doctor
```

Generate canonical OpenCode config/assets, context, state, verification manifest, Graphify ignores and versioned output policy. `/init-project` completes semantic context, stack, application baseline, LSP/formatter, first graph and readiness verification.

## 7. Phase 5 — Daily continuity and maintenance

Support provenance, drift, graph freshness, context review, compaction/handoff, verification, cost inspection, health, upgrades, migrations, backup restoration and Windows process recovery.

## 8. Phase 6 — Hardening and first release

Deliver documentation/schema validation, unit/integration/contract tests, disposable fixtures, clean-Windows E2E, security/redaction/recovery scenarios, supported-version compatibility verification, installation/recovery docs and the first tagged release.

## 9. Parked work

- Ratatui configuration TUI;
- WSL, Linux and macOS support;
- broad legacy-repository adoption;
- extra product agents, roles or Graphify exports without repeated evidence;
- profiles, teams and organizations;
- MCP/local-model profiles;
- alternate observability backends unless Phoenix fails its gate;
- GitHub product automation, marketplaces, background agents and hosted control planes;
- general dotfiles, editor, shell, font or desktop personalization;
- a terminal multiplexer or multi-harness session manager unless repeated use proves a gap.
