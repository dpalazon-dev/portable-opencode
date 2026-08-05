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

This log records outcomes, resulting state and the next action. Detailed rationale lives in canonical context, decision, research and design documents.

## 2026-08-04 — Repository foundation

- created the public repository and initial specification;
- defined OpenCode + OpenRouter as the coherent product foundation;
- introduced Graphify, RTK, structured context and local observability.

## 2026-08-04 — Repository dogfooding established

- added root `AGENTS.md`, context documents, decisions, state and `.graphifyignore`;
- required the repository to expose actual state without conversation history.

## 2026-08-04 — Broad design surface drafted

- proposed a possible Ratatui configurator;
- drafted `DESIGN-001` with 177 capabilities;
- exposed drift toward a generalized product.

## 2026-08-05 — Personal-first scope aligned

- accepted `DEC-014`;
- aligned project, vision, architecture, conventions and operations;
- reduced architecture to one personal configuration, a small CLI core and native upstream surfaces.

## 2026-08-05 — TUI parked

- changed `DEC-013` and `FEAT-001` to deferred;
- removed Ratatui and SPIKE-005 from the active path;
- made a working CLI the prerequisite for any TUI reconsideration.

## 2026-08-05 — Upstream configuration research completed

- reviewed OpenCode, OpenRouter, Graphify, RTK and Phoenix primary documentation;
- created `RESEARCH-001`;
- confirmed that upstream tools should own their native configuration and behaviour.

## 2026-08-05 — Roadmap and matrix rebuilt

- preserved complete canonical scope while simplifying delivery phases;
- made specification, schemas, templates, scripts and CLI contracts explicit deliverables;
- reduced the configuration matrix from 177 to 81 contracts;
- linked remaining uncertainty to four Windows-native spikes.

## 2026-08-05 — Windows-native environment selected

- accepted `DEC-015`;
- selected PowerShell and Windows Terminal;
- removed WSL, Bash and POSIX wrappers from MVP requirements;
- required all spikes and E2E evidence to execute natively on Windows.

## 2026-08-05 — OpenCode project layout corrected

- marked erroneous `DEC-016` superseded;
- accepted `DEC-017`;
- selected root `opencode.jsonc` as project runtime config;
- preserved `.opencode/` as the native asset root;
- added conflict and provenance policies;
- corrected architecture, roadmap, research, matrix, project, operations and state.

## 2026-08-05 — Minimal agent and model policy accepted

- accepted `DEC-018` and created `DESIGN-002`;
- retained native `build`, `plan`, `general`, `explore` and `scout`;
- added only non-mutating `review` and `verify`;
- defined `main`, `reason` and `fast` roles;
- left exact preset reference syntax to `SPIKE-002`.

```text
build                 → main
plan, review, verify  → reason
general, explore,
scout, small_model    → fast
```

## 2026-08-05 — Graphify output ownership accepted

- accepted `DEC-019` and created `DESIGN-003`;
- selected a minimal versioned allowlist:

```text
graphify-out/graph.json
graphify-out/GRAPH_REPORT.md
graphify-out/manifest.json
```

- kept HTML, cache, cost, query logs and optional exports out of Git;
- required `.graphifyignore` to exclude `graphify-out/` from source extraction;
- defined stale graph as `dirty`, corrupt graph as `blocked`, and rebuildable manifest absence as `degraded`;
- delegated manifest portability, determinism and clone/update behaviour to `SPIKE-004`;
- reduced remaining resolution items from five to four.

**Recommended next action**

Define the minimal context metadata schema and remove frontmatter fields that do not improve provenance, lifecycle or verification.
