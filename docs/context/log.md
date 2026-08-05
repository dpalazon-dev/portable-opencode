# Context log

This log records outcomes, resulting state and the next action. Detailed rationale lives in canonical context, decision, research and design documents.

## 2026-08-04 — Repository foundation

- created the public repository and initial specification;
- defined OpenCode + OpenRouter as the coherent product foundation;
- introduced Graphify, RTK, structured context and local observability.

## 2026-08-04 — Repository dogfooding established

- added root `AGENTS.md`, context documents, decisions, state and `.graphifyignore`;
- required the repository to expose actual state without conversation history.

## 2026-08-04 — Broad design surface drafted

- proposed a possible Ratatui configurator;
- drafted `DESIGN-001` with 177 capabilities;
- exposed drift toward a generalized product.

## 2026-08-05 — Personal-first scope aligned

- accepted `DEC-014`;
- aligned project, vision, architecture, conventions and operations;
- reduced architecture to one personal configuration, a small CLI core and native upstream surfaces.

## 2026-08-05 — TUI parked

- changed `DEC-013` and `FEAT-001` to deferred;
- removed Ratatui and SPIKE-005 from the active path;
- made a working CLI the prerequisite for any TUI reconsideration.

## 2026-08-05 — Upstream configuration research completed

- reviewed OpenCode, OpenRouter, Graphify, RTK and Phoenix primary documentation;
- created `RESEARCH-001`;
- confirmed that upstream tools should own their native configuration and behaviour.

## 2026-08-05 — Roadmap and matrix rebuilt

- preserved complete canonical scope while simplifying delivery phases;
- made specification, schemas, templates, scripts and CLI contracts explicit deliverables;
- reduced the configuration matrix from 177 to 81 contracts;
- linked remaining uncertainty to four Windows-native spikes.

## 2026-08-05 — Windows-native environment selected

- accepted `DEC-015`;
- selected PowerShell and Windows Terminal;
- removed WSL, Bash and POSIX wrappers from MVP requirements;
- required all spikes and E2E evidence to execute natively on Windows.

## 2026-08-05 — OpenCode project layout corrected

- marked erroneous `DEC-016` superseded;
- accepted `DEC-017`;
- selected root `opencode.jsonc` as project runtime config;
- preserved `.opencode/` as the native asset root;
- added conflict and provenance policies.

## 2026-08-05 — Minimal agent and model policy accepted

- accepted `DEC-018` and created `DESIGN-002`;
- retained native `build`, `plan`, `general`, `explore` and `scout`;
- added only non-mutating `review` and `verify`;
- defined `main`, `reason` and `fast` roles;
- left exact preset reference syntax to `SPIKE-002`.

## 2026-08-05 — Graphify output ownership accepted

- accepted `DEC-019` and created `DESIGN-003`;
- versioned `graph.json`, `GRAPH_REPORT.md` and conditional portable `manifest.json`;
- kept HTML, cache, cost, query logs and optional exports out of Git;
- delegated determinism and portability to `SPIKE-004`.

## 2026-08-05 — Minimal context metadata accepted

- accepted `DEC-011` and created `DESIGN-004`;
- added `schemas/context-document.schema.json`;
- required only `type`, `title`, `description` and `status` for non-reserved documents;
- removed `created`, `modified` and generic `verified` from the target schema;
- made `index.md` and `log.md` frontmatter-free;
- migrated conventions, operations, project, roadmap, index and this log;
- left the remaining inherited documents for a controlled validation migration;
- kept `docs-only` pending until migration completes.

## 2026-08-05 — Windows observability intent defined

- created `DESIGN-005` under proposed `DEC-010`;
- selected native `phoenix serve` in an isolated Python environment;
- selected loopback-only SQLite storage under `%LOCALAPPDATA%`;
- selected on-demand start/stop and 30-day retention;
- disabled Phoenix telemetry and external resources by default;
- excluded Docker, WSL, PostgreSQL, boot services and indefinite retention;
- delegated Phoenix acceptance to `SPIKE-003`.

## 2026-08-05 — Declarative OpenRouter reconciliation accepted

- accepted `DEC-020` and created `DESIGN-006`;
- added `schemas/openrouter-presets.schema.json`;
- fixed managed slugs to `portable-main`, `portable-reason` and `portable-fast`;
- selected inspect, normalized diff, plan, explicit apply and verification;
- missing presets are created after approval;
- drift creates a new active version while preserving history;
- remote deletion, rename and archival are never automatic;
- exact OpenCode preset representation remains `SPIKE-002` evidence.

## 2026-08-05 — Owner defaults closed

- all personal product defaults in `DESIGN-001` are resolved;
- `DEC-009`, `DEC-010` and `DEC-012` remain evidence-gated;
- the matrix remains draft pending contracts, metadata migration, spike mapping and owner approval;
- project state advances from owner-default review to configuration-contract definition.

**Recommended next action**

Define canonical global and project file trees, ownership and exact CLI command contracts before delegating the four spikes.
