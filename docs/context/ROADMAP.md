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

- [x] migrate inherited context frontmatter and validate `schemas/context-document.schema.json`;
- [x] publish and synchronize the full personal-first specification v0.3 and obtain owner approval;
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
- [x] define guided, resumable, browser-assisted installation and native secret custody;
- [x] approve `DESIGN-001` after these contracts are reviewable.

### New contract artefacts

```text
DESIGN-007  Managed Configuration Materialization
DESIGN-008  Canonical Resource Catalog and File Trees
DESIGN-009  CLI Operation Contracts
DESIGN-010  Evidence and Spike Mapping
DESIGN-011  PowerShell Script Inventory
DESIGN-012  Codex Development Orchestration
DESIGN-013  Guided Installation and Onboarding

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

The operational-contract, spike-definition, repository-metadata migration, specification v0.3 synchronization, owner-approval and first-green-remote-CI portions of Phase 0 are complete. Formal closure still depends on the remaining evidence-gated technical decisions and implementation readiness.

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

Result: [SPIKE-000 result](../spikes/results/SPIKE-000_RESULT.md) is `INCONCLUSIVE / partially supported`. Work Packages, Receipts, bounded worker behavior, fresh behavioral review and safe negative routing are usable, while named-role selection, structural role identity and runtime depth enforcement remain unproven in Codex CLI `0.153.4`.

### Repository-validation gate

After `SPIKE-000` establishes how Codex orchestration actually behaves:

```text
migrate inherited metadata (complete)
→ run scripts/verify-docs.ps1 (passed locally)
→ obtain the first green repository CI (passed on GitHub run 34339325620)
```

The completed metadata migration was bounded housekeeping and did not redesign context policy.

### SPIKE-001 — OpenCode lifecycle

Canonical brief: [`docs/spikes/SPIKE-001_OPENCODE_LIFECYCLE.md`](../spikes/SPIKE-001_OPENCODE_LIFECYCLE.md)

Result: [`SPIKE-001_RESULT.md`](../spikes/results/SPIKE-001_RESULT.md) is `INCONCLUSIVE` and remains bounded to `opencode-ai@1.18.30`. `PASS`: native installation/version detection, exercised config discovery/merge/provenance layers, `.opencode/` asset discovery, permissions, local server startup, synthetic session records, plugin config-hook loading, copied/rendered materialization and disposable junction creation. `FAIL`: symbolic-link creation under the tested Windows privilege/developer-mode state. `INCONCLUSIVE`: rules loading, real command/subtask and skill invocation, LSP usefulness, watcher events, compaction/context-limit metadata, session recovery and adversarial model behavior. `NOT TESTED`: auth-store mechanics, provider-backed turns, formatter execution, managed settings and organization configuration. These observations are evidence for contract review only; they do not generalize beyond the tested version or change the canonical root `opencode.jsonc` policy.

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

Result: [`SPIKE-002.md`](../spikes/results/SPIKE-002.md) is `INCONCLUSIVE`. Official API and local normalization evidence is recorded, but authenticated preset lifecycle, OpenCode representation, tool/routing smoke tests and live privacy/usage fields remain blocked. The concrete preset manifest stays pending.

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

Result: [`SPIKE-004.md`](../spikes/results/SPIKE-004.md) is `PARTIAL`. Graphify `0.9.56` and RTK `0.48.0` were installed and exercised in native Windows disposable fixtures. Core extraction, ignore semantics, clone/update, relative-path manifest portability, RTK rewriting, exclusions, private failure tee and degraded operation were evidenced; determinism, corruption recovery, hooks and provider-backed OpenCode hook invocation remain partial or deferred as stated in the result. The Graphify report requires `PYTHONHASHSEED=0` for deterministic tie ordering; corrupt graphs require a full rebuild; hooks remain deferred because they are asynchronous and write private logs. The final Graphify allowlist is `graph.json`, `GRAPH_REPORT.md` and conditional validated `manifest.json`; no Graphify MCP or alternate RTK filter is introduced.

### Current technical-validation gate

- `SPIKE-001`: `INCONCLUSIVE`, version-scoped to `opencode-ai@1.18.30`; no OpenCode component promotion follows from configuration-only evidence.
- `SPIKE-002`: `INCONCLUSIVE`; only official documentation and local synthetic normalization evidence are available. The exact authenticated gate is defined in [`SPIKE-002.md`](../spikes/results/SPIKE-002.md).
- `SPIKE-004`: `PARTIAL`; only Graphify `0.9.56` and RTK `0.48.0` are promoted in `config/components.jsonc`.
- `SPIKE-003`: defined, blocked and not started until the authenticated SPIKE-002 gate is complete; Phoenix remains pending.

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
- the canonical local repository validator and the CI adapter both pass after the controlled metadata migration;
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
`DESIGN-013` is the first-machine installation contract: public GitHub Releases, an external acquisition gate followed by a transactional minimal PowerShell bootstrap, strictly non-mutating preflight, private checkpoints, native OpenCode authentication, a mandatory authenticated re-inspection/second approval and final doctor. It does not resolve evidence-gated package or runtime choices.

## 5. Phase 3 — Personal machine installation

Build:

```text
portable-opencode install
portable-opencode observability start|stop|status|open|purge
```

Converge the global OpenCode environment, authentication, three managed OpenRouter presets, RTK, Graphify, proxy, proposed Phoenix backend, backups and health state.

The installation order, browser-assisted handoff, retry/resume semantics, optional GitHub/Git/SSH module and `healthy`/`degraded`/`blocked` meanings are governed by [`DESIGN-013`](../design/GUIDED_INSTALLATION_AND_ONBOARDING.md). Public GitHub Releases are the initial distribution channel; exact package mechanics remain under `DEC-012`.

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
