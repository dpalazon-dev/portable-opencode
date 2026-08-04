---
type: Decision Log
title: Portable OpenCode Decisions
description: Accepted, proposed and deferred architectural and product decisions.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - ../SPECIFICATION.es.md
  - PROJECT.md
  - ARCHITECTURE.md
verified:
  - by: repository-owner
    status: pending
---

# Decisions

This file records durable decisions. It does not replace detailed ADR files if individual decisions later require deeper treatment.

## Decision index

| ID | Status | Decision |
|---|---|---|
| DEC-001 | accepted | Configure OpenCode and OpenRouter as one coherent system |
| DEC-002 | accepted | Prefer native capabilities before custom extensions |
| DEC-003 | accepted | Optimize the first version for new projects |
| DEC-004 | accepted | Treat Graphify as a core subsystem |
| DEC-005 | accepted | Make observability local and metadata-first by default |
| DEC-006 | accepted | Separate versioned, project and private state |
| DEC-007 | accepted | Dogfood structured context in this repository |
| DEC-008 | accepted | Keep MCPs and broad integrations outside the initial core |
| DEC-009 | proposed | Use TypeScript as the principal implementation language |
| DEC-010 | proposed | Use Arize Phoenix as the MVP observability backend |
| DEC-011 | proposed | Adopt a practical subset of OKF for context metadata |
| DEC-012 | deferred | Final packaging and distribution mechanism |
| DEC-013 | proposed | Provide an optional first-party configuration TUI with Ratatui |

---

## DEC-001 — Configure OpenCode and OpenRouter as one coherent system

**Status:** accepted  
**Date:** 2026-08-04

### Context

The product was initially described too narrowly as an OpenCode distribution. Its distinctive behaviour depends equally on OpenRouter policy, routing, privacy, cost and provider selection.

### Decision

Define the product as a portable configuration system for **OpenCode + OpenRouter**, with OpenCode as runtime and OpenRouter as model control plane.

### Consequences

- product documentation must represent both components;
- semantic model roles become a core abstraction;
- OpenRouter validation and policy belong in the repository architecture;
- the system is not complete when only OpenCode files are installed.

---

## DEC-002 — Prefer native capabilities before custom extensions

**Status:** accepted  
**Date:** 2026-08-04

### Context

OpenCode already provides agents, commands, skills, plugins, tools, permissions, LSP, formatters, watcher and compaction.

### Decision

Use native OpenCode and OpenRouter features first. Add custom code only for an identified gap or cross-component lifecycle need.

### Consequences

- less duplication and maintenance;
- custom components require a documented purpose;
- implementation must track upstream capability changes.

---

## DEC-003 — Optimize the first version for new projects

**Status:** accepted  
**Date:** 2026-08-04

### Decision

The MVP targets empty or freshly created repositories. Existing-repository adoption is a later workflow.

### Consequences

- initialization can make stronger assumptions;
- migration and legacy compatibility are deferred;
- acceptance tests should use disposable new projects.

---

## DEC-004 — Treat Graphify as a core subsystem

**Status:** accepted  
**Date:** 2026-08-04

### Decision

Install Graphify from the beginning, generate and refine `.graphifyignore`, maintain graph state and audit graph quality throughout the project lifecycle.

### Consequences

- Graphify is not an optional post-install enhancement in the canonical profile;
- ignore decisions and graph freshness require persisted state;
- Graphify output itself must not create watcher loops or repository noise.

---

## DEC-005 — Make observability local and metadata-first by default

**Status:** accepted  
**Date:** 2026-08-04

### Decision

Place a transparent local observability layer between OpenCode and OpenRouter. Store data locally, bind UI to loopback and capture metadata, usage, cost and errors by default. Full prompt and response content requires explicit opt-in.

### Consequences

- privacy is the default posture;
- bypassing the proxy creates a visible degraded state;
- secrets must be redacted before persistence;
- the backend must remain replaceable.

---

## DEC-006 — Separate versioned, project and private state

**Status:** accepted  
**Date:** 2026-08-04

### Decision

Maintain explicit boundaries between:

1. configuration versioned in this repository;
2. configuration generated into each project;
3. credentials, traces, caches and private local state that never enter Git.

### Consequences

- generators and schemas must reflect ownership boundaries;
- secrets cannot be copied from repository templates;
- diagnostics must explain where each setting originates.

---

## DEC-007 — Dogfood structured context in this repository

**Status:** accepted  
**Date:** 2026-08-04

### Decision

Use `AGENTS.md`, `docs/context/`, explicit decisions, machine state and `.graphifyignore` in the repository developing portable-opencode itself.

### Consequences

- the project becomes the first test case for its own concepts;
- context consistency is part of task completion;
- unimplemented pieces must remain honestly marked as inactive.

---

## DEC-008 — Keep MCPs and broad integrations outside the initial core

**Status:** accepted  
**Date:** 2026-08-04

### Decision

Do not require MCPs, public session sharing, GitHub automation, remote servers, community plugin catalogues or autonomous background agents in the MVP.

### Consequences

- smaller core and clearer responsibility boundaries;
- these capabilities may return as optional profiles;
- the design must not prevent future extension.

---

## DEC-009 — Use TypeScript as the principal implementation language

**Status:** proposed  
**Date:** 2026-08-04

### Proposal

Use TypeScript for the CLI domain layer, OpenCode plugins, custom tools, generators and schemas, with small platform wrappers where necessary.

### Rationale

It aligns with OpenCode extension mechanisms and supports typed configuration and distribution.

### Evidence still required

- packaging and single-command installation on Windows, macOS and Linux;
- runtime choice and startup overhead;
- interaction with Bun/Node requirements;
- update strategy.

---

## DEC-010 — Use Arize Phoenix as the MVP observability backend

**Status:** proposed  
**Date:** 2026-08-04

### Proposal

Use Phoenix locally behind a transparent proxy as the reference observability backend.

### Evidence still required

- local installation complexity;
- OpenRouter request and streaming compatibility;
- OpenInference/OTLP trace model fit;
- resource usage;
- retention and redaction controls;
- Windows experience.

A spike must precede acceptance.

---

## DEC-011 — Adopt a practical subset of OKF for context metadata

**Status:** proposed  
**Date:** 2026-08-04

### Proposal

Use OKF-compatible Markdown and frontmatter concepts for provenance, lifecycle, sources and verification without requiring full formal compliance in the MVP.

### Evidence still required

- exact required fields;
- validation tooling;
- cost of maintaining compatibility;
- benefit over a repository-owned schema.

---

## DEC-012 — Final packaging and distribution mechanism

**Status:** deferred  
**Date:** 2026-08-04

### Open options

- npm package with executable;
- Bun-distributed executable;
- shell/PowerShell bootstrap downloading versioned artefacts;
- platform packages;
- hybrid installer.

### Deferral reason

The choice depends on the implementation language, platform matrix and update/migration model.

---

## DEC-013 — Provide an optional first-party configuration TUI with Ratatui

**Status:** proposed  
**Date:** 2026-08-04  
**Feature:** [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md)

### Context

The system will coordinate configuration across OpenCode, OpenRouter, local observability, Graphify, RTK, generated project context and machine-readable lifecycle state. Sequential prompts and raw command output can perform these operations, but they become difficult to understand when choices are interdependent or when the user must compare current and desired state.

A first-party TUI could make installation, configuration, plan review, diagnostics, repair and deterministic project scaffolding more observable and safer. It would become counterproductive if it duplicated the lifecycle engine, replaced OpenCode or made headless execution secondary.

### Proposal

Provide an optional first-party terminal interface using **Ratatui** for configuration and lifecycle workflows.

The TUI will be a presentation adapter over the same application engine used by the headless CLI. It will not own configuration rules, state transitions, filesystem mutations or process execution.

The conventional and non-interactive CLI remains mandatory. The TUI is not required for CI, remote automation or non-TTY environments.

### Product position

Classify the TUI as a **strategic first-party frontend, optional at runtime and subsequent to the core lifecycle engine**.

The initial useful scope is limited to:

- overall environment status;
- profile selection;
- install-plan inspection;
- operation progress and failure reporting;
- doctor findings and safe remediation;
- deterministic project-scaffold configuration.

It must not replace:

- the OpenCode TUI and agent conversation;
- Phoenix or another observability explorer;
- Graphify visualization;
- the semantic `/init-project` interview inside OpenCode.

### Architectural constraints

- the shared application engine must exist before the TUI;
- CLI and TUI must produce equivalent plans for equivalent inputs;
- UI components may not directly mutate files or execute commands;
- all operations require structured state, progress and outcomes;
- non-TTY execution must never attempt to launch the TUI;
- secrets must be redacted before reaching the view;
- terminal state must recover after normal exit, failure and cancellation.

### Relationship to implementation language

Ratatui introduces material evidence in favour of Rust for the CLI and lifecycle engine, but this decision does not settle the language of the whole repository.

`SPIKE-005` must compare:

1. a shared Rust core, CLI and TUI;
2. a separate Rust TUI over a non-Rust core.

A split runtime must not be adopted without evidence that its flexibility outweighs its packaging and protocol complexity.

### Evidence still required

- Windows Terminal, Linux and macOS behaviour in the supported matrix;
- terminal resize, keyboard input and clean restoration;
- asynchronous progress and safe cancellation;
- plan and diagnostic contracts shared with the CLI;
- packaging implications of Ratatui and Rust;
- accessibility limitations and fallback quality;
- measured reduction in configuration error compared with guided CLI prompts;
- a minimal screen set that adds value without creating a second OpenCode.

### Acceptance condition

This decision may move to `accepted` only after:

- the application-engine boundary is specified;
- the headless CLI remains independently usable;
- `SPIKE-005` validates the Ratatui approach on the initial platform matrix;
- the feature acceptance criteria in `FEAT-001` are reviewed and considered proportionate.

### Consequences if accepted

- Ratatui becomes a supported first-party frontend;
- the core must expose presentation-independent plans, diagnostics, progress and outcomes;
- packaging decisions must account for the Rust boundary;
- UI testing and terminal compatibility enter the supported quality model;
- richer dashboards and unrelated interfaces remain outside the feature scope.

## Open questions

- What exact configuration matrix defines the MVP?
- Which OpenCode versions and interfaces will be supported first?
- How will semantic OpenRouter roles be represented and synchronized?
- How is the OpenCode session identifier propagated to the proxy?
- What Graphify update strategy is reliable across platforms?
- Is Windows native the primary path, or should WSL be recommended initially?
- Which files and behaviours are generated versus linked from the portable repository?
- What is the smallest useful OKF-compatible metadata schema?
- Does Ratatui justify a Rust application core, or only a separate presentation adapter?
- Should invoking `portable-opencode` without arguments open the TUI or display CLI help?
