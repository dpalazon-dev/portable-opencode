---
type: Project Context
title: Portable OpenCode Project Definition
description: Current identity, primary user, scope, constraints and development state of portable-opencode.
status: active
---

# Project

## 1. Current definition

`portable-opencode` is a public, versioned and reproducible **personal configuration system** for creating and maintaining an opinionated agentic coding environment built jointly on OpenCode and OpenRouter.

OpenCode is the runtime and interaction surface. OpenRouter controls models, providers, routing, privacy, fallbacks and cost. Local observability, Graphify, RTK and structured context complete the canonical environment.

The repository owner is the sole required MVP user. Public reuse is possible but does not drive the architecture. No executable product exists yet; the project remains in **definition and contract design**.

## 2. Canonical personal path

```text
Windows native + PowerShell
→ portable-opencode install
→ healthy OpenCode/OpenRouter environment
→ portable-opencode init-project <path>
→ OpenCode /init-project
→ ready project
→ maintained context, graph, verification and cost visibility
```

WSL-only behaviour is not valid MVP evidence.

## 3. Accepted configuration defaults

### OpenCode project layout

```text
<project>/
├── opencode.jsonc
├── AGENTS.md
├── .opencode/        # native assets only
├── docs/context/
├── .portable-opencode/
├── graphify-out/
├── .gitignore
└── .graphifyignore
```

### Agents and roles

```text
native: build, plan, general, explore, scout
custom: review, verify

build                 → main
plan, review, verify  → reason
general, explore,
scout, small_model    → fast
```

### Graphify output

Version `graph.json`, `GRAPH_REPORT.md` and a validated portable `manifest.json`. Ignore HTML, cache, cost, query logs and optional exports.

### Context metadata

Non-reserved curated documents require `type`, `title`, `description` and `status`. `index.md` and `log.md` have no frontmatter. Inherited metadata migration remains pending.

### Observability intent

Attempt Phoenix as a native on-demand Windows process with private SQLite storage, loopback binding, 30-day retention and telemetry/external resources disabled. `DEC-010` remains evidence-gated by SPIKE-003.

### OpenRouter presets

Manage exactly `portable-main`, `portable-reason` and `portable-fast` from a versioned local manifest. Reconciliation uses inspect, plan, explicit apply and verification. Missing presets are created; drift creates a new version; no remote preset is deleted automatically.

## 4. Problem

A personal agentic environment otherwise accumulates scattered instructions, implicit permissions, coupled model choices, disappearing knowledge, stale graph/context, opaque cost/routing and irreproducible setup.

## 5. Core scope

- inspect, plan, apply, verify and diagnose desired state;
- install and configure OpenCode/OpenRouter coherently;
- install and verify RTK and Graphify;
- run local metadata-first observability;
- scaffold canonical project config, assets, context and state;
- maintain graph freshness and versioned structural memory;
- reconcile three semantic OpenRouter presets;
- encode permissions, privacy and destructive boundaries;
- expose provenance, drift, health and readiness;
- support backups, upgrades and recovery.

## 6. Explicit non-goals

- a new coding client or generic multi-agent framework;
- WSL, Linux or macOS parity;
- teams, organizations, profiles or marketplaces;
- broad MCP infrastructure;
- arbitrary legacy migration;
- remote-first observability;
- agent/export catalogues;
- a configuration TUI before the CLI is proven.

## 7. Current repository state

Completed:

- personal-first and Windows-native scope;
- current upstream configuration research;
- corrected OpenCode project layout;
- TUI deferral and roadmap simplification;
- 81-contract configuration matrix;
- agent/model role policy;
- Graphify output policy;
- minimal context metadata policy and schema;
- intended Phoenix lifecycle policy;
- declarative preset reconciliation policy.

Pending:

- metadata migration and docs validation;
- complete canonical global/project file trees and ownership;
- state, environment and managed-resource schemas;
- exact CLI, diagnostics and PowerShell script contracts;
- specification v0.3 synchronization;
- SPIKE-001 through SPIKE-004;
- evidence-based decisions for language, Phoenix and packaging;
- implementation, tests and release.

## 8. Evidence-gated decisions

- `DEC-009`: implementation language;
- `DEC-010`: Phoenix acceptance;
- `DEC-012`: final packaging/distribution.

These are not owner defaults to decide in prose. They require Windows-native evidence.

## 9. Constraints

- solve the owner's workflow first;
- use native upstream surfaces;
- keep secrets/private state outside Git;
- require native Windows evidence;
- keep defaults safe and inspectable;
- make operations deterministic, idempotent and recoverable;
- do not claim unverified support;
- retain only abstractions and artefacts with current value.

## 10. Definition-phase completion

The phase completes when metadata migration, file ownership, CLI contracts, schemas and spike mappings are explicit; the specification is synchronized; and Codex can execute the four spikes without inventing product behaviour.
