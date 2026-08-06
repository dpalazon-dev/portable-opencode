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
- [ ] define canonical global and project file trees;
- [x] define generated, copied, linked, queried and private ownership;
- [ ] instantiate those rules as concrete managed-resource manifests;
- [ ] define the private local override file and precedence;
- [ ] create the supported-component version manifest before implementation;
- [ ] create `.portable-opencode/state.schema.json`;
- [ ] define environment state and managed-resource schemas;
- [ ] create the concrete OpenRouter preset manifest after SPIKE-002 model-policy evidence;
- [ ] define diagnostic codes, operation outcomes and exit classes;
- [ ] define exact CLI commands, arguments and non-interactive behaviour;
- [ ] inventory PowerShell bootstrap, verification and recovery scripts;
- [ ] map every `S` contract to a spike or implementation test;
- [ ] approve `DESIGN-001` after these contracts are reviewable.

### Exit criteria

- every managed file has one owner and lifecycle;
- every CLI command has an explicit input, plan, mutation and output contract;
- schemas exist for machine-edited state and manifests;
- no product default is left for an implementation agent to guess;
- SPIKE-001 through SPIKE-004 can be assigned as bounded experiments.

## 3. Phase 1 — Technical validation

### SPIKE-001 — OpenCode lifecycle

Validate on Windows:

- install/version detection;
- global and root project config discovery and precedence;
- `.opencode/` assets;
- built-in/custom agents, commands and permissions;
- environment and managed override provenance;
- copied, rendered and linked materialization behaviour on Windows;
- `pwsh`, LSP, formatter, compaction and watcher behaviour;
- plugin stability, parallel-session usability and session/context metadata;
- context-pressure and compaction visibility without fabricated estimates.

### SPIKE-002 — OpenRouter policy

Validate:

- exact OpenCode representation of presets;
- three role/preset mappings;
- preset normalization and idempotent reconciliation;
- create/new-version APIs and partial failure;
- routing, fallbacks, tools, privacy and usage metadata.

### SPIKE-003 — Observability

Validate `DESIGN-005`:

- isolated native Phoenix installation;
- proxy transparency and OTLP HTTP ingestion;
- loopback, SQLite and 30-day retention;
- telemetry/external-resource disabling;
- correlation of inference usage with reliable context-pressure and compaction metadata when OpenCode exposes it;
- start, stop, PIDs, ports, locked files and recovery;
- acceptable resource use.

Accept or reject `DEC-010` from evidence.

### SPIKE-004 — Graphify and RTK

Validate:

- native installation and integrations;
- ignore semantics and explicit updates;
- Graphify output determinism and manifest portability;
- clone/incremental update behaviour;
- RTK rewriting, exclusions, tee output and recovery;
- optional hooks only after explicit workflows are reliable.

### Exit criteria

- all spikes reproduce from PowerShell without WSL;
- uncertain matrix contracts become accepted, revised or deferred;
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
- extra agents, roles or Graphify exports without repeated evidence;
- profiles, teams and organizations;
- MCP/local-model profiles;
- alternate observability backends unless Phoenix fails its gate;
- GitHub automation, marketplaces, background agents and hosted control planes;
- general dotfiles, editor, shell, font or desktop personalization;
- a terminal multiplexer or multi-harness session manager unless repeated use proves a gap.
