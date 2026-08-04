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
- [x] first independently reviewable feature definition;
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
- initial state schema;
- presentation-independent operation and diagnostic concepts required by CLI and future TUI.

Exit criteria:

- every MVP capability has a source of truth;
- duplicated responsibility is identified;
- implementation tasks can be cut without inventing behaviour;
- configuration and lifecycle concepts do not depend on a specific interface.

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

### SPIKE-005 — Ratatui and application boundary

Feature reference: [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md).

Validate:

- Ratatui behaviour on Windows Terminal and the initial Unix terminal matrix;
- separation between model/update/view state and domain operations;
- structured progress and safe cancellation;
- terminal restoration after exit, failure and interruption;
- non-TTY fallback;
- shared plan and diagnostic contracts with the headless CLI;
- packaging consequences of a Rust core versus a separate Rust frontend;
- minimum useful views and measurable benefit over guided prompts.

The prototype is limited to a doctor view, an install-plan review and a profile selector backed by fixture or serialized application data.

Exit criteria:

- each proposed foundational decision is accepted, revised or rejected with evidence;
- architecture uncertainties are reduced to implementation risks;
- DEC-013 and FEAT-001 are updated from spike evidence.

## Phase 3 — CLI and state foundation

**Goal:** create the minimal reliable lifecycle engine.

Deliverables:

- presentation-independent application engine;
- CLI skeleton;
- configuration and state schemas;
- profile loading;
- deterministic template rendering;
- filesystem change planning;
- dry-run support;
- idempotent install state;
- structured diagnostics;
- structured progress and operation outcomes;
- machine-readable output;
- safe cancellation boundaries;
- unit and integration test foundation.

Exit criteria:

- CLI can inspect and explain intended changes;
- state transitions are tested;
- rerunning an operation does not corrupt state;
- presentation layers can consume plans and diagnostics without duplicating mutation logic.

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
- secrets remain outside versioned files;
- the full workflow remains usable without a TUI.

## Phase 4.5 — First-party configuration TUI

**Goal:** add a guided Ratatui frontend over stable installation, planning and diagnostic operations.

Deliverables:

- home and environment status view;
- profile selection;
- install-plan review;
- operation progress and failure reporting;
- doctor findings and remediation actions;
- safe exit, cancellation and terminal recovery;
- headless CLI equivalence tests.

Exit criteria:

- the TUI performs no direct filesystem or process mutations;
- equivalent inputs produce equivalent CLI and TUI plans;
- non-TTY execution never launches the TUI;
- secrets are redacted;
- supported terminal smoke tests pass;
- DEC-013 is accepted, revised or rejected based on evidence.

This phase may move later if the application-engine contracts are not stable enough. It must not block the headless installation MVP.

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
- initial verification profile;
- optional TUI projection for deterministic scaffold choices after FEAT-001 foundation is validated.

Exit criteria:

- identical inputs produce an equivalent scaffold;
- the operation is idempotent or safely refuses unsafe repetition;
- the project clearly reports `scaffolded`, not `ready`;
- TUI and CLI paths, when both exist, use the same scaffold plan.

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

The semantic interview remains an OpenCode agent workflow rather than a rigid TUI form.

## Phase 7 — Session continuity and maintenance

**Goal:** make the environment useful beyond initial bootstrap.

Deliverables:

- graph dirty/update lifecycle;
- project status command;
- context consistency review;
- compaction preservation;
- handoff workflow;
- session and project cost commands;
- upgrade and migration path;
- optional TUI views for pending decisions and repair operations.

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
- background agents;
- observability dashboards inside the portable TUI;
- Graphify visualization inside the portable TUI;
- OpenCode session management inside the portable TUI.
