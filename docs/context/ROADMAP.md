---
type: Roadmap
title: Portable OpenCode Roadmap
description: Ordered delivery path from specification to a usable new-project MVP.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - PROJECT.md
  - VISION.md
  - DECISIONS.md
verified:
  - by: repository-owner
    status: pending
---

# Roadmap

The roadmap is ordered by uncertainty reduction and architectural dependency. Dates are intentionally omitted until the implementation shape is validated.

## Phase 0 — Canonical project context

**Goal:** make the repository understandable and operable without relying on conversation history.

Deliverables:

- [x] public repository;
- [x] conceptual specification v0.2;
- [x] root `AGENTS.md`;
- [x] curated context documents;
- [x] initial decision log;
- [x] machine-readable project state;
- [x] first `.graphifyignore` policy;
- [ ] automated documentation validation;
- [ ] repository issue backlog derived from open decisions.

Exit criteria:

- context documents have clear responsibilities;
- current state and future vision are separated;
- accepted and proposed decisions are explicit;
- another agent can identify the next step from repository files.

## Phase 1 — Configuration matrix

**Goal:** translate the specification into implementable configuration ownership.

Deliverables:

- matrix of OpenCode features and settings;
- global versus project versus private ownership;
- default values and override mechanisms;
- generated versus static configuration;
- validation criteria;
- user questions and decision points;
- OpenRouter semantic role manifest;
- initial state schema.

Exit criteria:

- every MVP capability has a source of truth;
- duplicated responsibility is identified;
- implementation tasks can be cut without inventing behaviour.

## Phase 2 — Technical spikes

**Goal:** resolve the highest-risk assumptions before committing architecture.

### SPIKE-001 — OpenCode extension and configuration lifecycle

Validate:

- configuration precedence;
- project/global agents and tools;
- plugin events;
- session identifiers and metadata;
- command orchestration;
- permissions and compaction hooks.

### SPIKE-002 — OpenRouter policy and semantic roles

Validate:

- presets or equivalent stable aliases;
- provider routing and fallbacks;
- session affinity;
- usage and cost metadata;
- privacy controls;
- API capabilities needed for doctor checks.

### SPIKE-003 — Local observability

Validate:

- transparent proxying and streaming;
- tool-call payloads;
- Phoenix ingestion and UI;
- trace correlation with OpenCode events;
- redaction and metadata-only mode;
- local resource use and Windows setup.

### SPIKE-004 — Graphify lifecycle

Validate:

- install and update commands;
- incremental graph behaviour;
- hook integration;
- `.graphifyignore` composition;
- output format and quality metrics;
- cross-platform reliability.

Exit criteria:

- each proposed foundational decision is accepted, revised or rejected with evidence;
- architecture uncertainties are reduced to implementation risks.

## Phase 3 — CLI and state foundation

**Goal:** create the minimal reliable lifecycle engine.

Deliverables:

- CLI skeleton;
- configuration and state schemas;
- profile loading;
- deterministic template rendering;
- filesystem change planning;
- dry-run support;
- idempotent install state;
- structured diagnostics;
- unit and integration test foundation.

Exit criteria:

- CLI can inspect and explain intended changes;
- state transitions are tested;
- rerunning an operation does not corrupt state.

## Phase 4 — Global installation MVP

**Goal:** configure a machine for the canonical workflow.

Deliverables:

- `portable-opencode install`;
- `portable-opencode doctor`;
- OpenCode global configuration;
- OpenRouter key and policy checks;
- RTK and Graphify checks;
- observability lifecycle commands;
- safe backup and upgrade behaviour.

Exit criteria:

- clean supported environment reaches `installed`;
- failures produce actionable remediation;
- secrets remain outside versioned files.

## Phase 5 — New-project scaffold MVP

**Goal:** prepare an empty directory for interactive project definition.

Deliverables:

- `portable-opencode init-project <path>`;
- Git initialization;
- project context templates;
- local OpenCode configuration;
- `.opencode/` base assets;
- provisional `.graphifyignore`;
- project state;
- initial verification profile.

Exit criteria:

- identical inputs produce an equivalent scaffold;
- the operation is idempotent or safely refuses unsafe repetition;
- the project clearly reports `scaffolded`, not `ready`.

## Phase 6 — Interactive `/init-project`

**Goal:** transform a scaffold into a runnable, understood and verified project.

Deliverables:

- structured project interview;
- context completion;
- stack profile selection;
- minimal application generation;
- LSP, formatter and verification setup;
- final `.gitignore` and `.graphifyignore`;
- initial graph generation and audit;
- native OpenCode `/init` integration;
- ready-state validation.

Exit criteria:

- a fixture project reaches `ready` only when all criteria pass;
- ambiguous graph decisions are persisted;
- verification commands are canonical and executable.

## Phase 7 — Session continuity and maintenance

**Goal:** make the environment useful beyond initial bootstrap.

Deliverables:

- graph dirty/update lifecycle;
- project status command;
- context consistency review;
- compaction preservation;
- handoff workflow;
- session and project cost commands;
- upgrade and migration path.

Exit criteria:

- another session can recover current work reliably;
- stale graph or context is visible;
- version upgrades preserve or migrate project state safely.

## Deferred roadmap

- adoption of existing repositories;
- team workspaces and shared policies;
- Langfuse or remote observability profiles;
- GitHub automation;
- MCP profiles;
- local model profiles;
- template marketplace;
- enterprise governance;
- background agents.
