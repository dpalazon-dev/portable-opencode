# Project context

## Canonical reading order

1. [PROJECT.md](PROJECT.md) — current project identity, scope and status.
2. [VISION.md](VISION.md) — desired personal outcome.
3. [ARCHITECTURE.md](ARCHITECTURE.md) — boundaries, ownership and lifecycle.
4. [CONVENTIONS.md](CONVENTIONS.md) — repeated repository rules.
5. [OPERATIONS.md](OPERATIONS.md) — work and verification workflow.
6. [DECISIONS.md](DECISIONS.md) — accepted, proposed, superseded and deferred choices.
7. [ROADMAP.md](ROADMAP.md) — ordered delivery path.
8. [log.md](log.md) — concise meaningful transitions.

The broad specification remains in [../SPECIFICATION.es.md](../SPECIFICATION.es.md). Accepted decisions and current context take precedence until it is synchronized as personal-first v0.3.

## Supporting evidence and design

- [RESEARCH-001 — Configuration Surface Research](../research/CONFIGURATION_SURFACE_RESEARCH.md) records official upstream surfaces and the corrected OpenCode project layout.
- [DESIGN-001 — Configuration Matrix](../design/CONFIGURATION_MATRIX.md) maps 81 personal-first contracts.
- [DESIGN-002 — Agent and Model Role Policy](../design/AGENT_AND_MODEL_ROLES.md) defines native/custom agents and semantic roles.
- [DESIGN-003 — Graphify Output Ownership Policy](../design/GRAPHIFY_OUTPUT_POLICY.md) defines versioned and private graph output.
- [DESIGN-004 — Minimal Context Metadata Schema](../design/CONTEXT_METADATA_SCHEMA.md) defines curated document metadata and migration.
- [DESIGN-005 — Windows-Native Observability Lifecycle](../design/OBSERVABILITY_LIFECYCLE.md) defines the Phoenix/proxy intent pending SPIKE-003.
- [DESIGN-006 — OpenRouter Preset Reconciliation](../design/OPENROUTER_PRESET_RECONCILIATION.md) defines declarative three-preset management.
- [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md) is deferred until the CLI is effective.

## Source responsibilities

| Source | Responsibility |
|---|---|
| `PROJECT.md` | current identity, user, scope and status |
| `VISION.md` | desired outcome and success conditions |
| `ARCHITECTURE.md` | component ownership and lifecycle |
| `CONVENTIONS.md` | stable repeated rules |
| `OPERATIONS.md` | work and verification workflow |
| `DECISIONS.md` | durable rationale and decision status |
| `ROADMAP.md` | delivery order and gates |
| `docs/research/` | current external evidence |
| `docs/design/` | implementable contracts |
| `docs/features/` | independently reviewable future behaviour |
| `.portable-opencode/state.json` | machine-readable current state |
| `log.md` | concise chronological transitions |

## Current state

- all owner-level configuration defaults are resolved;
- `DEC-009`, `DEC-010` and `DEC-012` remain evidence-gated;
- metadata migration is in progress;
- canonical file-tree and CLI contracts are the next work;
- no executable implementation exists yet.

## Maintenance rule

A material behavioural, architectural or lifecycle change is incomplete until its owning context, decision, design, roadmap and machine-readable state agree.
