---
type: Decision Log
title: Portable OpenCode Decisions
description: Accepted, proposed, superseded and deferred product and architecture decisions.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../SPECIFICATION.es.md
  - PROJECT.md
  - VISION.md
  - ARCHITECTURE.md
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
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
| DEC-011 | accepted | Use a minimal repository-owned OKF-compatible metadata schema |
| DEC-012 | deferred | Final packaging and distribution mechanism |
| DEC-013 | deferred | Defer the configuration TUI until the CLI is effective |
| DEC-014 | accepted | Design personal-first and allow reuse by others |
| DEC-015 | accepted | Support Windows natively without WSL in the MVP |
| DEC-016 | superseded | Use `.opencode/opencode.jsonc` as project configuration |
| DEC-017 | accepted | Use root `opencode.jsonc` plus `.opencode/` native assets |
| DEC-018 | accepted | Reuse native OpenCode agents and use three semantic model roles |
| DEC-019 | accepted | Version a minimal allowlist of Graphify output |

---

## DEC-001 — Configure OpenCode and OpenRouter as one coherent system

**Status:** accepted  
**Date:** 2026-08-04

OpenCode is the runtime and interaction surface. OpenRouter is the control plane for models, providers, routing, privacy, fallbacks and cost.

---

## DEC-002 — Prefer native capabilities before custom extensions

**Status:** accepted  
**Date:** 2026-08-04

Use native OpenCode, OpenRouter, Graphify, RTK and Phoenix surfaces before writing custom code. Custom portable code requires a concrete cross-tool or lifecycle gap.

---

## DEC-003 — Optimize the first version for new projects

**Status:** accepted  
**Date:** 2026-08-04

The first complete path targets empty or freshly initialized repositories. Existing-repository adoption is later work.

---

## DEC-004 — Treat Graphify as a core subsystem

**Status:** accepted  
**Date:** 2026-08-04

Graphify is installed from the beginning. The first graph is generated after a useful source baseline exists. `.graphifyignore`, graph freshness and graph quality are explicit project concerns.

---

## DEC-005 — Make observability local and metadata-first by default

**Status:** accepted  
**Date:** 2026-08-04

The canonical path includes a local observability boundary between OpenCode and OpenRouter. Metadata, usage, cost, latency and errors are captured by default; prompt and response content is not.

---

## DEC-006 — Separate versioned, project and private state

**Status:** accepted  
**Date:** 2026-08-04

Keep distinct ownership for canonical repository configuration, generated project configuration and private credentials, traces, backups, caches and machine state. The CLI must explain effective provenance.

---

## DEC-007 — Dogfood structured context in this repository

**Status:** accepted  
**Date:** 2026-08-04

The repository uses the same context, decision, state and Graphify concepts it intends to generate. Unimplemented behaviour remains explicitly proposed, deferred or inactive.

---

## DEC-008 — Keep MCPs and broad integrations outside the initial core

**Status:** accepted  
**Date:** 2026-08-04

MCPs, GitHub automation, remote servers, community catalogues, local-model profiles and autonomous background agents are not required by the first complete personal path.

---

## DEC-009 — Use TypeScript as the principal implementation language

**Status:** proposed  
**Date:** 2026-08-04

TypeScript is the leading option because it aligns with OpenCode extensions, schemas and generators. Acceptance requires native Windows packaging, process, filesystem, update and migration evidence.

---

## DEC-010 — Use Arize Phoenix as the MVP observability backend

**Status:** proposed  
**Date:** 2026-08-04

Use Phoenix locally as the reference OTLP/OpenInference collector and trace UI. Native Windows lifecycle, resource usage, retention, redaction and ingestion require SPIKE-003. Phoenix is not the proxy itself.

---

## DEC-011 — Use a minimal repository-owned OKF-compatible metadata schema

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-004](../design/CONTEXT_METADATA_SCHEMA.md)

### Decision

Every non-reserved curated Markdown document requires only:

```yaml
type: <document type>
title: <display title>
description: <one-line responsibility>
status: <document lifecycle>
```

Conditional fields are limited to:

```text
id
sources
resource
tags
generated
decision
```

`index.md` and `log.md` are reserved navigation/history files and have no frontmatter.

### Removed fields

- `created` and `modified` are removed because Git already owns history and manual timestamps create churn;
- generic `verified` is removed because permanent `pending` values are not evidence;
- verification belongs to decisions, spikes, tests and `.portable-opencode/state.json`;
- string-only source lists are replaced by optional source objects containing at least `resource`.

### Compatibility position

The schema preserves the useful OKF model—Markdown, YAML frontmatter, typed concepts, optional provenance and reserved index/log files—but remains repository-owned. Full trust, attestation and computation families are not MVP requirements.

Parsed frontmatter is validated against:

```text
schemas/context-document.schema.json
```

### Migration consequence

Existing documents still contain inherited fields. The decision is accepted, but `docs-only` verification remains pending until a controlled migration:

1. removes deprecated fields;
2. removes frontmatter from `index.md` and `log.md`;
3. converts only material sources to structured objects;
4. validates all non-reserved frontmatter;
5. preserves document bodies except necessary link corrections.

---

## DEC-012 — Final packaging and distribution mechanism

**Status:** deferred  
**Date:** 2026-08-04

Packaging follows language, Windows-native installation evidence and the upgrade model.

---

## DEC-013 — Defer the configuration TUI until the CLI is effective

**Status:** deferred  
**Date:** 2026-08-05  
**Feature:** [FEAT-001](../features/CONFIGURATION_TUI.md)

Park Ratatui until `status`, `inspect`, `plan`, `apply`, `doctor`, `install` and `init-project` work end to end. A future TUI may only be a thin adapter over those operations.

---

## DEC-014 — Design personal-first and allow reuse by others

**Status:** accepted  
**Date:** 2026-08-05

The repository owner is the only user required for MVP acceptance. Public reuse is enabled through explicit, replaceable configuration rather than premature productization.

---

## DEC-015 — Support Windows natively without WSL in the MVP

**Status:** accepted  
**Date:** 2026-08-05

The canonical environment is Windows native, PowerShell and Windows Terminal. WSL-only behaviour is not valid MVP evidence.

---

## DEC-016 — Use `.opencode/opencode.jsonc` as project configuration

**Status:** superseded by DEC-017  
**Date:** 2026-08-05

This decision confused OpenCode's asset directory with its documented project runtime config. It produced no implementation and is retained for auditability.

---

## DEC-017 — Use root `opencode.jsonc` plus `.opencode/` native assets

**Status:** accepted  
**Date:** 2026-08-05

Root `opencode.jsonc` is canonical runtime configuration. `.opencode/` stores native agents, commands, skills, plugins, tools and themes. Root `AGENTS.md` remains the repository operating entry point.

Root `opencode.json` is a migration candidate; dual root configs are blocking; `.opencode/opencode.json(c)` is misplaced; environment and managed config sources are reported as provenance.

---

## DEC-018 — Reuse native OpenCode agents and use three semantic model roles

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-002](../design/AGENT_AND_MODEL_ROLES.md)

Preserve native `build`, `plan`, `general`, `explore` and `scout`. Add only non-mutating `review` and `verify` subagents.

```text
build                 → main
plan, review, verify  → reason
general, explore,
scout, small_model    → fast
```

Expected preset slugs are `portable-main`, `portable-reason` and `portable-fast`. Exact OpenCode references remain SPIKE-002 work.

---

## DEC-019 — Version a minimal allowlist of Graphify output

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-003](../design/GRAPHIFY_OUTPUT_POLICY.md)

Version only:

```text
graphify-out/graph.json
graphify-out/GRAPH_REPORT.md
graphify-out/manifest.json
```

Ignore HTML, cache, cost, query logs and optional exports. The manifest remains conditional on SPIKE-004 portability and private-path validation. Stale output marks `dirty`; corrupt graph blocks readiness.

## Open questions

- Which implementation language and packaging approach survive the technical spikes?
- How are OpenRouter presets reconciled in the first CLI?
- What Phoenix lifecycle and retention policy is acceptable on Windows native?
