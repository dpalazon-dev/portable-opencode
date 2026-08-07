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
- [DESIGN-007 — Managed Configuration Materialization](../design/MANAGED_CONFIGURATION_MATERIALIZATION.md) defines resource ownership, materialization, drift, versions and bootstrap boundaries.
- [DESIGN-008 — Canonical Resource Catalog and File Trees](../design/CANONICAL_RESOURCE_CATALOG.md) fixes canonical environment/project paths, resource IDs and ownership targets.
- [DESIGN-009 — CLI Operation Contracts](../design/CLI_OPERATION_CONTRACTS.md) fixes command semantics, plans, diagnostics, outcomes, exit classes and bootstrap behaviour.
- [DESIGN-010 — Evidence and Spike Mapping](../design/EVIDENCE_AND_SPIKE_MAPPING.md) maps every runtime-evidence contract to a spike or implementation test.
- [DESIGN-011 — PowerShell Script Inventory](../design/POWERSHELL_SCRIPT_INVENTORY.md) limits scripts to bootstrap, repository validation and evidence-gated break-glass recovery.
- [FEAT-001 — Interactive Configuration TUI](../features/CONFIGURATION_TUI.md) is deferred until the CLI is effective.

## Bounded technical spikes

- [SPIKE-001 — OpenCode Windows Lifecycle and Runtime Contract](../spikes/SPIKE-001_OPENCODE_LIFECYCLE.md)
- [SPIKE-002 — OpenRouter Preset and Policy Contract](../spikes/SPIKE-002_OPENROUTER_POLICY.md)
- [SPIKE-003 — Windows-Native Observability Contract](../spikes/SPIKE-003_OBSERVABILITY.md)
- [SPIKE-004 — Graphify and RTK Windows Integration Contract](../spikes/SPIKE-004_GRAPHIFY_RTK.md)

Each spike is an execution brief. Results belong in `docs/spikes/results/` and must preserve tested versions, evidence, contract impact and discard boundaries.

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
| `docs/spikes/` | bounded experiment definitions and sanitized results |
| `docs/features/` | independently reviewable future behaviour |
| `.portable-opencode/state.json` | machine-readable current project state |
| `config/components.jsonc` | evidence-gated supported component intent |
| `config/resources/` | canonical desired resource catalogs |
| `log.md` | concise chronological transitions |

## Current state

- all owner-level configuration defaults are resolved;
- operational resource, CLI, state, diagnostic and evidence contracts are defined;
- SPIKE-001 through SPIKE-004 are ready as bounded Codex assignments;
- `DEC-009`, `DEC-010` and `DEC-012` remain evidence-gated;
- metadata migration and specification v0.3 synchronization still prevent formal Phase 0 closure;
- no executable production implementation exists yet.

## Maintenance rule

A material behavioural, architectural or lifecycle change is incomplete until its owning context, decision, design, roadmap and machine-readable state agree.
