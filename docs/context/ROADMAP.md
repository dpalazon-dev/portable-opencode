---
type: Roadmap
title: Portable OpenCode Roadmap
description: Personal-first delivery path from validated design to a complete CLI-driven workflow.
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

The roadmap preserves the full canonical scope while ordering it around one usable personal path:

```text
define
→ verify upstream surfaces
→ build a small CLI core
→ configure the personal machine
→ initialize a new project
→ support daily continuity
→ harden and release
```

A phase must produce an observable capability or remove a material uncertainty. Documentation, schemas, templates and scripts are deliverables when they directly enable that path.

The Ratatui configuration TUI is parked until the CLI can install, inspect, plan, apply, diagnose and initialize effectively.

## 2. Phase 0 — Canonical specification and design

**Goal:** make implementation possible without asking an agent to invent product behaviour.

### Product and context

- [x] public repository and root `AGENTS.md`;
- [x] personal-first `PROJECT.md`, `VISION.md` and `ARCHITECTURE.md`;
- [x] minimal `CONVENTIONS.md` and `OPERATIONS.md`;
- [x] accepted decisions and machine-readable project state;
- [x] canonical context index and concise log;
- [ ] publish the complete canonical specification in GitHub;
- [ ] revise the specification to a personal-first v0.3 after matrix approval.

### Configuration design

- [x] initial broad configuration matrix;
- [x] research current official configuration surfaces;
- [ ] approve the reduced personal-first configuration matrix;
- [ ] define the canonical configuration file tree;
- [ ] define generated, copied, linked and private file ownership;
- [ ] define the local override mechanism;
- [ ] define JSON Schemas for portable configuration and state;
- [ ] define the OpenRouter semantic-role and preset manifest;
- [ ] define the managed-resource inventory used for backup and upgrades.

### Command and script design

- [ ] define the CLI command contract;
- [ ] define the exact responsibility of each command;
- [ ] inventory installation and verification scripts;
- [ ] define PowerShell and shell wrapper boundaries for the primary environment;
- [ ] define exit codes, machine-readable output and diagnostic codes.

### Exit criteria

- every MVP capability has one owner and one configuration surface;
- upstream-documented behaviour is separated from behaviour requiring a spike;
- the CLI and scripts can be implemented from explicit contracts;
- no TUI, team or generic-profile requirement blocks the path.

## 3. Phase 1 — Technical validation

**Goal:** validate only the upstream behaviours that materially affect architecture.

### SPIKE-001 — OpenCode configuration lifecycle

Validate:

- global and project configuration precedence;
- chosen project configuration location;
- discovery of rules, agents, commands and skills;
- permission merging and command-pattern behaviour;
- provider options for OpenRouter;
- plugin lifecycle and stability;
- session and command metadata available for observability.

### SPIKE-002 — OpenRouter policy

Validate:

- semantic roles implemented through presets;
- preset create, update, version and verification workflow;
- provider routing and fallback options passed through OpenCode;
- model fallback behaviour;
- tool and parameter compatibility;
- privacy options and Zero Data Retention routing;
- usage, cost, cache and resolved-model metadata.

### SPIKE-003 — Local observability

Validate:

- transparent OpenAI-compatible proxying from OpenCode to OpenRouter;
- streaming, tool calls, structured output and errors;
- metadata-only and redaction policy;
- correlation of project, session, agent and command identifiers;
- OTLP/OpenInference export to local Phoenix;
- start, stop, health, retention and bypass behaviour;
- resource use on the primary machine.

### SPIKE-004 — Graphify and RTK lifecycle

Validate:

- Graphify and RTK installation on the primary environment;
- documented OpenCode integrations;
- `.gitignore` and `.graphifyignore` semantics;
- first graph generation and quality audit;
- explicit graph update workflow;
- optional hook behaviour after explicit updates are stable;
- RTK rewrite exclusions, failure tee output and diagnostics.

### Exit criteria

- each spike is reproducible;
- each uncertain matrix row is accepted, revised or deferred;
- implementation language and packaging can be selected with evidence;
- no production abstraction is created inside a spike.

## 4. Phase 2 — CLI, configuration and state foundation

**Goal:** build the smallest reliable engine that can explain and apply desired state.

### Repository implementation shape

- select implementation language, runtime and package manager;
- create the source, schema, template, script, fixture and test structure;
- keep external tools behind narrow adapters;
- keep OpenCode extensions in their native form.

### Core contracts

- canonical personal configuration model;
- local override model;
- environment and project state schemas;
- findings, plans, operations, outcomes and diagnostic codes;
- managed-resource inventory;
- versioned schema and migration markers.

### CLI foundation

Implement:

```text
portable-opencode status
portable-opencode inspect
portable-opencode plan
portable-opencode apply
portable-opencode doctor
```

Required behaviour:

- deterministic plans;
- dry-run and explain output;
- backups before replacement;
- idempotent re-execution;
- structured JSON output;
- actionable failures;
- safe interruption boundaries;
- no dependency on a TUI.

### Exit criteria

- fixture environments produce deterministic plans;
- applying a plan updates state and managed resources coherently;
- a second run produces a no-op or an explained drift result;
- schemas and core behaviour have automated tests.

## 5. Phase 3 — Personal machine installation

**Goal:** reproduce the canonical global environment on the owner's supported machine.

### CLI and scripts

Implement:

```text
portable-opencode install
portable-opencode doctor
portable-opencode status
portable-opencode observability start|stop|status
```

### Managed global configuration

- supported OpenCode installation and version check;
- global `opencode.jsonc`;
- global `AGENTS.md`;
- canonical global agents, commands and skills;
- permissions baseline;
- OpenCode TUI preferences;
- OpenRouter authentication check;
- semantic preset reconciliation;
- RTK installation and OpenCode integration;
- Graphify installation and OpenCode integration;
- local observability proxy and Phoenix lifecycle;
- backups and drift reporting.

### Exit criteria

- a clean supported environment reaches `healthy`;
- secrets remain in documented private stores;
- `doctor` identifies missing or divergent components;
- OpenCode can execute a test request through the selected OpenRouter policy;
- RTK and Graphify integrations are verifiably active;
- observability can be disabled only as an explicit degraded mode.

## 6. Phase 4 — New-project bootstrap

**Goal:** turn an empty directory into an understood, runnable and verifiable agentic project.

### Deterministic scaffold

Implement:

```text
portable-opencode init-project <path>
portable-opencode project status
portable-opencode project doctor
```

Generate or configure:

- Git repository when absent;
- project `AGENTS.md`;
- `docs/context/`;
- local OpenCode config and assets;
- project state;
- stack-detection result;
- provisional `.gitignore` and `.graphifyignore`;
- verification command manifest;
- initial application baseline when selected.

### Semantic initialization in OpenCode

Provide `/init-project` to:

- establish purpose and constraints;
- select or confirm stack;
- define architecture and conventions;
- reconcile native `/init`;
- install dependencies;
- configure LSP and formatter;
- refine ignore files;
- build and audit the first Graphify graph;
- run canonical verification;
- persist unresolved decisions;
- move the project to `ready` only when gates pass.

### Exit criteria

- identical inputs create an equivalent scaffold;
- the project distinguishes `scaffolded`, `configuring`, `ready`, `dirty`, `degraded` and `blocked`;
- the first graph and context are useful rather than merely present;
- the generated project passes its verification manifest.

## 7. Phase 5 — Daily continuity and maintenance

**Goal:** make the environment useful after initialization.

Implement explicit workflows for:

- project and environment status;
- graph freshness and explicit updates;
- context consistency review;
- handoff and compaction continuity;
- verification after significant changes;
- session, model, provider, token and cost inspection;
- configuration drift;
- component health;
- safe upgrade and schema migration;
- restoration from managed backups.

Exit criteria:

- a new session can recover current intent, state and next action;
- stale graph, invalid context or degraded observability is visible;
- upgrades preserve explicit personal overrides and private boundaries;
- no daily workflow depends on undocumented manual steps.

## 8. Phase 6 — Hardening and first release

**Goal:** prove the complete personal path and make it maintainable.

Deliverables:

- documentation and schema validation;
- unit and integration tests;
- adapter contract tests;
- disposable project fixtures;
- end-to-end test from clean supported machine to ready project;
- failure and recovery scenarios;
- secret and trace-redaction checks;
- supported-version manifest;
- installation and recovery documentation;
- versioning and release notes;
- first tagged release.

Exit criteria:

- the canonical path is reproducible without conversation history;
- reruns, failures and upgrades do not corrupt managed state;
- upstream version assumptions are explicit;
- the owner can install and use the system as the default personal workflow.

## 9. Parked work

### Configuration TUI

`FEAT-001` and Ratatui are deferred until all of the following are true:

- the CLI contracts are stable;
- installation and `doctor` work end to end;
- plans and diagnostics are already structured;
- repeated CLI use reveals interaction problems that a TUI would materially solve.

Only then should the feature be re-evaluated. It is not part of the implementation-language decision or first release gate.

### Other deferred directions

- existing-repository adoption;
- additional personal profiles;
- team and organization policy;
- universal operating-system parity;
- MCP profiles;
- local-model profiles;
- alternate observability backends;
- GitHub automation;
- marketplaces;
- autonomous background agents;
- hosted control planes.
