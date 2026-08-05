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
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
verified:
  - by: repository-owner
    status: pending
---

# Architecture

## 1. Architectural objective

`portable-opencode` reproduces and maintains one deliberate personal agentic coding environment on the repository owner's Windows machine and across new projects.

The governing test is:

> Does this component directly improve the canonical personal workflow or its long-term maintainability?

Anything that exists only for hypothetical users, profiles or platforms is removed, deferred or kept as an internal implementation detail.

## 2. Canonical environment

`DEC-015` fixes the MVP environment as:

```text
Windows native
+ PowerShell
+ Windows Terminal
- WSL
```

All required dependencies, scripts, spikes and end-to-end verification must work through native Windows paths.

## 3. Two paths, one system

### Configuration path

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

```text
User
  → OpenCode
  → project context + Graphify + LSP
  → agents, commands, skills and tools
  → local observability boundary
  → OpenRouter
  → model and provider
  → response, usage, cost and errors
```

RTK reduces terminal noise before it enters agent context. `portable-opencode` configures and maintains the environment; OpenCode remains the agent runtime.

## 4. Minimal components

### 4.1. Portable application core

The core owns only lifecycle behaviour that cannot belong to an upstream tool:

- environment inspection;
- desired-state resolution;
- deterministic change planning;
- safe application and managed backups;
- project scaffolding;
- diagnostics and repair suggestions;
- verification orchestration;
- environment and project state;
- structured outcomes.

It is not a generic workflow engine, plugin platform or agent runtime.

### 4.2. Headless CLI

The CLI is the mandatory control interface. It exposes explicit commands, dry-run and explain output, structured JSON and non-interactive execution. It calls the application core and does not contain a second configuration model.

### 4.3. Deferred configuration TUI

`DEC-013` defers Ratatui until the CLI is effective. A future TUI may only project existing plans, diagnostics and operations.

### 4.4. OpenCode

OpenCode owns:

- sessions and interaction;
- primary agents and subagents;
- commands and skills;
- custom tools and plugins;
- permissions;
- LSP and formatters;
- compaction and watcher behaviour;
- loading project instructions and configuration.

`portable-opencode` generates and validates OpenCode's documented native files rather than recreating these concepts.

### 4.5. OpenRouter

OpenRouter owns:

- model and provider selection;
- routing and fallbacks;
- provider privacy policy;
- presets;
- usage and cost information;
- personal API credentials and remote limits.

Semantic roles are a portable-opencode design abstraction mapped to native OpenRouter policy. The exact OpenCode reference syntax remains subject to `SPIKE-002`.

### 4.6. Local observability

The intended boundary is a native Windows localhost proxy between OpenCode and OpenRouter. It records metadata, usage, cost, latency, fallback and errors by default. Prompt and response capture remains opt-in. Phoenix is the proposed OTLP/OpenInference backend, not the proxy itself.

### 4.7. Graphify

Graphify provides structural memory. The portable layer owns installation checks, `.graphifyignore` composition, explicit update workflows, freshness state and quality auditing. It does not own graph extraction internals.

### 4.8. RTK

RTK owns command rewriting and output reduction. The portable layer installs and verifies its native OpenCode integration and minimal local configuration.

### 4.9. Curated context

Versioned context preserves project definition, vision, architecture, conventions, operations, decisions, roadmap and concise transitions. It is curated knowledge, not a chat archive or event store.

### 4.10. Machine-readable state

State records lifecycle, readiness, degradation, graph freshness, verification results, managed versions and pending decisions. It remains small, inspectable and schema-validated.

## 5. Configuration ownership

### A. Canonical versioned source

Stored in this repository:

- desired OpenCode configuration and native assets;
- OpenRouter semantic-role and preset intent;
- templates and schemas;
- Graphify and RTK policy;
- verification rules;
- documentation and decisions.

### B. Managed personal environment

Materialized on Windows:

- active global OpenCode configuration and assets;
- installed components;
- observability processes;
- generated non-secret tool configuration;
- private installation metadata.

### C. Project-versioned configuration

`DEC-017` fixes the project layout:

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

Only `.opencode/` directories containing real assets are created.

Responsibilities are explicit:

- `opencode.jsonc`: canonical project runtime configuration;
- `AGENTS.md`: root operating rules and context reading order;
- `.opencode/`: native project agents, commands, skills, plugins, tools and themes;
- `tui.jsonc`: optional project TUI preferences beside `opencode.jsonc`, only when a project-specific need exists;
- `.portable-opencode/`: portable lifecycle state and safe generated metadata;
- `docs/context/`: curated project knowledge;
- `.graphifyignore`: versioned Graphify scope policy.

OpenCode's documented project merge semantics remain upstream behaviour. The portable layer chooses and manages one canonical file, then explains additional active sources rather than pretending they do not exist.

### D. Private local data

Never committed:

- API keys and authentication;
- `.env` values;
- SSH keys and certificates;
- secret-bearing overrides;
- observability databases and raw traces;
- caches, temporary files and private logs.

## 6. OpenCode configuration provenance

The effective OpenCode configuration can combine:

```text
remote organizational config
→ global config
→ OPENCODE_CONFIG override
→ project root opencode.jsonc
→ .opencode native assets
→ OPENCODE_CONFIG_CONTENT runtime override
→ managed settings when present
```

For the personal MVP, portable-opencode manages the global configuration it installs, the root project `opencode.jsonc`, and selected native assets. It does not silently absorb arbitrary external overrides.

Diagnostics must report:

- root `opencode.json` as a migration candidate;
- simultaneous root `opencode.json` and `opencode.jsonc` as blocking ambiguity;
- `.opencode/opencode.json(c)` as misplaced unmanaged files;
- active `OPENCODE_CONFIG`, `OPENCODE_CONFIG_DIR` or `OPENCODE_CONFIG_CONTENT` as explicit provenance layers;
- managed Windows settings under `%ProgramData%\opencode` when they affect the result.

## 7. One canonical personal configuration

The MVP uses:

```text
canonical personal configuration
+ project-specific values
+ minimal private override when demonstrated
```

There is no profile catalogue. New variability requires a real second configuration or verified technical need.

## 8. Separate lifecycle models

### Environment

```text
absent → inspected → planned → installed → healthy
                                      ↘ degraded
                                      ↘ update-required
                                      ↘ blocked
```

### Project

```text
uninitialized → scaffolded → configuring → ready
                                      ↘ dirty
                                      ↘ degraded
                                      ↘ blocked
```

Generated files alone do not make a project ready. Readiness requires context, application baseline, valid OpenCode configuration, Graphify state and canonical verification.

## 9. Operation contract

Every state-changing operation follows:

```text
inspect
→ resolve desired state
→ plan
→ show consequences
→ approve when required
→ apply narrow reversible changes
→ verify
→ record outcome and state
```

Core concepts remain limited to `Finding`, `Plan`, `Decision`, `Operation`, `Outcome` and `State`.

## 10. Extension model

| Surface | Responsibility |
|---|---|
| Root `opencode.jsonc` | Project runtime configuration |
| Root `AGENTS.md` | Permanent repository operating rules |
| `.opencode/agents/` | Coding roles and permissions |
| `.opencode/commands/` | Explicit user-triggered workflows |
| `.opencode/skills/` | Reusable procedures loaded on demand |
| `.opencode/plugins/` | Minimal event-driven integration |
| `.opencode/tools/` | Typed operations unavailable natively |
| Portable CLI | Installation, inspection, planning, diagnosis and lifecycle control |

Each asset must correspond to an actual repeated behaviour.

## 11. Deferred architecture

The MVP does not require WSL/Linux/macOS parity, teams, shared workspace policies, generic profiles, marketplaces, hosted control planes, multiple observability backends, coding clients other than OpenCode, a public SDK, autonomous background agents, arbitrary legacy-repository migration or a configuration TUI before the CLI is proven.

## 12. Initial implementation shape

The smallest credible implementation contains:

- one application core;
- one mandatory Windows-native CLI;
- narrow filesystem, process and external-tool adapters;
- versioned native configuration and templates;
- PowerShell bootstrap and recovery only where needed;
- schemas, fixtures and tests;
- one observability integration validated by a spike.

The implementation language and distribution mechanism remain open until targeted Windows-native evidence exists.

## 13. Remaining technical uncertainties

Bounded spikes still need to validate:

- root project config discovery and effective precedence on the supported OpenCode version;
- `.opencode/` asset discovery;
- environment and managed-config provenance on Windows;
- OpenCode plugin stability and available session metadata;
- OpenRouter preset integration through OpenCode;
- proxy transparency and Phoenix viability;
- Graphify and RTK lifecycle on Windows;
- minimal context metadata;
- safe Windows packaging and updates.

A spike validates mechanisms. It does not replace current official documentation with an unsupported convention.

## 14. Completion gate

Architecture is sufficient for implementation when canonical paths and ownership are explicit, lifecycle states are testable, operations do not assume a TUI, every uncertain mechanism has a bounded spike and the configuration matrix contains no speculative productization.
