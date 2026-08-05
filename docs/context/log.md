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

**Initial error**

`DEC-016` accepted `.opencode/opencode.jsonc` after incorrectly treating `.opencode/` as both runtime configuration and asset directory.

**Evidence**

Current official OpenCode documentation defines:

```text
<project>/opencode.json(c)   project runtime configuration
<project>/.opencode/         project agents, commands, skills, plugins, tools and themes
```

`OPENCODE_CONFIG_DIR` adds an asset directory and does not redefine the standard project runtime config.

**Correction**

- marked `DEC-016` superseded;
- accepted `DEC-017`;
- selected root `opencode.jsonc` as the canonical project runtime config;
- preserved `.opencode/` as the native asset root;
- added explicit policies for root JSON migration, dual root ambiguity, misplaced `.opencode/opencode.json(c)` and environment override provenance;
- corrected architecture, roadmap, research, matrix and machine-readable state;
- retained 81 matrix capabilities and six unresolved personal defaults.

**Resulting layout**

```text
<project>/
├── opencode.jsonc
├── AGENTS.md
└── .opencode/
    ├── agents/
    ├── commands/
    ├── skills/
    ├── plugins/
    ├── tools/
    └── themes/
```

Only asset directories with real content are created.

**Recommended next action**

Define the initial OpenCode agents and OpenRouter semantic roles together, while leaving the exact OpenRouter preset reference syntax to `SPIKE-002`.
