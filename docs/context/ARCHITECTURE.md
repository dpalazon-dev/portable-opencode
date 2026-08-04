---
type: Architecture
title: Portable OpenCode Architecture
description: Current architectural model, responsibility boundaries and lifecycle of portable-opencode.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - PROJECT.md
  - VISION.md
  - ../SPECIFICATION.es.md
verified:
  - by: repository-owner
    status: pending
---

# Architecture

## Architectural intent

The system configures and coordinates existing components. Its value lies in the **contracts between them**, the lifecycle around them and the quality of the defaults, not in replacing their native capabilities.

## System planes

```text
┌─────────────────────────────────────────────────────────────┐
│ User and project workflow                                   │
│ Headless CLI · proposed Ratatui TUI · OpenCode · context    │
├─────────────────────────────────────────────────────────────┤
│ Shared application and lifecycle engine                     │
│ plans · validation · diagnostics · state · operations       │
├─────────────────────────────────────────────────────────────┤
│ OpenCode runtime                                            │
│ sessions · agents · tools · permissions · plugins · LSP     │
├───────────────────────┬─────────────────────────────────────┤
│ Local observability   │ Project intelligence                │
│ proxy · traces · cost │ Graphify · context · state · RTK     │
├───────────────────────┴─────────────────────────────────────┤
│ OpenRouter control plane                                    │
│ models · providers · routing · fallbacks · privacy · budgets│
└─────────────────────────────────────────────────────────────┘
```

The Ratatui TUI remains proposed under DEC-013. Its presence in this diagram defines the intended boundary, not an implemented capability.

## Component responsibilities

### Application engine, CLI and orchestration

Owns:

- installation and upgrades;
- environment diagnosis;
- project scaffolding;
- profile selection;
- generated configuration;
- deterministic change planning;
- state transitions;
- lifecycle commands;
- migration between repository versions;
- structured progress, diagnostics and operation outcomes.

The application engine must be presentation-independent. The headless CLI is a mandatory first-party adapter and must remain fully usable without a TUI.

It must not implement a second agent runtime.

### Proposed Ratatui configuration TUI

If DEC-013 is accepted after SPIKE-005, the TUI owns only:

- rendering current and desired state;
- navigation and input collection;
- plan and diff inspection;
- progress and failure presentation;
- selection of explicit remediation actions;
- terminal lifecycle and interaction state.

It must call the same application operations as the CLI. It may not mutate files, execute arbitrary commands, own configuration rules or create independent state transitions.

Feature definition: [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md).

### OpenCode

Owns:

- interactive and programmatic sessions;
- primary agents and subagents;
- commands, skills and custom tools;
- permissions and tool execution;
- LSP, formatters and compaction;
- project and global configuration merging.

Extensions should use OpenCode-native mechanisms first.

### OpenRouter

Owns:

- concrete model and provider resolution;
- routing and fallback policy;
- compatibility constraints;
- privacy and data-retention policy;
- usage and cost accounting;
- budgets and key-level governance.

OpenCode-facing configuration should prefer stable semantic roles over repeated concrete model IDs.

### Local observability

Owns:

- transparent capture of inference metadata;
- correlation of OpenCode sessions, agents and commands;
- latency, token, cache, cost, error and fallback traces;
- local query and visual inspection;
- retention and content-capture policy.

The proxy must preserve API semantics. Observability failure must be explicit and must not silently corrupt requests.

### Graphify

Owns:

- structural representation of the repository;
- incremental graph updates;
- graph quality and scope auditing;
- detection of noisy or ambiguous paths;
- persisted decisions about inclusion and exclusion.

Graphify does not replace LSP, textual search or curated context.

### RTK

Owns:

- reduction and structuring of verbose terminal output before it enters model context.

RTK does not own logs, traces or verification truth.

### Curated context

Owns:

- project identity and vision;
- architecture and conventions;
- operational procedures;
- durable decisions and rationale;
- feature definitions;
- roadmap and meaningful history.

Context documents describe the project; machine state records its current lifecycle.

## Configuration layers

### Layer A — global environment

Versioned by this repository and deployed to the user's machine:

- global OpenCode configuration;
- TUI preferences;
- global agents, commands, skills, tools and plugins;
- default OpenRouter policy manifests;
- observability profile;
- RTK and Graphify installation policy;
- global safety defaults.

This layer must not assume a project stack.

### Layer B — project scaffold

Generated into each project:

- local OpenCode configuration;
- `AGENTS.md`;
- `.opencode/` assets;
- context documents;
- `.graphifyignore`;
- project state;
- verification profile;
- stack-specific settings.

### Layer C — private local state

Never versioned:

- credentials and authentication;
- local overrides with secrets;
- trace databases;
- raw private payloads;
- caches, logs and generated temporary state.

## Lifecycle state machine

```text
uninstalled
    ↓ portable-opencode install
installed
    ↓ portable-opencode init-project
scaffolded
    ↓ /init-project
configuring
    ↓ context + technical baseline + graph + verification
ready
    ↘ changes invalidate derived state
     dirty
      ↓ update / verify / resolve decisions
     ready
```

Additional states may include `blocked`, `degraded` and `migration-required`. State transitions must be explicit and testable.

CLI and TUI presentation state must not become lifecycle states of the configured environment.

## Request path

The intended inference path is:

```text
OpenCode session
  → semantic role and request metadata
  → local observability proxy
  → OpenRouter
  → selected model/provider endpoint
  → streamed response
  → local trace correlation
  → OpenCode
```

A bypass mode may send requests directly to OpenRouter, but it must mark observability as degraded.

## Configuration operation path

```text
User input through CLI or proposed TUI
  → desired configuration
  → application engine
  → deterministic plan
  → review / approval
  → system adapters
  → operation result
  → lifecycle state update
  → structured output to the active interface
```

For equivalent inputs, CLI and TUI must produce equivalent plans and outcomes.

## Project intelligence path

```text
User intent
  → curated context
  → Graphify for global structure
  → LSP for language semantics
  → textual search and direct reads
  → plan or implementation
  → verification
  → graph/context/state update
```

## Extension and interface model

Use the following distinction consistently:

| Mechanism | Responsibility |
|---|---|
| `AGENTS.md` | Permanent repository-level operating rules |
| Agent | Role with model, tools and permissions |
| Command | Explicit user-triggered workflow |
| Skill | Reusable procedure loaded on demand |
| Plugin | Event-driven automation |
| Custom tool | Typed executable operation |
| Application engine | Presentation-independent plans, validation, state and operations |
| CLI command | Headless installation, lifecycle or environment operation |
| Ratatui TUI | Optional interactive projection of application operations |

## Initial technical shape

The implementation is expected to contain:

- a presentation-independent application and lifecycle engine;
- a portable headless CLI;
- versioned templates and manifests;
- OpenCode configuration, agents and extensions;
- OpenRouter policy definitions and validation;
- an observability proxy adapter;
- Graphify ignore composition and state management;
- schemas and tests;
- a Ratatui frontend only after DEC-013 and SPIKE-005 justify it.

The exact runtime, package manager and distribution method remain open until the configuration matrix and initial spikes are complete.

## Architectural quality attributes

- reproducibility;
- idempotence;
- transparency;
- safe defaults;
- composability;
- local-first privacy;
- diagnosability;
- cross-platform behaviour;
- low operational overhead;
- graceful degradation;
- interface equivalence;
- recoverable terminal behaviour.

## Known architectural uncertainties

- best implementation boundary for the observability proxy;
- depth of OpenRouter preset and workspace automation available through public APIs;
- reliable session metadata propagation from OpenCode;
- Graphify incremental update and hook behaviour across platforms;
- Windows-native versus WSL installation strategy;
- minimum subset of OKF worth enforcing;
- packaging and update model for plugins and templates;
- whether Ratatui justifies a Rust application core or a separate Rust frontend;
- progress, cancellation and recovery contracts shared by CLI and TUI;
- terminal accessibility and supported platform boundaries.

These require explicit spikes before being converted into fixed architecture.
