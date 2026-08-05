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
verified:
  - by: repository-owner
    status: pending
---

# Project

## 1. Current definition

`portable-opencode` is a public, versioned and reproducible **personal configuration system** for creating and maintaining an opinionated agentic coding environment built jointly on OpenCode and OpenRouter.

OpenCode is the runtime and interaction surface. OpenRouter controls models, providers, routing, privacy, fallbacks and cost. Local observability, Graphify, RTK and structured context complete the canonical environment.

The project is developed first for the repository owner's real workflow. Public GitHub availability provides versioning, transparency and possible reuse, but third-party adoption is not an MVP requirement.

No executable product exists yet. The project remains in **definition and configuration design**.

## 2. Product posture

> **Personal-first, reusable by others.**

This means:

- the repository owner is the sole required MVP user;
- one real canonical configuration precedes profiles;
- Windows native is supported before any platform expansion;
- configurability exists for explicit, demonstrated variation;
- public readability does not justify premature productization.

## 3. Canonical environment

`DEC-015` defines:

```text
Windows native
PowerShell
Windows Terminal
no WSL dependency
```

A WSL-only dependency or successful WSL-only experiment does not satisfy the MVP.

## 4. Initial use case

The first supported path is a new project created from an empty or fresh directory:

```text
portable-opencode install
→ portable-opencode init-project <path>
→ OpenCode /init-project
→ project reaches ready
→ normal development with maintained context, graph and verification
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

Root `opencode.jsonc` owns project runtime configuration. `.opencode/` owns native OpenCode assets. Only asset directories with real content are created.

## 6. Problem

A personal agentic environment otherwise accumulates uncoordinated local state:

- instructions and prompts become scattered;
- permissions remain implicit;
- model choices become coupled to agents;
- knowledge disappears between sessions;
- graph and context maintenance become manual chores;
- cost, routing and fallback behaviour are opaque;
- setup cannot be reproduced safely;
- active overrides and drift become hard to inspect.

## 7. Proposed solution

Provide one canonical workflow that configures and verifies:

1. the Windows machine;
2. OpenCode global behaviour and native assets;
3. OpenRouter policy and semantic roles;
4. a local metadata-first observability path;
5. RTK and Graphify;
6. a deterministic new-project scaffold;
7. semantic project initialization;
8. context, verification and cross-session continuity.

## 8. Core scope

- inspect, plan, apply, verify and diagnose desired state;
- install and configure OpenCode and OpenRouter coherently;
- install and verify RTK and Graphify;
- run local observability;
- generate root `opencode.jsonc`, root `AGENTS.md` and required `.opencode/` assets;
- scaffold curated context and project state;
- define only required agents, commands, skills, plugins and tools;
- encode permissions and privacy boundaries;
- maintain graph freshness, configuration provenance and continuity;
- distinguish healthy, ready, dirty, degraded and blocked states;
- support backups, upgrades and recovery.

## 9. Explicit non-goals for the first version

- a new agentic coding client or generic multi-agent framework;
- WSL, Linux or macOS parity;
- teams, organizations or shared governance;
- profile catalogues or marketplaces;
- broad MCP infrastructure;
- autonomous background agents;
- arbitrary legacy-repository migration;
- remote-first observability;
- large community skill catalogues;
- a configuration TUI before the CLI is proven.

## 10. Current repository state

Completed:

- public repository and canonical context;
- personal-first scope alignment;
- Windows-native platform decision;
- current upstream configuration research;
- TUI deferral;
- roadmap simplification;
- configuration matrix reduced from 177 to 81 contracts;
- correction of OpenCode project configuration to documented root `opencode.jsonc`;
- machine-readable state synchronized.

Not completed:

- full canonical specification v0.3;
- matrix owner approval;
- canonical global/project file-tree design beyond the accepted OpenCode boundary;
- CLI and schema contracts;
- technical spikes;
- implementation, tests or releases.

## 11. Current unresolved defaults

1. implementation language and packaging;
2. initial semantic roles and required agents;
3. Graphify output versioning;
4. minimal context metadata;
5. Phoenix lifecycle and retention;
6. OpenRouter preset reconciliation behaviour.

## 12. Constraints

- solve the owner's real workflow first;
- use native upstream surfaces before custom code;
- keep secrets and private state outside Git;
- require native Windows evidence;
- keep defaults safe, inspectable and replaceable;
- make operations deterministic, idempotent and recoverable;
- do not claim support or implementation without evidence;
- retain only abstractions with current personal value.

## 13. Definition-phase completion

The definition phase is complete when:

- the six remaining defaults are accepted or delegated to bounded evidence;
- the reduced matrix is owner-approved;
- canonical file ownership and CLI contracts are explicit;
- every technical uncertainty maps to a spike;
- the specification is synchronized as personal-first v0.3;
- Codex can execute SPIKE-001 without inventing product behaviour.
