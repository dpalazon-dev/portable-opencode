---
type: Architecture
title: Portable OpenCode Architecture
description: Personal-first architecture, responsibility boundaries and lifecycle for the canonical portable-opencode workflow.
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

`portable-opencode` exists to reproduce and maintain one deliberate personal agentic coding environment across the repository owner's supported machines and new projects.

The architecture should be no more general than that problem requires.

Its value is not the number of abstractions it exposes. Its value is that the owner can:

1. inspect the current environment;
2. understand the proposed changes;
3. install or initialize safely;
4. verify the resulting state;
5. use OpenCode with explicit routing, permissions, context and observability;
6. recover the same working model later without relying on memory.

The governing test for every architectural element is:

> Does this component or abstraction directly improve the canonical personal workflow, or is it only preparing for hypothetical users and scenarios?

Elements that fail this test are removed from the MVP, deferred or kept as an implementation detail rather than promoted to a product concept.

## 2. Two paths, one system

The system has two distinct paths.

### Configuration path

Used to inspect, install, initialize, diagnose and repair the environment.

```text
User
  → headless CLI
  → small application core
  → explicit plan
  → review and approval
  → system adapters
  → filesystem and external tools
  → verification
  → recorded state
```

A future Ratatui interface may project the same operations, but it is not part of the core and does not own mutation logic.

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

These paths cooperate, but must not be confused. `portable-opencode` configures and maintains the environment; OpenCode remains the agent runtime.

## 3. Minimal architectural components

### 3.1. Portable application core

The core owns only the deterministic lifecycle behaviour that cannot belong to OpenCode, OpenRouter or another existing component:

- environment inspection;
- desired-state resolution;
- change planning;
- safe application of approved changes;
- project scaffolding;
- diagnostics and repair suggestions;
- verification orchestration;
- explicit lifecycle state;
- structured operation results.

The core must remain small. It is not a generic workflow engine, plugin platform or agent runtime.

For the MVP there is one canonical personal configuration. A general profile framework is not required. Local overrides may be introduced only for a demonstrated personal need.

### 3.2. Headless CLI

The CLI is the mandatory control interface.

It must support:

- normal interactive use;
- explicit commands;
- dry-run or explain mode;
- machine-readable output where useful;
- non-interactive execution for repeatability and testing.

The CLI calls the application core. It does not contain a second set of configuration rules.

### 3.3. Proposed Ratatui interface

The Ratatui TUI remains a proposed optional adapter under `DEC-013` and [FEAT-001](../features/CONFIGURATION_TUI.md).

If accepted, it may render state, collect choices, inspect plans and present progress. It must call the same core operations as the CLI.

It must not:

- become required for installation or repair;
- introduce an independent configuration model;
- mutate files or execute tools directly;
- replace the OpenCode interface;
- justify a profile system or broader product architecture by itself.

The TUI feature definition requires a later personal-first review before implementation.

### 3.4. OpenCode

OpenCode owns the coding interaction layer:

- sessions;
- primary agents and subagents;
- commands and skills;
- custom tools and plugins;
- permissions and tool execution;
- LSP and formatters;
- compaction and project instruction loading.

`portable-opencode` should configure these native capabilities rather than recreate them.

### 3.5. OpenRouter

OpenRouter owns:

- concrete model and provider selection;
- routing and fallbacks;
- privacy-related provider policy;
- usage and cost information;
- the personal API credential and remote account limits.

OpenCode-facing configuration should use a small set of stable semantic roles where this reduces repeated model coupling. The MVP does not require organization governance, shared workspaces or a general policy-management product.

### 3.6. Local observability

Observability exists to answer personal operational questions:

- which model and provider handled a request;
- how long it took;
- how many tokens it used;
- what it cost;
- whether a fallback or error occurred;
- which OpenCode session or operation produced it.

The intended boundary is a local transparent adapter between OpenCode and OpenRouter, subject to `SPIKE-003`.

Metadata, usage and errors are collected by default. Full prompt and response capture remains opt-in. Observability data and databases are local private state.

The MVP needs one working local observability path, not a backend abstraction framework. Replaceability should come from a narrow adapter boundary, not multiple prebuilt backends.

### 3.7. Graphify

Graphify is the structural memory of the codebase and remains part of the canonical personal setup.

The portable layer owns only:

- installation and health checks;
- `.graphifyignore` composition;
- update triggers or commands;
- graph freshness state;
- quality auditing;
- persisted inclusion and exclusion decisions.

It does not own graph generation internals and does not replace LSP, textual search or curated project context.

### 3.8. RTK

RTK reduces verbose terminal output before it consumes agent context.

The portable layer installs it, verifies it and applies the minimal integration necessary for the canonical workflow. It does not build a generic output-processing pipeline.

### 3.9. Curated project context

Versioned context owns information that should survive sessions and remain understandable without chat history:

- current project definition;
- vision;
- architecture;
- conventions;
- operations;
- durable decisions;
- roadmap;
- meaningful context log;
- independently reviewable feature or design documents.

Context is curated knowledge. It is not an event store, chat archive or replacement for source code.

### 3.10. Machine-readable state

Machine-readable state records operational facts that should not be inferred from prose:

- initialization stage;
- readiness;
- degraded or blocked conditions;
- graph freshness;
- verification result;
- active project or environment version;
- pending decisions required to continue.

State must be small, inspectable and schema-validated. It must not duplicate every configuration value or become a database for hypothetical future features.

## 4. Configuration ownership

The MVP uses four ownership boundaries.

### A. Canonical versioned source

Stored in this repository:

- default OpenCode configuration;
- agents, commands, skills, tools and plugins actually used by the owner;
- OpenRouter semantic-role intent;
- installation and project templates;
- Graphify and RTK integration policy;
- schemas and verification rules;
- documentation and decisions.

This is the source from which the owner's environment is reproduced.

### B. Managed personal environment

Materialized on the owner's machine:

- active global OpenCode configuration;
- installed portable components;
- local observability services or processes;
- generated non-secret tool configuration;
- local installation metadata.

These files may be generated or updated from the canonical repository. They are not automatically source-of-truth merely because they are currently active.

### C. Project-versioned configuration

Generated into each new project:

- `AGENTS.md`;
- local OpenCode configuration and relevant `.opencode/` assets;
- curated context documents;
- `.graphifyignore`;
- project lifecycle state that is safe to version;
- canonical verification commands and project-specific conventions.

Only behaviour that genuinely varies by project belongs here.

### D. Private local data

Never committed:

- API keys and authentication;
- SSH keys and certificates;
- `.env` values;
- local overrides containing secrets;
- observability databases and raw traces;
- caches, temporary files and logs with private content.

The system must explain where private values are expected without copying them into versioned templates.

## 5. One canonical configuration

The MVP does not begin with a profile catalogue.

```text
canonical personal configuration
+ explicit project-specific values
+ minimal local overrides when required
```

A new profile, abstraction or override layer is justified only when the owner has a second real configuration that cannot be expressed cleanly through the existing model.

This rule applies to:

- operating systems;
- OpenCode agents;
- OpenRouter model policies;
- observability backends;
- Graphify strategies;
- project templates;
- user interfaces.

The architecture may preserve narrow replacement boundaries around external dependencies, but it must not expose unused variability as MVP product surface.

## 6. Separate lifecycle models

The environment and each project have different lifecycles and should not share one overloaded state machine.

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

- `healthy`: the canonical personal environment passes required checks;
- `degraded`: useful work remains possible, but an optional or bypassable capability is unavailable;
- `update-required`: the managed environment differs from the supported repository version;
- `blocked`: a required dependency, credential or safety condition prevents the requested operation.

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

- `scaffolded`: deterministic files exist, but semantic initialization is incomplete;
- `configuring`: `/init-project` or equivalent context and technical setup is in progress;
- `ready`: context, graph and canonical verification meet the project gate;
- `dirty`: derived state such as Graphify or verification is stale after relevant changes;
- `degraded`: development can continue with a known non-critical limitation;
- `blocked`: a required decision or failed gate prevents readiness or a requested operation.

CLI or TUI navigation state is never part of either lifecycle.

## 7. Operation contract

Every state-changing operation follows the same sequence:

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

An operation is incomplete if it mutates the environment without reporting what changed and whether verification passed.

Core operation concepts are intentionally limited to:

- `Finding`: an observed fact or problem;
- `Plan`: the proposed changes and consequences;
- `Decision`: a user choice required to proceed;
- `Operation`: an approved bounded action;
- `Outcome`: success, degradation, block or failure;
- `State`: the resulting environment or project status.

These concepts serve the CLI and possible TUI. They are not intended as a public automation framework.

## 8. Daily coding and inference path

The intended inference path remains:

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

A direct OpenRouter bypass may exist for repair or failure scenarios, but it must make the loss of observability visible.

The intended project-understanding path is:

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

## 9. Extension model

Use existing extension mechanisms with precise responsibilities:

| Mechanism | Responsibility |
|---|---|
| `AGENTS.md` | Permanent repository operating rules |
| Agent | Coding role with tools and permissions |
| Command | Explicit user-triggered OpenCode workflow |
| Skill | Reusable procedure loaded when relevant |
| Plugin | Minimal event-driven OpenCode integration |
| Custom tool | Typed operation unavailable through native tools |
| Portable CLI | Installation, inspection, diagnosis and lifecycle control |
| Ratatui TUI | Optional projection of portable operations |

Do not add an extension merely because OpenCode supports that mechanism. Each asset must correspond to an actual repeated behaviour in the canonical personal workflow.

## 10. Deliberately deferred architecture

The MVP does not require:

- multi-user accounts, roles or organizations;
- team or workspace policy distribution;
- a generic profile framework;
- equal support for all operating systems;
- a marketplace for templates, plugins or skills;
- remote management or a hosted control plane;
- multiple observability backends implemented in advance;
- generic adapters for coding clients other than OpenCode;
- a public SDK or extension API;
- background autonomous agents;
- enterprise governance, auditing or compliance features;
- migration support for arbitrary legacy repositories;
- embedding Phoenix or Graphify exploration inside the portable TUI.

These may be reconsidered only after a real personal or repeated external requirement appears.

## 11. Initial implementation shape

The smallest credible implementation contains:

- one application core for inspect, plan, apply, verify and state;
- one mandatory CLI;
- narrow adapters for the filesystem, processes and external tools;
- versioned configuration and templates;
- schemas and tests;
- OpenCode extensions only where native configuration is insufficient;
- one local observability integration validated by a spike;
- optional Ratatui code only after the core contracts are stable and `SPIKE-005` supports it.

The repository should not begin as a large monorepo of speculative packages. Modules or packages should appear when the implementation presents a real ownership, runtime or testing boundary.

The implementation language and distribution mechanism remain open until the targeted spikes produce evidence.

## 12. Quality priorities

In order of importance for the personal MVP:

1. **Reproducibility**: the same versioned inputs reproduce an equivalent environment.
2. **Inspectability**: active state and proposed changes can be understood.
3. **Safety**: secrets remain private and destructive changes require explicit approval.
4. **Idempotence**: repeated operations converge or refuse safely.
5. **Diagnosability**: failures explain what is wrong and what can be done.
6. **Low maintenance overhead**: the system saves more effort than it creates.
7. **Recoverability**: partial failure does not leave the machine or project opaque.
8. **Focused portability**: the owner's supported environments work reliably before broader parity.

Generic extensibility, universal compatibility and enterprise scalability are not MVP quality priorities.

## 13. Technical uncertainties that remain valid

Only uncertainties capable of changing the personal MVP architecture should be spiked:

- which OpenCode configuration and extension mechanisms are actually reliable;
- how OpenCode session metadata can be correlated with requests;
- which OpenRouter capabilities can be configured or only observed;
- whether a transparent local observability adapter preserves streaming and tool calls;
- whether Phoenix is proportionate for one personal environment;
- how Graphify updates and hooks behave in the owner's primary platform;
- whether Windows native, WSL or a hybrid path is the canonical environment;
- whether Ratatui provides enough value to justify Rust in the executable boundary;
- the smallest useful context metadata schema;
- the simplest safe distribution and update mechanism.

A spike should remove uncertainty, not demonstrate engineering ambition.

## 14. Architecture completion gate

The architecture is sufficient for implementation when:

- the canonical personal machine and project journey are unambiguous;
- each MVP component has a direct personal value;
- configuration ownership is explicit;
- environment and project lifecycles are separately testable;
- planned operations can be represented without assuming a TUI;
- all unresolved technical mechanisms have a bounded spike;
- the reduced configuration matrix contains no requirement justified only by hypothetical users.
