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
| DEC-011 | proposed | Adopt a practical subset of OKF-like metadata |
| DEC-012 | deferred | Final packaging and distribution mechanism |
| DEC-013 | deferred | Defer the configuration TUI until the CLI is effective |
| DEC-014 | accepted | Design personal-first and allow reuse by others |
| DEC-015 | accepted | Support Windows natively without WSL in the MVP |
| DEC-016 | superseded | Use `.opencode/opencode.jsonc` as project configuration |
| DEC-017 | accepted | Use root `opencode.jsonc` plus `.opencode/` native assets |

---

## DEC-001 — Configure OpenCode and OpenRouter as one coherent system

**Status:** accepted  
**Date:** 2026-08-04

OpenCode is the runtime and interaction surface. OpenRouter is the control plane for models, providers, routing, privacy, fallbacks and cost.

**Consequences**

- both systems are required for the canonical environment;
- semantic model roles belong to the portable design;
- configuration and verification cover both systems.

---

## DEC-002 — Prefer native capabilities before custom extensions

**Status:** accepted  
**Date:** 2026-08-04

Use native OpenCode, OpenRouter, Graphify, RTK and Phoenix surfaces before writing custom code.

**Consequences**

- OpenCode owns agents, commands, skills, permissions, LSP and formatters;
- OpenRouter owns presets, provider policy, routing and fallbacks;
- Graphify owns graph extraction;
- RTK owns command rewriting and output filtering;
- custom portable code requires a concrete cross-tool or lifecycle gap.

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

**Consequences**

- local services bind loopback;
- secrets are redacted before persistence;
- bypassing observability creates an explicit degraded state;
- Phoenix remains replaceable even if selected for the MVP.

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

TypeScript is the leading option because it aligns with OpenCode extensions, schemas and generators.

**Evidence required**

- simple native Windows installation;
- acceptable packaging and runtime friction;
- reliable Windows process and filesystem operations;
- clear startup, update and migration strategy.

The deferred TUI does not influence this decision.

---

## DEC-010 — Use Arize Phoenix as the MVP observability backend

**Status:** proposed  
**Date:** 2026-08-04

Use Phoenix locally as the reference OTLP/OpenInference collector and trace UI.

**Evidence required**

- native Windows lifecycle without WSL;
- resource usage;
- trace ingestion from the proxy;
- retention and redaction;
- reliable loopback operation.

Phoenix is not the transparent proxy itself.

---

## DEC-011 — Adopt a practical subset of OKF-like metadata

**Status:** proposed  
**Date:** 2026-08-04

Use only metadata that improves provenance, lifecycle and verification. Full formal OKF compliance is not an MVP goal.

---

## DEC-012 — Final packaging and distribution mechanism

**Status:** deferred  
**Date:** 2026-08-04

Packaging follows the implementation language, Windows-native installation evidence and upgrade model. Candidate mechanisms include a packaged executable, package-manager command or a small PowerShell bootstrap.

---

## DEC-013 — Defer the configuration TUI until the CLI is effective

**Status:** deferred  
**Date:** 2026-08-05  
**Feature:** [FEAT-001](../features/CONFIGURATION_TUI.md)

Park Ratatui and remove SPIKE-005 from the active path. First deliver working `status`, `inspect`, `plan`, `apply`, `doctor`, `install` and `init-project`. A future TUI may only be a thin adapter over those operations.

---

## DEC-014 — Design personal-first and allow reuse by others

**Status:** accepted  
**Date:** 2026-08-05

The repository owner is the only user required for MVP acceptance. The canonical configuration represents one real personal workflow. Public reuse is enabled through explicit and replaceable configuration, not premature team, profile or universal-platform abstractions.

---

## DEC-015 — Support Windows natively without WSL in the MVP

**Status:** accepted  
**Date:** 2026-08-05

The canonical environment is Windows native, with PowerShell as bootstrap shell and Windows Terminal as primary terminal. WSL is neither required nor a valid fallback for MVP evidence.

**Consequences**

- required dependencies need a workable native Windows path;
- SPIKE-001 through SPIKE-004 run from PowerShell without WSL;
- Windows paths, quoting, subprocesses, ports, process cleanup and locked files are first-class tests;
- Bash and POSIX wrappers are not MVP deliverables;
- exact Windows and PowerShell versions enter the supported-version manifest before release.

---

## DEC-016 — Use `.opencode/opencode.jsonc` as project configuration

**Status:** superseded by DEC-017  
**Date:** 2026-08-05

This decision incorrectly inferred that OpenCode discovers a runtime configuration file at `.opencode/opencode.jsonc`. Current official documentation instead defines root `opencode.json` or `opencode.jsonc` as the per-project config and `.opencode/` as the native asset directory.

No implementation was created from DEC-016. It is retained to make the correction auditable.

---

## DEC-017 — Use root `opencode.jsonc` plus `.opencode/` native assets

**Status:** accepted  
**Date:** 2026-08-05

Every generated project uses:

```text
<project>/opencode.jsonc
```

as its canonical OpenCode runtime configuration.

OpenCode-specific assets use their documented project locations:

```text
<project>/.opencode/agents/
<project>/.opencode/commands/
<project>/.opencode/skills/
<project>/.opencode/plugins/
<project>/.opencode/tools/
<project>/.opencode/themes/
```

Only directories containing actual assets are created. Root `AGENTS.md` remains the repository operating entry point. Project-specific `tui.jsonc`, when needed, lives beside `opencode.jsonc` in the project root.

**Rationale**

- follows OpenCode's documented per-project configuration surface;
- preserves `.opencode/` for its documented asset-discovery role;
- lets OpenCode apply its native global/project precedence without environment-variable tricks;
- gives `portable-opencode` one deterministic runtime config path and one deterministic asset root;
- avoids maintaining an unsupported convention.

**Conflict policy**

- root `opencode.json` is a migration candidate because the canonical format is JSONC;
- both root `opencode.json` and `opencode.jsonc` is a blocking ambiguity;
- `.opencode/opencode.json` or `.opencode/opencode.jsonc` is a misplaced unmanaged file and never treated as runtime configuration;
- `OPENCODE_CONFIG` and `OPENCODE_CONFIG_CONTENT` are explicit runtime overrides and must be reported in provenance when present;
- `OPENCODE_CONFIG_DIR` may add assets but does not replace the canonical project runtime config.

**Validation**

SPIKE-001 verifies root-config discovery, merge with global configuration, asset discovery from `.opencode/`, environment overrides and conflict diagnostics on the supported Windows version. It does not reopen the canonical path unless upstream documentation or observed behaviour materially changes.

## Open questions

- Which implementation language and packaging approach survive the technical spikes?
- Which agents and semantic roles are required initially?
- Which Graphify outputs are versioned?
- What is the minimal context metadata schema?
- How are OpenRouter presets reconciled in the first CLI?
- What Phoenix lifecycle and retention policy is acceptable on Windows native?
