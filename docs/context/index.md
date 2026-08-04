---
type: Knowledge Index
title: Portable OpenCode Project Context
description: Canonical entry point for the curated context of the portable-opencode repository.
status: active
created: 2026-08-04
modified: 2026-08-04
generated:
  by: project-bootstrap
  at: 2026-08-04T23:22:00+02:00
verified:
  - by: repository-owner
    status: pending
sources:
  - ../SPECIFICATION.es.md
---

# Project context

This directory is the curated operational memory of the repository. It separates what the project **is**, what it **wants to become**, how it is **designed**, how it is **developed**, and which decisions are already binding.

## Reading order

1. [PROJECT.md](PROJECT.md) — current definition, scope and status.
2. [VISION.md](VISION.md) — desired future and success conditions.
3. [ARCHITECTURE.md](ARCHITECTURE.md) — system boundaries and architectural model.
4. [CONVENTIONS.md](CONVENTIONS.md) — repository and implementation conventions.
5. [OPERATIONS.md](OPERATIONS.md) — development and maintenance workflow.
6. [DECISIONS.md](DECISIONS.md) — accepted decisions, proposals and open questions.
7. [ROADMAP.md](ROADMAP.md) — ordered delivery path.
8. [log.md](log.md) — meaningful context changes and session handoffs.

The broad product specification remains in [../SPECIFICATION.es.md](../SPECIFICATION.es.md).

## Document responsibilities

| Document | Answers |
|---|---|
| `PROJECT.md` | What is the project now? |
| `VISION.md` | What future should it enable? |
| `ARCHITECTURE.md` | How are responsibilities separated? |
| `CONVENTIONS.md` | How should the repository be changed? |
| `OPERATIONS.md` | How is work performed and verified? |
| `DECISIONS.md` | What has been decided and why? |
| `ROADMAP.md` | What is built next and in which order? |
| `log.md` | What changed in the project context? |

## Related design and feature documents

These documents refine the context without replacing it:

- [DESIGN-001 — Configuration Matrix](../design/CONFIGURATION_MATRIX.md) defines configuration ownership, defaults, overrides, validation, failure semantics and interface exposure for the MVP.
- [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md) defines the proposed Ratatui frontend and its boundary with the shared application engine.

A design or feature document may remain `draft` or `proposed` while the context documents stay active. Accepted durable changes must still be reflected in `DECISIONS.md`, `ARCHITECTURE.md` and project state.

## Status model

Context documents may use:

- `draft`: useful but not yet accepted;
- `active`: current source of truth;
- `proposed`: awaiting an explicit decision;
- `superseded`: replaced but retained for history;
- `deprecated`: no longer recommended;
- `archived`: historical and not operational.

## Maintenance rule

A behavioural, architectural or lifecycle change is incomplete until the relevant context document and `DECISIONS.md` are consistent with it.
