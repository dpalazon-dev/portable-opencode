---
type: Architecture
title: Portable OpenCode Architecture
description: Personal-first Windows-native architecture, responsibility boundaries and lifecycle for the canonical portable-opencode workflow.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - PROJECT.md
  - VISION.md
  - DECISIONS.md
  - ../SPECIFICATION.es.md
verified:
  - by: repository-owner
    status: pending
---

# Architecture

## 1. Architectural objective

`portable-opencode` exists to reproduce and maintain one deliberate personal agentic coding environment across the repository owner's Windows machine and new projects.

The architecture should be no more general than that problem requires.

Its value is that the owner can:

1. inspect the current environment;
2. understand proposed changes;
3. install or initialize safely;
4. verify the resulting state;
5. use OpenCode with explicit routing, permissions, context and observability;
6. recover the same working model later without relying on memory.

The governing test for every architectural element is:

> Does this component or abstraction directly improve the canonical personal workflow, or is it only preparing for hypothetical users and scenarios?

Elements that fail this test are removed from the MVP, deferred or kept as implementation details rather than promoted to product concepts.

## 2. Canonical environment

`DEC-015` fixes the MVP environment as:

```text
Windows native
+ PowerShell
+ Windows Terminal
- WSL
```

All required dependencies, scripts, spikes and end-to-end verification must work through native Windows paths. Linux, macOS and WSL support are deferred.

## 3. Two paths, one system

### Configuration path

Used to inspect, install, initialize, diagnose and repair the environment.

```text
User
  → headless CLI
  → small application core
  → explicit plan
  → review and approval
  → narrow system adapters
  → filesystem and external tools
  → verification
  → recorded state
```

### Daily coding path

Used after the environment and project are configured.

```text
User
  → OpenCode
  → project context + Graphify + LSP
  → agents, commands, skills and tools
  → local observability boundary
  → OpenRouter
  → selected model and provider
  → response, usage, cost and errors
```

RTK reduces noisy terminal output before it enters agent context. Verification determines whether code and project state are correct.

`portable-opencode` configures and maintains the environment. OpenCode remains the agent runtime.

## 4. Minimal architectural components

### 4.1. Portable application core

The core owns only deterministic lifecycle behaviour that cannot belong to OpenCode, OpenRouter or another selected component:

- environment inspection;
- desired-state resolution;
- change planning;
- safe application of approved changes;
- project scaffolding;
- diagnostics and repair suggestions;
- verification orchestration;
- explicit lifecycle state;
- structured operation results.

The core is not a generic workflow engine, plugin platform or agent runtime.

For the MVP there is one canonical personal configuration. Local overrides appear only for demonstrated machine-specific needs.

### 4.2. Headless CLI

The CLI is the mandatory control interface.

It supports:

- interactive command use;
- explicit lifecycle commands;
- dry-run and explain output;
- machine-readable output;
- non-interactive execution for repeatability and testing.

The CLI calls the application core and does not contain a second configuration model.

### 4.3. Deferred configuration TUI

`DEC-013` and [FEAT-001](../features/CONFIGURATION_TUI.md) defer the Ratatui interface until the CLI is effective and stable.

The TUI does not influence the MVP language, packaging, core contracts or release gate. A future TUI may only project the same plans, diagnostics and operations already exposed by the CLI.

### 4.4. OpenCode

OpenCode owns the coding interaction layer:

- sessions;
- primary agents and subagents;
- commands and skills;
- custom tools and plugins;
- permissions and tool execution;
- LSP and formatters;
- compaction, watcher behaviour and project instruction loading.

`portable-opencode` configures these native capabilities rather than recreating them.

### 4.5. OpenRouter

OpenRouter owns:

- model and provider selection;
- routing and fallbacks;
- privacy-related provider policy;
- usage and cost information;
- personal API credentials and remote account limits.

OpenCode-facing configuration uses a small set of stable semantic roles where that reduces repeated model coupling.

### 4.6. Local observability

Observability answers personal operational questions:

- which model and provider handled a request;
- latency, tokens and cost;
- whether a fallback or error occurred;
- which project, OpenCode session or operation produced it.

The intended boundary is a native Windows localhost proxy between OpenCode and OpenRouter, subject to `SPIKE-003`.

Metadata, usage and errors are collected by default. Prompt and response capture remains opt-in. Observability databases and raw traces are private local state.

### 4.7. Graphify

Graphify is the structural memory of the codebase and remains part of the canonical setup.

The portable layer owns only:

- installation and health checks;
- `.graphifyignore` composition;
- explicit update commands and later optional triggers;
- graph freshness state;
- quality auditing;
- persisted inclusion and exclusion decisions.

Graphify does not replace LSP, textual search or curated context.

### 4.8. RTK

RTK reduces verbose terminal output before it consumes agent context.

The portable layer installs it, verifies it and applies its native OpenCode integration. It does not build a competing output-processing pipeline.

### 4.9. Curated project context

Versioned context owns information that should survive sessions:

- project definition and vision;
- architecture, conventions and operations;
- durable decisions;
- roadmap;
- concise context log;
- independently reviewable feature, design and spike documents.

Context is curated knowledge, not a chat archive or event store.

### 4.10. Machine-readable state

Machine-readable state records operational facts:

- environment and project lifecycle;
- readiness;
- degraded or blocked conditions;
- graph freshness;
- verification result;
- managed versions;
- pending decisions required to continue.

State remains small, inspectable and schema-validated.

## 5. Configuration ownership

### A. Canonical versioned source

Stored in this repository:

- default OpenCode configuration;
- agents, commands, skills, tools and plugins actually used;
- OpenRouter semantic-role intent;
- installation and project templates;
- Graphify and RTK integration policy;
- schemas and verification rules;
- documentation and decisions.

### B. Managed personal environment

Materialized on Windows:

- active global OpenCode configuration;
- installed portable components;
- observability processes;
- generated non-secret tool configuration;
- local installation metadata.

### C. Project-versioned configuration

`DEC-016` fixes the OpenCode project layout:

```text
<project>/
├── AGENTS.md
├── .opencode/
│   ├── opencode.jsonc
│   ├── agents/
│   ├── commands/
│   ├── skills/
│   ├── plugins/
│   └── tools/
├── docs/context/
├── .portable-opencode/
└── .graphifyignore
```

The exact presence of each `.opencode/` subdirectory depends on real project needs and OpenCode's native discovery rules. Empty speculative directories are not required.

`<project>/.opencode/opencode.jsonc` is the only project-level OpenCode configuration generated and managed by portable-opencode.

Root `opencode.json` or `opencode.jsonc` files are not silently merged into the portable desired state. Their presence produces a conflict or migration finding.

`<project>/AGENTS.md` remains at the root because it is the repository operating entry point, not an internal OpenCode asset.

### D. Private local data

Never committed:

- API keys and authentication;
- SSH keys and certificates;
- `.env` values;
- secret-bearing local overrides;
- observability databases and raw traces;
- caches, temporary files and private logs.

## 6. One canonical configuration

The MVP does not begin with a profile catalogue.

```text
canonical personal configuration
+ explicit project-specific values
+ minimal private overrides when required
```

A new profile, abstraction or override layer requires a second real configuration that cannot be expressed cleanly through the current model.

## 7. Separate lifecycle models

### Personal environment lifecycle

```text
absent
  → inspected
  → planned
  → installed
  → healthy
      ↘ degraded
      ↘ update-required
      ↘ blocked
```

### Project lifecycle

```text
uninitialized
  → scaffolded
  → configuring
  → ready
      ↘ dirty
      ↘ degraded
      ↘ blocked
```

A generated scaffold is not automatically ready. Readiness requires context, OpenCode configuration, technical baseline, Graphify state and verification gates.

## 8. Operation contract

Every state-changing operation follows:

```text
inspect
  → resolve desired state
  → produce deterministic plan
  → show consequences
  → obtain approval when required
  → apply narrow reversible changes
  → verify
  → record outcome and resulting state
```

Core concepts remain limited to:

- `Finding`;
- `Plan`;
- `Decision`;
- `Operation`;
- `Outcome`;
- `State`.

## 9. Daily coding and inference path

```text
OpenCode session
  → semantic role and request metadata
  → local observability adapter
  → OpenRouter
  → selected model and provider
  → streamed response
  → usage, cost and error correlation
  → OpenCode
```

The project-understanding path is:

```text
user intent
  → curated context
  → Graphify for repository structure
  → LSP for precise language semantics
  → targeted textual search and direct reads
  → plan or implementation
  → canonical verification
  → context, graph or state update when required
```

## 10. Extension model

| Mechanism | Responsibility |
|---|---|
| Root `AGENTS.md` | Permanent repository operating rules |
| `.opencode/opencode.jsonc` | Canonical project OpenCode runtime configuration |
| Agent | Coding role with tools and permissions |
| Command | Explicit user-triggered OpenCode workflow |
| Skill | Reusable procedure loaded when relevant |
| Plugin | Minimal event-driven OpenCode integration |
| Custom tool | Typed operation unavailable through native tools |
| Portable CLI | Installation, inspection, diagnosis and lifecycle control |

Each asset must correspond to an actual repeated behaviour.

## 11. Deliberately deferred architecture

The MVP does not require:

- WSL, Linux or macOS parity;
- multi-user accounts, teams or organizations;
- shared workspace policy distribution;
- a generic profile framework;
- marketplaces;
- remote management or hosted control planes;
- multiple observability backends implemented in advance;
- coding clients other than OpenCode;
- a public SDK;
- autonomous background agents;
- arbitrary legacy-repository migration;
- a configuration TUI before the CLI is proven.

## 12. Initial implementation shape

The smallest credible implementation contains:

- one application core for inspect, plan, apply, verify and state;
- one mandatory Windows-native CLI;
- narrow adapters for the filesystem, processes and selected tools;
- versioned configuration and templates;
- PowerShell bootstrap and recovery scripts only where necessary;
- schemas and tests;
- native OpenCode assets under the selected global and project paths;
- one local observability integration validated by a spike.

The implementation language and distribution mechanism remain open until targeted Windows-native spikes produce evidence.

## 13. Quality priorities

1. reproducibility;
2. inspectability;
3. safety;
4. idempotence;
5. diagnosability;
6. low maintenance overhead;
7. recoverability;
8. focused Windows-native portability.

Generic extensibility and universal compatibility are not MVP priorities.

## 14. Remaining technical uncertainties

Only uncertainties capable of changing the personal MVP architecture should be spiked:

- whether OpenCode discovers and merges `.opencode/opencode.jsonc` exactly as expected on the selected Windows version;
- how unmanaged root OpenCode config conflicts should be detected and migrated;
- which OpenCode extension mechanisms are reliable;
- how session metadata can be correlated with inference requests;
- which OpenRouter preset operations can be automated safely;
- whether the localhost proxy preserves streaming and tool calls;
- whether Phoenix is proportionate and reliable on Windows native;
- how Graphify updates and RTK integration behave on Windows;
- the smallest useful context metadata schema;
- the simplest safe Windows distribution and update mechanism.

A spike removes uncertainty; it does not reopen accepted product defaults without contradictory evidence.

## 15. Architecture completion gate

The architecture is sufficient for implementation when:

- the Windows machine and new-project journey are unambiguous;
- each MVP component has direct personal value;
- configuration ownership and canonical paths are explicit;
- environment and project lifecycles are separately testable;
- operations can be represented without a TUI;
- unresolved mechanisms have bounded spikes;
- the configuration matrix contains no requirement justified only by hypothetical users.
