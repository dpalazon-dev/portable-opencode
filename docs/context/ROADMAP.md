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

The roadmap preserves the complete canonical scope while avoiding TUI, team, profile and cross-platform work that does not serve the first personal path.

The canonical environment is Windows native with PowerShell and Windows Terminal. OpenCode project configuration follows `DEC-017`: root `opencode.jsonc` plus native assets under `.opencode/`.

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
- [ ] approve the reduced personal-first matrix;
- [ ] define the complete canonical global and project file trees;
- [ ] define generated, copied, linked and private ownership;
- [ ] define the private local override mechanism;
- [ ] define JSON Schemas for portable configuration and state;
- [ ] define the OpenRouter semantic-role and preset manifest;
- [ ] define the managed-resource inventory for backups and upgrades.

### Command and script design

- [ ] define the CLI command contract;
- [ ] define each command's exact responsibility;
- [ ] inventory installation, verification and recovery scripts;
- [ ] define the PowerShell bootstrap boundary;
- [ ] define Windows path, quoting, process and exit-code conventions;
- [ ] define machine-readable output and diagnostic codes.

### Exit criteria

- every MVP capability has one owner and one real surface;
- native upstream behaviour is separated from spike work;
- canonical paths and conflict policies are explicit;
- CLI and PowerShell work can be implemented from bounded contracts.

## 3. Phase 1 — Technical validation

**Goal:** validate only behaviours that materially affect implementation.

### SPIKE-001 — OpenCode lifecycle

Validate on Windows without WSL:

- installation and version detection;
- global config at the effective Windows home;
- root project `opencode.jsonc` discovery;
- merge order between global, `OPENCODE_CONFIG`, project and inline config;
- `.opencode/` discovery for agents, commands, skills, plugins, tools and themes;
- detection of root `opencode.json`, dual root configs and misplaced `.opencode/opencode.json(c)`;
- `OPENCODE_CONFIG_DIR` asset behaviour;
- `%ProgramData%\opencode` managed settings when present;
- `AGENTS.md` discovery and precedence;
- permissions, shell `pwsh`, LSP, formatter, compaction and watcher behaviour;
- plugin stability and session metadata available for observability.

### SPIKE-002 — OpenRouter policy

Validate through the Windows-native OpenCode path:

- exact representation of `@preset/<slug>` in OpenCode;
- semantic roles implemented through presets;
- preset list, get, create and version workflow;
- provider routing and fallback behaviour;
- model fallbacks and required-parameter compatibility;
- privacy and ZDR routing;
- usage, cost, cache and resolved-model metadata.

### SPIKE-003 — Local observability

Validate:

- transparent OpenAI-compatible proxying;
- SSE streaming, tool calls, structured output and errors;
- metadata-only collection and redaction;
- project, session, agent and command correlation;
- OTLP/OpenInference export to Phoenix;
- native Windows start, stop, health, retention, port ownership and process cleanup;
- bypass and degraded-state behaviour.

### SPIKE-004 — Graphify and RTK

Validate:

- native Windows installation and upgrade paths;
- documented OpenCode integrations;
- `.gitignore` and `.graphifyignore` behaviour with Windows paths;
- first graph generation and quality audit;
- explicit graph update workflow;
- optional hooks after explicit updates are stable;
- RTK rewrite exclusions, failure tee output and diagnostics.

### Exit criteria

- every spike is reproducible from PowerShell;
- uncertain matrix rows are accepted, revised or deferred;
- implementation language and packaging can be chosen with Windows evidence;
- WSL-only success does not count.

## 4. Phase 2 — CLI, configuration and state foundation

**Goal:** build the smallest reliable engine that can explain and apply desired state.

### Repository implementation shape

- select language, runtime and package manager;
- create source, schema, template, PowerShell script, fixture and test structure;
- define Windows path, process and filesystem primitives once;
- keep external tools behind narrow adapters;
- keep OpenCode assets in their native forms.

### Core contracts

- canonical personal configuration model;
- private local override model;
- environment and project state schemas;
- findings, plans, operations, outcomes and diagnostics;
- managed-resource inventory;
- schema versions and migrations;
- configuration provenance including OpenCode overrides.

### CLI foundation

```text
portable-opencode status
portable-opencode inspect
portable-opencode plan
portable-opencode apply
portable-opencode doctor
```

Required properties:

- deterministic plans;
- dry-run and explain output;
- backups before replacement;
- idempotent reruns;
- structured JSON output;
- actionable failures;
- safe interruption boundaries;
- correct Windows path and quoting behaviour;
- no dependency on WSL or a TUI.

## 5. Phase 3 — Personal machine installation

**Goal:** reproduce the canonical global environment on the owner's Windows machine.

### Commands

```text
portable-opencode install
portable-opencode status
portable-opencode doctor
portable-opencode observability start|stop|status
```

### Managed global environment

- supported OpenCode installation and version check;
- global OpenCode runtime config;
- global `AGENTS.md` and required agents, commands and skills;
- permissions and shell baseline;
- optional owner TUI preferences;
- OpenRouter authentication and preset reconciliation;
- RTK native installation and OpenCode integration;
- Graphify native installation and OpenCode integration;
- localhost observability proxy and Phoenix lifecycle;
- backups, drift and provenance reporting.

### Exit criteria

- a clean supported Windows environment reaches `healthy` without WSL;
- secrets remain private;
- `doctor` explains missing, overridden or divergent components;
- OpenCode executes a test request through the selected OpenRouter policy;
- RTK, Graphify and observability are verifiably active or explicitly degraded.

## 6. Phase 4 — New-project bootstrap

**Goal:** turn an empty directory into an understood, runnable and verifiable agentic project.

### Deterministic scaffold

```text
portable-opencode init-project <path>
portable-opencode project status
portable-opencode project doctor
```

Generate or configure:

```text
<project>/
├── opencode.jsonc
├── AGENTS.md
├── .opencode/
│   ├── agents/      # only when required
│   ├── commands/    # only when required
│   ├── skills/      # only when required
│   ├── plugins/     # only when required
│   ├── tools/       # only when required
│   └── themes/      # only when required
├── docs/context/
├── .portable-opencode/
├── .gitignore
└── .graphifyignore
```

The scaffold must detect and handle:

- root `opencode.json` as a migration candidate;
- both root JSON and JSONC as blocking ambiguity;
- `.opencode/opencode.json(c)` as misplaced unmanaged files;
- active OpenCode environment overrides as provenance findings.

### Semantic `/init-project`

The OpenCode workflow will:

- establish purpose and constraints;
- confirm stack and architecture;
- reconcile native `/init` and `AGENTS.md`;
- install dependencies;
- configure LSP and formatter;
- create only required agents, commands, skills, plugins and tools;
- refine ignore files;
- build and audit the first Graphify graph;
- run canonical verification;
- persist unresolved decisions;
- move the project to `ready` only when gates pass.

### Exit criteria

- identical inputs create an equivalent scaffold;
- generated paths follow OpenCode's documented surfaces;
- Windows paths do not leak Unix assumptions;
- context, graph and verification are useful rather than merely present.

## 7. Phase 5 — Daily continuity and maintenance

Implement explicit workflows for:

- environment and project status;
- configuration provenance and drift;
- graph freshness and updates;
- context consistency and handoff;
- verification after significant changes;
- session, model, provider, token and cost inspection;
- component health;
- upgrades, schema migration and backup restoration;
- recovery after interrupted Windows processes or locked files.

## 8. Phase 6 — Hardening and first release

Deliver:

- documentation and schema validation;
- unit, integration and adapter contract tests;
- disposable project fixtures;
- clean-Windows end-to-end test to `healthy` environment and `ready` project;
- failure, recovery and redaction scenarios;
- supported Windows, PowerShell, OpenCode and dependency versions;
- installation, recovery, versioning and release documentation;
- first tagged release.

## 9. Parked work

- configuration TUI and Ratatui;
- WSL, Linux and macOS support;
- existing-repository adoption beyond simple detected migration cases;
- additional profiles;
- teams and organizations;
- MCP and local-model profiles;
- alternative observability backends;
- GitHub automation, marketplaces, background agents and hosted control planes.
