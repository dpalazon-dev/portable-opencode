---
type: Project Context
title: Portable OpenCode Project Definition
description: Current identity, primary user, scope, constraints and development state of portable-opencode.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../SPECIFICATION.es.md
  - ../../README.md
  - DECISIONS.md
  - ../design/CONFIGURATION_MATRIX.md
  - ../design/AGENT_AND_MODEL_ROLES.md
  - ../design/GRAPHIFY_OUTPUT_POLICY.md
verified:
  - by: repository-owner
    status: pending
---

# Project

## 1. Current definition

`portable-opencode` is a public, versioned and reproducible **personal configuration system** for creating and maintaining an opinionated agentic coding environment built jointly on OpenCode and OpenRouter.

OpenCode is the runtime and interaction surface. OpenRouter controls models, providers, routing, privacy, fallbacks and cost. Local observability, Graphify, RTK and structured context complete the canonical environment.

The project is developed first for the repository owner's real workflow. Public reuse is possible but does not drive the MVP. No executable product exists yet; the project remains in **definition and configuration design**.

## 2. Product posture

> **Personal-first, reusable by others.**

- one owner is the required MVP user;
- one real canonical configuration precedes profiles;
- Windows native precedes platform expansion;
- configurability requires demonstrated variation;
- public readability does not justify premature productization.

## 3. Canonical environment

`DEC-015` defines Windows native, PowerShell and Windows Terminal with no WSL dependency. WSL-only behaviour is not valid MVP evidence.

## 4. Initial use case

```text
portable-opencode install
→ portable-opencode init-project <path>
→ OpenCode /init-project
→ project reaches ready
→ development with maintained context, graph and verification
```

## 5. Canonical OpenCode project layout

`DEC-017` defines:

```text
<project>/
├── opencode.jsonc
├── AGENTS.md
├── .opencode/
│   ├── agents/
│   ├── commands/
│   ├── skills/
│   ├── plugins/
│   ├── tools/
│   └── themes/
├── docs/context/
├── .portable-opencode/
└── .graphifyignore
```

Root `opencode.jsonc` owns runtime configuration. `.opencode/` owns native OpenCode assets. Only directories with real content are created.

## 6. Canonical agents and model roles

`DEC-018` preserves OpenCode's native agents:

```text
primary: build, plan
subagents: general, explore, scout
```

The scaffold adds only non-mutating `review` and `verify` subagents.

Model/provider policy uses:

```text
main   → build
reason → plan, review, verify
fast   → general, explore, scout, small_model
```

Concrete models remain replaceable through OpenRouter presets. Exact OpenCode preset references require `SPIKE-002`.

## 7. Graphify output ownership

`DEC-019` preserves structural continuity with a minimal Git allowlist:

```text
versioned:
  graphify-out/graph.json
  graphify-out/GRAPH_REPORT.md
  graphify-out/manifest.json

ignored:
  graph.html
  cache/
  cost.json
  query logs
  optional exports
```

The manifest is versioned only after `SPIKE-004` verifies portability and absence of private paths. Stale graph state marks the project `dirty`; missing or corrupt `graph.json` blocks readiness.

## 8. Problem

Without coordination, a personal agentic environment accumulates scattered instructions, implicit permissions, coupled model choices, disappearing knowledge, stale graph/context, opaque cost/routing and irreproducible setup.

## 9. Proposed solution

Provide one workflow that configures and verifies:

1. the Windows machine;
2. OpenCode global behaviour and native assets;
3. OpenRouter policy and semantic roles;
4. metadata-first local observability;
5. RTK and Graphify;
6. deterministic project scaffolding;
7. semantic project initialization;
8. context, verification and continuity.

## 10. Core scope

- inspect, plan, apply, verify and diagnose desired state;
- install and configure OpenCode/OpenRouter coherently;
- install and verify RTK and Graphify;
- run local observability;
- generate canonical OpenCode config/assets and curated context;
- provide only required agents, commands, skills, plugins and tools;
- generate and maintain the Graphify output allowlist;
- encode permissions and privacy;
- maintain graph freshness, provenance and continuity;
- distinguish healthy, ready, dirty, degraded and blocked;
- support backups, upgrades and recovery.

## 11. Explicit non-goals

- a new coding client or generic multi-agent framework;
- WSL, Linux or macOS parity;
- teams, organizations, profiles or marketplaces;
- broad MCP infrastructure;
- autonomous background agents;
- arbitrary legacy migration;
- remote-first observability;
- agent catalogues or Graphify export catalogues;
- a configuration TUI before the CLI is proven.

## 12. Current repository state

Completed:

- public repository and canonical context;
- personal-first and Windows-native decisions;
- upstream configuration research and correction;
- TUI deferral and roadmap simplification;
- matrix reduction from 177 to 81 contracts;
- root `opencode.jsonc` plus `.opencode/` asset decision;
- native agent reuse, `review`/`verify`, and `main`/`reason`/`fast` policy;
- Graphify minimal versioned-output policy;
- synchronized machine-readable state.

Not completed:

- canonical specification v0.3;
- matrix owner approval;
- remaining file-tree, CLI and schema contracts;
- technical spikes;
- implementation, tests or releases.

## 13. Remaining resolution items

1. implementation language and packaging from spike evidence;
2. minimal context metadata;
3. Phoenix lifecycle and retention;
4. first-CLI OpenRouter preset reconciliation.

## 14. Constraints

- solve the owner's workflow first;
- use native upstream surfaces;
- keep secrets/private state outside Git;
- require native Windows evidence;
- keep defaults safe and inspectable;
- make operations deterministic, idempotent and recoverable;
- do not claim unverified support;
- retain only abstractions and generated artefacts with current value.

## 15. Definition-phase completion

The phase completes when remaining items are accepted or delegated to evidence, the matrix is approved, file ownership and CLI contracts are explicit, the specification is synchronized to v0.3 and SPIKE-001 can be executed without product invention.
