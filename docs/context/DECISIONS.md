---
type: Decision Log
title: Portable OpenCode Decisions
description: Accepted, proposed and deferred product and architecture decisions.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../SPECIFICATION.es.md
  - PROJECT.md
  - VISION.md
  - ARCHITECTURE.md
verified:
  - by: repository-owner
    status: pending
---

# Decisions

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
| DEC-011 | proposed | Adopt a practical subset of OKF-like metadata |
| DEC-012 | deferred | Final packaging and distribution mechanism |
| DEC-013 | deferred | Defer the configuration TUI until the CLI is effective |
| DEC-014 | accepted | Design personal-first and allow reuse by others |

---

## DEC-001 — Configure OpenCode and OpenRouter as one coherent system

**Status:** accepted  
**Date:** 2026-08-04

OpenCode is the runtime and interaction surface. OpenRouter is the control plane for models, providers, routing, privacy, fallbacks and cost.

**Consequences**

- both systems are required for the canonical environment;
- semantic model roles belong to the design;
- configuration and verification must cover both systems.

---

## DEC-002 — Prefer native capabilities before custom extensions

**Status:** accepted  
**Date:** 2026-08-04

Use native OpenCode, OpenRouter, Graphify, RTK and Phoenix surfaces before writing custom code.

Custom code requires a concrete missing lifecycle or integration capability.

**Consequences**

- agents, commands, skills, permissions, LSP and formatters remain native OpenCode assets;
- routing, fallbacks, privacy and presets remain OpenRouter policy;
- Graphify owns graph extraction;
- RTK owns output filtering;
- the portable core remains small.

---

## DEC-003 — Optimize the first version for new projects

**Status:** accepted  
**Date:** 2026-08-04

The first complete path targets empty or freshly initialized repositories.

Existing-repository adoption is a separate later workflow.

---

## DEC-004 — Treat Graphify as a core subsystem

**Status:** accepted  
**Date:** 2026-08-04

Graphify is installed from the beginning, but the first graph is generated after a useful source baseline exists.

`.graphifyignore`, graph freshness and graph quality are explicit project concerns.

**Consequences**

- ignore generation is analyzed, not copied blindly;
- explicit graph updates precede automatic hooks;
- stale or noisy graphs remain visible in project state.

---

## DEC-005 — Make observability local and metadata-first by default

**Status:** accepted  
**Date:** 2026-08-04

The canonical path includes a local observability boundary between OpenCode and OpenRouter.

Metadata, usage, cost, latency and errors are captured by default. Prompt and response content is not.

**Consequences**

- local services bind loopback;
- secrets are redacted before persistence;
- bypassing observability produces an explicit degraded state;
- Phoenix remains replaceable even if selected for the MVP.

---

## DEC-006 — Separate versioned, project and private state

**Status:** accepted  
**Date:** 2026-08-04

Maintain distinct ownership for:

1. canonical configuration versioned in this repository;
2. configuration and context versioned in generated projects;
3. credentials, traces, backups, caches and machine state kept private.

The CLI must explain where an effective value comes from.

---

## DEC-007 — Dogfood structured context in this repository

**Status:** accepted  
**Date:** 2026-08-04

The repository uses the same context, decision, state and graph concepts it intends to generate.

Unimplemented capabilities remain marked as proposed, deferred or inactive.

---

## DEC-008 — Keep MCPs and broad integrations outside the initial core

**Status:** accepted  
**Date:** 2026-08-04

MCPs, GitHub automation, remote servers, community catalogues, local-model profiles and autonomous background agents are not required by the first complete personal path.

They may return only after a real need appears.

---

## DEC-009 — Use TypeScript as the principal implementation language

**Status:** proposed  
**Date:** 2026-08-04

TypeScript is the leading option for the portable core, OpenCode extensions, schemas and generators because it aligns with OpenCode's ecosystem.

**Evidence required**

- simple installation on the primary environment;
- packaging without excessive runtime friction;
- reliable process and filesystem operations;
- startup, update and migration strategy.

The parked TUI does not influence this decision.

---

## DEC-010 — Use Arize Phoenix as the MVP observability backend

**Status:** proposed  
**Date:** 2026-08-04

Use Phoenix locally as the reference OTLP/OpenInference collector and trace UI.

**Evidence required**

- local installation and lifecycle;
- resource use;
- trace ingestion from the proxy;
- retention and redaction;
- primary-environment reliability.

Phoenix is not the transparent proxy itself.

---

## DEC-011 — Adopt a practical subset of OKF-like metadata

**Status:** proposed  
**Date:** 2026-08-04

Use only metadata that improves provenance, lifecycle and verification of curated context.

Full formal compliance is not an MVP goal.

**Evidence required**

- exact required fields;
- repository-owned schema;
- validation cost;
- demonstrated value over plain Markdown.

---

## DEC-012 — Final packaging and distribution mechanism

**Status:** deferred  
**Date:** 2026-08-04

Packaging depends on the selected implementation language, primary platform and upgrade model.

Candidate mechanisms include a packaged executable, package-manager command or small bootstrap wrapper.

The choice follows SPIKE-001 through SPIKE-004 and the CLI prototype.

---

## DEC-013 — Defer the configuration TUI until the CLI is effective

**Status:** deferred  
**Date:** 2026-08-05  
**Feature:** [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md)

A Ratatui configurator may eventually improve plan and diagnostic review, but it is secondary to a simple complete CLI.

**Decision**

- park Ratatui and remove SPIKE-005 from the active roadmap;
- do not let the TUI determine implementation language or core abstractions;
- first deliver working `status`, `inspect`, `plan`, `apply`, `doctor`, `install` and `init-project` workflows;
- reconsider the feature only after repeated CLI use reveals a concrete interaction problem.

**Preserved constraint**

A future TUI must remain an optional thin adapter over the same operations as the CLI.

---

## DEC-014 — Design personal-first and allow reuse by others

**Status:** accepted  
**Date:** 2026-08-05

The repository owner is the only user required for MVP acceptance.

The canonical configuration represents one real personal workflow. Public reuse is enabled through explicit, replaceable configuration, not through premature support for teams, profiles or universal platforms.

**Consequences**

- one canonical personal configuration;
- support the owner's primary environment first;
- no team, organization or marketplace architecture in the MVP;
- add configurability only for demonstrated needs;
- preserve safety, idempotence, diagnostics and explicit state because they improve personal maintainability.

## Open questions

- What is the primary supported environment and shell?
- Which implementation language and packaging approach survive the technical spikes?
- Which OpenCode project config form becomes canonical?
- Which agents and semantic roles are required initially?
- Which Graphify outputs are versioned?
- What is the minimal context metadata schema?
- How are OpenRouter presets reconciled in the first CLI?
- What Phoenix lifecycle and retention policy is acceptable?
