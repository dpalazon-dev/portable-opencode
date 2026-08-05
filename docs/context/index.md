---
type: Knowledge Index
title: Portable OpenCode Project Context
description: Canonical entry point for current context, evidence and design.
status: active
created: 2026-08-04
modified: 2026-08-05
verified:
  - by: repository-owner
    status: pending
sources:
  - ../SPECIFICATION.es.md
---

# Project context

## Canonical reading order

1. [PROJECT.md](PROJECT.md) — what the project is now.
2. [VISION.md](VISION.md) — the personal outcome it should enable.
3. [ARCHITECTURE.md](ARCHITECTURE.md) — boundaries and lifecycle.
4. [CONVENTIONS.md](CONVENTIONS.md) — repeated repository rules.
5. [OPERATIONS.md](OPERATIONS.md) — how work is performed and verified.
6. [DECISIONS.md](DECISIONS.md) — accepted, proposed, superseded and deferred choices.
7. [ROADMAP.md](ROADMAP.md) — ordered delivery path.
8. [log.md](log.md) — concise meaningful transitions.

The broad specification remains in [../SPECIFICATION.es.md](../SPECIFICATION.es.md). Accepted decisions and current context take precedence until the specification is revised to personal-first v0.3.

## Supporting evidence and design

- [RESEARCH-001 — Configuration Surface Research](../research/CONFIGURATION_SURFACE_RESEARCH.md) records current official configuration surfaces and the correction of the OpenCode project config path.
- [DESIGN-001 — Configuration Matrix](../design/CONFIGURATION_MATRIX.md) maps 81 personal-first configuration contracts.
- [DESIGN-002 — Agent and Model Role Policy](../design/AGENT_AND_MODEL_ROLES.md) defines native/custom OpenCode agents and `main`, `reason`, `fast` roles.
- [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md) preserves the deferred Ratatui concept and re-evaluation gate.

Research and design support decisions; they do not silently override accepted context.

## Source responsibilities

| Source | Responsibility |
|---|---|
| `PROJECT.md` | current identity, user, scope and status |
| `VISION.md` | desired personal outcome and success |
| `ARCHITECTURE.md` | component ownership and lifecycle |
| `CONVENTIONS.md` | stable repeated rules |
| `OPERATIONS.md` | work and verification workflow |
| `DECISIONS.md` | durable rationale and decision status |
| `ROADMAP.md` | delivery order and gates |
| `docs/research/` | current external evidence |
| `docs/design/` | implementable contracts |
| `docs/features/` | independently reviewable future behaviour |
| `.portable-opencode/state.json` | machine-readable current state |
| `log.md` | concise chronological transitions |

## Status model

- `active`: current source of truth;
- `proposed`: awaiting decision;
- `superseded`: replaced but retained for auditability;
- `deferred`: intentionally postponed;
- `draft`: useful but not approved;
- `archived`: historical and non-operational.

## Maintenance rule

A material behavioural, architectural or lifecycle change is incomplete until its canonical context, decision status, supporting design and machine-readable state agree.
