---
type: Knowledge Log
title: Portable OpenCode Context Log
description: Concise chronological record of meaningful project transitions.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - index.md
verified:
  - by: repository-owner
    status: pending
---

# Context log

This log records outcomes, resulting state and the next action. Detailed rationale lives in the canonical context, decision, feature, research and design documents.

## 2026-08-04 — Repository foundation

**Outcome**

- created the public repository;
- published the initial specification and repository policies;
- defined OpenCode + OpenRouter as the coherent product foundation;
- introduced Graphify, RTK, structured context and local observability.

## 2026-08-04 — Repository dogfooding established

**Outcome**

- added root `AGENTS.md`, canonical context documents, decision log, state and `.graphifyignore`;
- required the repository to expose its actual status without conversation history.

## 2026-08-04 — Initial TUI and configuration matrix defined

**Outcome**

- created `FEAT-001` for a possible Ratatui configurator;
- drafted `DESIGN-001` with 177 capabilities;
- exposed that the design was drifting toward a generalized product.

## 2026-08-05 — Personal-first scope aligned

**Outcome**

- accepted `DEC-014 — Design personal-first and allow reuse by others`;
- aligned `PROJECT.md`, `VISION.md`, `ARCHITECTURE.md`, `CONVENTIONS.md` and `OPERATIONS.md`;
- reduced the architecture to one canonical personal configuration, a small CLI core and native external-tool surfaces.

**Governing rule**

> A capability belongs in the MVP only when it improves the canonical personal workflow or protects its safety and maintainability.

## 2026-08-05 — TUI parked

**Outcome**

- changed `DEC-013` and `FEAT-001` to deferred;
- removed Ratatui and SPIKE-005 from the active implementation path;
- established that the CLI must be useful and stable before any TUI re-evaluation.

## 2026-08-05 — Upstream configuration research completed

**Outcome**

- reviewed current primary documentation for OpenCode, OpenRouter, Graphify, RTK and Phoenix;
- created `RESEARCH-001 — Configuration Surface Research`;
- confirmed that most desired behaviour should use native configuration and installers rather than custom portable abstractions.

**Key finding**

```text
OpenCode owns runtime configuration and agent assets
OpenRouter owns model/provider policy
Graphify owns graph extraction and ignore semantics
RTK owns command rewriting and output reduction
Phoenix owns OTLP trace collection
portable-opencode owns inspect, plan, apply, verify, state and coordination
```

## 2026-08-05 — Roadmap and configuration matrix rebuilt

**Outcome**

- rewrote the roadmap without reducing canonical scope;
- made specifications, configuration design, schemas, templates and scripts explicit deliverables;
- ordered delivery around technical validation, CLI foundation, machine installation, project bootstrap, continuity and hardening;
- reduced `DESIGN-001` from 177 to 81 capabilities;
- removed duplicated rows, team assumptions, profile catalogues and TUI-driven concepts;
- linked remaining uncertainty to four active technical spikes.

## 2026-08-05 — Windows-native environment selected

**Outcome**

- accepted `DEC-015 — Support Windows natively without WSL in the MVP`;
- selected PowerShell as the bootstrap and recovery shell;
- selected Windows Terminal as the primary terminal surface;
- removed Bash, POSIX shell and WSL from MVP requirements;
- required all active spikes and the canonical end-to-end path to run natively on Windows;
- updated project scope, roadmap, matrix and machine-readable state;
- reduced the unresolved personal defaults from eight to seven.

**Resulting constraint**

A dependency or workflow that only works through WSL does not satisfy the canonical path. It must provide a native Windows route, receive a narrow Windows adapter or be replaced.

## 2026-08-05 — Canonical OpenCode project configuration selected

**Outcome**

- accepted `DEC-016 — Use .opencode/opencode.jsonc as the canonical project configuration`;
- selected `<project>/.opencode/opencode.jsonc` as the only project-level OpenCode config generated and managed by portable-opencode;
- retained `<project>/AGENTS.md` at the repository root as the native operating entry point;
- grouped project agents, commands, skills, plugins and tools under `.opencode/` where supported;
- converted root `opencode.json` or `opencode.jsonc` into an explicit conflict or migration finding;
- updated roadmap, matrix and machine-readable state;
- reduced unresolved personal defaults from seven to six.

**Resulting constraint**

`SPIKE-001` must validate discovery, merge behaviour and root-config conflict handling on Windows. It must not reopen the selected path as a product decision.

**Current status**

The reduced matrix remains pending owner review. Two personal defaults are resolved.

**Recommended next action**

Choose the initial semantic roles and required OpenCode agents for the canonical personal workflow.
