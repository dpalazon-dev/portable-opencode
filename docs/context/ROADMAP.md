---
type: Roadmap
title: Portable OpenCode Roadmap
description: Personal-first Windows-native delivery path from validated design to a complete CLI-driven workflow.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - PROJECT.md
  - VISION.md
  - ARCHITECTURE.md
  - CONVENTIONS.md
  - OPERATIONS.md
  - DECISIONS.md
  - ../SPECIFICATION.es.md
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
  - ../design/CONFIGURATION_MATRIX.md
  - ../design/AGENT_AND_MODEL_ROLES.md
  - ../design/GRAPHIFY_OUTPUT_POLICY.md
verified:
  - by: repository-owner
    status: pending
---

# Roadmap

## 1. Delivery principle

```text
define
→ verify upstream behaviour on Windows
→ build a small CLI core
→ configure the personal machine
→ initialize a new project
→ support daily continuity
→ harden and release
```

The canonical environment is Windows native with PowerShell and Windows Terminal. Project configuration uses root `opencode.jsonc` plus native `.opencode/` assets. Native OpenCode agents are reused; only `review` and `verify` are added. Graphify output follows a minimal versioned allowlist. The portable TUI remains parked.

## 2. Phase 0 — Canonical specification and design

**Goal:** make implementation possible without asking an agent to invent product behaviour.

### Product and context

- [x] public repository and root `AGENTS.md`;
- [x] personal-first project, vision and architecture;
- [x] minimal conventions and operations;
- [x] accepted decisions and machine-readable state;
- [x] Windows-native environment selected;
- [x] upstream configuration research completed and corrected;
- [x] reduced configuration matrix drafted;
- [ ] publish the complete canonical specification in GitHub;
- [ ] revise the specification to personal-first v0.3 after matrix approval.

### Configuration design

- [x] choose root `opencode.jsonc` as project runtime config;
- [x] choose `.opencode/` as project asset root;
- [x] preserve native `build`, `plan`, `general`, `explore` and `scout`;
- [x] define custom `review` and `verify` subagents;
- [x] define `main`, `reason` and `fast` semantic roles;
- [x] define Graphify versioned output allowlist;
- [ ] define minimal context metadata;
- [ ] decide Phoenix lifecycle and retention;
- [ ] decide first-CLI OpenRouter preset reconciliation;
- [ ] approve the reduced personal-first matrix;
- [ ] define complete canonical global and project file trees;
- [ ] define generated, copied, linked and private ownership;
- [ ] define private local override mechanism;
- [ ] define JSON Schemas for portable configuration and state;
- [ ] define the preset intent manifest and managed-resource inventory.

### Command and script design

- [ ] define the CLI command contract;
- [ ] define each command's exact responsibility;
- [ ] inventory installation, verification and recovery scripts;
- [ ] define PowerShell bootstrap, path, quoting, process and exit-code conventions;
- [ ] define machine-readable output and diagnostic codes.

### Exit criteria

- every MVP capability has one owner and one real surface;
- canonical paths, agents, roles, graph ownership and conflict policies are explicit;
- technical mechanisms are separated from product defaults;
- CLI and PowerShell work can be implemented from bounded contracts.

## 3. Phase 1 — Technical validation

**Goal:** validate behaviours that materially affect implementation.

### SPIKE-001 — OpenCode lifecycle

Validate on Windows without WSL:

- installation and version detection;
- global config in the effective Windows home;
- root project `opencode.jsonc` discovery and merge order;
- `.opencode/` asset discovery;
- built-in agent availability and customization;
- Markdown `review` and `verify` discovery;
- primary/subagent modes, task permissions and permission merge order;
- `/review` and `/verify` subtask commands;
- root config conflicts, environment overrides and managed settings;
- `AGENTS.md`, `pwsh`, LSP, formatter, compaction and watcher behaviour;
- plugin stability and session metadata.

### SPIKE-002 — OpenRouter policy

Validate:

- exact OpenCode representation of `@preset/<slug>`;
- `portable-main`, `portable-reason` and `portable-fast` mapping;
- agent-to-role mapping and `small_model`;
- preset list, get, create and version workflow;
- provider routing, model fallbacks and required-parameter compatibility;
- privacy, ZDR, usage, cost, cache and resolved-model metadata.

### SPIKE-003 — Local observability

Validate transparent proxying, streaming, tool calls, errors, metadata-only redaction, correlation, Phoenix ingestion, native Windows lifecycle, retention, ports and process cleanup.

### SPIKE-004 — Graphify and RTK

Validate:

- native installation and OpenCode integrations;
- ignore semantics and explicit graph updates;
- exact output set and deterministic regeneration;
- portability and private-path safety of `manifest.json`;
- clone plus incremental-update behaviour;
- repository size and diff churn;
- exclusion of `graphify-out/` from graph input;
- RTK exclusions, failure tee output and recovery;
- optional hooks only after explicit updates are reliable.

### Exit criteria

- every spike is reproducible from PowerShell;
- uncertain matrix contracts are accepted, revised or deferred;
- implementation language and packaging can be chosen with evidence;
- WSL-only success does not count.

## 4. Phase 2 — CLI, configuration and state foundation

**Goal:** build the smallest engine that explains and applies desired state.

- select language, runtime and package manager from spike evidence;
- create source, schema, template, PowerShell script, fixture and test structure;
- define Windows path, process and filesystem primitives;
- implement canonical configuration, local overrides, state schemas, plans, diagnostics, resource inventory, provenance and migrations;
- retain native OpenCode and Graphify assets rather than wrapping them.

Initial commands:

```text
portable-opencode status
portable-opencode inspect
portable-opencode plan
portable-opencode apply
portable-opencode doctor
```

Required properties include deterministic plans, backups, idempotence, JSON output, actionable failures, safe interruption and no WSL/TUI dependency.

## 5. Phase 3 — Personal machine installation

**Goal:** reproduce the canonical global environment on Windows.

Commands:

```text
portable-opencode install
portable-opencode status
portable-opencode doctor
portable-opencode observability start|stop|status
```

Manage supported OpenCode, global rules/assets, safe permissions, OpenRouter authentication and three-preset reconciliation, RTK/Graphify integrations, localhost observability, backups, drift and provenance.

## 6. Phase 4 — New-project bootstrap

**Goal:** turn an empty directory into an understood, runnable and verifiable project.

```text
<project>/
├── opencode.jsonc
├── AGENTS.md
├── .opencode/
│   ├── agents/review.md
│   ├── agents/verify.md
│   ├── commands/review.md
│   ├── commands/verify.md
│   └── ... only required assets
├── docs/context/
├── .portable-opencode/
├── graphify-out/
│   ├── graph.json
│   ├── GRAPH_REPORT.md
│   └── manifest.json
├── .gitignore
└── .graphifyignore
```

`init-project` handles OpenCode config conflicts and provenance, generates the Graphify allowlist, and excludes `graphify-out/` from source extraction.

The semantic `/init-project` workflow confirms purpose, stack, architecture, dependencies, LSP, formatter, required assets, ignore files, first Graphify graph and canonical verification before `ready`.

## 7. Phase 5 — Daily continuity and maintenance

Implement environment/project status, provenance, drift, graph freshness, explicit graph synchronization, context review, handoff, verification, model/provider/token/cost inspection, health, upgrades, migrations, backups and Windows process recovery.

## 8. Phase 6 — Hardening and first release

Deliver documentation/schema checks, unit/integration/contract tests, disposable fixtures, clean-Windows E2E, recovery/redaction scenarios, supported-version manifest, installation/recovery docs, versioning and the first tagged release.

## 9. Parked work

- configuration TUI and Ratatui;
- WSL, Linux and macOS support;
- broad legacy-repository adoption;
- additional agents or semantic roles without repeated evidence;
- additional Graphify exports without a repeated personal use;
- profiles, teams and organizations;
- MCP/local-model profiles;
- alternate observability backends;
- GitHub automation, marketplaces, background agents and hosted control planes.
