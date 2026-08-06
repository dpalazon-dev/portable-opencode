---
type: Decision Log
title: Portable OpenCode Decisions
description: Accepted, proposed, superseded and deferred product and architecture decisions.
status: active
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
| DEC-020 | accepted | Reconcile managed OpenRouter presets declaratively |
| DEC-021 | accepted | Materialize configuration explicitly and mutate only proven-owned resources |

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

This is no longer an owner-preference question. SPIKE-001 through SPIKE-004 and the first CLI prototype must provide the evidence.

---

## DEC-010 — Use Arize Phoenix as the MVP observability backend

**Status:** proposed  
**Date:** 2026-08-04  
**Design:** [DESIGN-005](../design/OBSERVABILITY_LIFECYCLE.md)

The intended default is:

```text
native terminal process
isolated managed Python environment
loopback only
SQLite under %LOCALAPPDATA%
30-day retention
telemetry and external resources disabled
on-demand lifecycle
no Docker, WSL, PostgreSQL or Windows service
```

Acceptance remains conditional on SPIKE-003 proving transparent proxy ingestion, safe Windows lifecycle and acceptable resource use.

---

## DEC-011 — Use a minimal repository-owned OKF-compatible metadata schema

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-004](../design/CONTEXT_METADATA_SCHEMA.md)

Non-reserved curated documents require only `type`, `title`, `description` and `status`. Conditional fields are limited to `id`, structured `sources`, `resource`, `tags`, `generated` and `decision`.

`created`, `modified` and generic `verified` are removed. `index.md` and `log.md` are frontmatter-free. Parsed metadata is validated against `schemas/context-document.schema.json`.

Existing documents require a controlled migration before `docs-only` can pass.

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

Park Ratatui until the complete CLI path works. A future TUI may only be a thin adapter over stable operations.

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

Root `opencode.json` is a migration candidate; dual root configs are blocking; `.opencode/opencode.json(c)` is misplaced; environment and managed sources are reported as provenance.

---

## DEC-018 — Reuse native OpenCode agents and use three semantic model roles

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-002](../design/AGENT_AND_MODEL_ROLES.md)

Preserve native `build`, `plan`, `general`, `explore` and `scout`. Add only non-mutating `review` and `verify`.

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

Version `graph.json`, `GRAPH_REPORT.md` and a validated portable `manifest.json`. Ignore HTML, cache, cost, query logs and optional exports. Stale graph marks `dirty`; corrupt graph blocks readiness.

---

## DEC-020 — Reconcile managed OpenRouter presets declaratively

**Status:** accepted  
**Date:** 2026-08-05  
**Design:** [DESIGN-006](../design/OPENROUTER_PRESET_RECONCILIATION.md)

The versioned local manifest at `config/openrouter/presets.jsonc` is the desired state for exactly:

```text
portable-main
portable-reason
portable-fast
```

The CLI performs:

```text
inspect remote state
→ normalize and diff
→ plan create/new-version operations
→ explicit approval
→ apply one slug at a time
→ verify designated version
→ run synthetic smoke tests
```

Rules:

- missing managed presets are created after approval;
- drift creates a new active version and preserves history;
- remote changes never occur during inspect or plan;
- no preset is deleted, archived or renamed automatically;
- presets outside the three managed slugs are ignored;
- partial outcomes are recorded and verified individually;
- inability to reconcile reproducibly leaves policy blocked or explicitly degraded rather than falling back silently to manual setup;
- API keys remain private;
- exact OpenCode preset representation remains SPIKE-002 evidence.

---

## DEC-021 — Materialize configuration explicitly and mutate only proven-owned resources

**Status:** accepted  
**Date:** 2026-08-06  
**Design:** [DESIGN-007](../design/MANAGED_CONFIGURATION_MATERIALIZATION.md)

Every managed resource declares a canonical source, managed target, owner, materialization mode, mutability, content identity, backup policy, drift policy and verification.

```text
rendered  → generated from canonical inputs
copied    → byte-equivalent native file
linked    → exceptional, evidence-gated on Windows
queried   → externally owned state inspected without adoption
private   → local value or state outside Git
```

`rendered` and `copied` are the normal modes. Links are not a convenience default because an upstream application may rewrite the canonical repository through the target.

The CLI may replace, detach or remove only resources whose ownership it can prove from recorded state and current evidence. Unmanaged or ambiguous resources are preserved and reported. Removing a resource from desired state produces a retirement plan; it never authorizes blind deletion.

The same design fixes an early supported-component version manifest and a deliberately small PowerShell bootstrap that establishes the CLI but does not duplicate application logic.

## Evidence-gated decisions remaining

- `DEC-009`: language and packaging after Windows-native prototypes;
- `DEC-010`: Phoenix acceptance after SPIKE-003.
