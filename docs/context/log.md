# Context log

This log records outcomes, resulting state and the next action. Detailed rationale lives in canonical context, decision, research and design documents.

## 2026-09-10 — Guided installation and onboarding contract defined

- created `DESIGN-013` for public GitHub Release distribution, the minimal PowerShell bootstrap, guided CLI installation, complete non-mutating preflight, browser-assisted native authentication, private checkpoints, resume/retry/recovery, optional Git/GitHub/SSH and final health classification;
- accepted `DEC-022` without resolving `DEC-009`, `DEC-012`, OpenCode runtime/auth evidence, the authenticated `SPIKE-002` gate, `SPIKE-003` or Phoenix;
- synchronized the specification, architecture, project, operations, roadmap, CLI, PowerShell inventory, resource catalog, configuration matrix and machine-readable state;
- at that point, the next action was owner review of `DESIGN-013`; that approval is now recorded below before implementation planning.

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

## 2026-08-06 — Managed configuration concepts accepted

- accepted `DEC-021` and created `DESIGN-007`;
- defined `rendered`, `copied`, `linked`, `queried` and `private` materialization modes;
- selected copied/rendered defaults and made links Windows evidence-gated;
- prohibited replacement, detachment or deletion without proven ownership;
- moved the supported-component version manifest into contract definition;
- constrained PowerShell bootstrap to establishing and invoking the CLI;
- added generated-file, bug-reproduction, context-pressure and parallel-session validation rules;
- explicitly excluded general dotfiles, desktop personalization and terminal multiplexing from the MVP.

## 2026-08-07 — Operational contracts and spike briefs completed

- created `DESIGN-008` with exact canonical repository, personal-environment and new-project trees;
- instantiated machine-readable environment and project resource catalogs with stable resource IDs and ownership;
- created an evidence-gated `config/components.jsonc` rather than guessing supported versions;
- created project state, private environment state, managed-resource, inventory, resource-catalog, operation-result and verification-manifest schemas;
- created `DESIGN-009` with exact CLI command semantics, deterministic plan/apply behaviour, outcomes, diagnostics and exit classes;
- created `DESIGN-010` mapping every runtime-evidence contract to a bounded spike or post-spike implementation test;
- created `DESIGN-011` limiting PowerShell to bootstrap, repository validation and evidence-gated break-glass recovery;
- wrote executable Codex briefs for SPIKE-001 through SPIKE-004 with scope, safety, procedure, evidence, acceptance criteria, decision impact and discard boundaries;
- selected `SPIKE-001 → SPIKE-002 → SPIKE-004 → SPIKE-003` as the recommended technical validation order.

## 2026-08-07 — Operational contracts merged and repository CI added

- merged the operational-contract work into `main`;
- implemented `scripts/verify-docs.ps1` as the single repository-validation entry point;
- pinned repository-only validation dependencies in `scripts/requirements-docs.txt`;
- added `.github/workflows/ci.yml` on `windows-latest` for pull requests and pushes to `main`;
- kept GitHub Actions as a thin adapter that invokes the same local validator rather than duplicating validation logic;
- kept Python validation dependencies strictly as development tooling, without resolving the product implementation-language decision;
- confirmed inherited metadata still exists, so the first expected CI failure should expose migration debt rather than be treated as product failure.

## 2026-08-07 — Codex development hierarchy defined

- added rich repository-local Codex specialist roles under `.codex/agents/` while keeping them separate from OpenCode product agents;
- added `development-orchestrator` as the single master role and kept configured delegation depth at `1`;
- created `DESIGN-012` with parent-mediated specialist routing, advisor/worker/quality role classes, fresh review and explicit retry/block rules;
- created `schemas/codex-work-package.schema.json` so delegated implementation has explicit goal, scope, invariants, verification, stop conditions and deliverables;
- created `schemas/codex-task-receipt.schema.json` so workers return changed files, real checks, deviations, blockers and residual risks;
- made the orchestration protocol binding in `AGENTS.md` and corrected its stale reference to deprecated `modified` frontmatter;
- created `SPIKE-000` to test actual Codex role discovery, named-role routing, depth-1 behavior, Work Package/Receipt flow, fresh review and negative routing control before trusting the hierarchy;
- changed the technical-validation order to `SPIKE-000 → metadata migration + green CI → SPIKE-001 → SPIKE-002 → SPIKE-004 → SPIKE-003`.

**Recommended next action**

Run `SPIKE-000` from Codex on Windows. If the hierarchy passes or its exact semantic-vs-structural limitations are documented, use the validated `development-orchestrator` workflow to complete the controlled metadata migration and obtain the first green repository CI before starting `SPIKE-001`.

## 2026-09-09 — SPIKE-000 executed with partial support

- ran the bounded Windows-native Codex orchestration probe on `spike/000-codex-orchestration`;
- validated Work Package and Task Receipt instances against their repository schemas;
- observed bounded worker behavior, independent test/review behavior and safe negative routing failure;
- did not observe an explicit named-role selector, structural role identity or runtime depth-1 enforcement;
- classified the result as `INCONCLUSIVE / partially supported` and recorded sanitized evidence in `docs/spikes/results/SPIKE-000_RESULT.md`;
- removed the disposable fixture after evidence capture;
- next action is controlled metadata migration plus the canonical docs validator, with routing limitations kept explicit.

## 2026-09-09 — Metadata migration and local validator green

- migrated the five inherited frontmatter documents by removing deprecated `created`, `modified` and `verified` fields and converting material sources to structured entries;
- updated the two instance schemas to admit their existing `$schema` annotations;
- ran `scripts/verify-docs.ps1`, which passed with 65 tracked files, 16 parsed JSON/JSONC documents, 12 schemas and 26 curated frontmatter documents;
- confirmed `git diff --check` and direct `state.json` parsing pass, with no known temporary fixture paths remaining;
- kept the SPIKE-000 prompt/policy-mediated routing limitation explicit and did not start SPIKE-001;
- next action is specification v0.3 synchronization and owner review, followed by the still-unstarted runtime spikes.

## 2026-09-09 — CI-equivalent validation and specification v0.3 draft

- inspected `.github/workflows/ci.yml` and ran its local Windows/PowerShell validator path with the pinned documentation dependencies under Python 3.12; Python 3.13 from CI is not installed locally;
- `scripts/verify-docs.ps1` passed with 65 tracked files, 16 parsed JSON/JSONC documents, 12 schemas and 26 curated frontmatter documents;
- `ci.yml` parsed as YAML, `state.json` parsed and validated against `.portable-opencode/state.schema.json`, and `git diff --check` passed;
- synchronized `docs/SPECIFICATION.es.md` to a v0.3 draft aligned with the current personal-first contracts, while retaining explicit owner questions and evidence-gated decisions;
- kept `SPIKE-000_RESULT.md` unchanged and did not start `SPIKE-001`;
- next action is owner review of the v0.3 draft and its four concrete questions before runtime-spike execution.

## 2026-09-09 — Owner approval of specification v0.3 scope

- approved the personal-first and Windows-native MVP scope without profiles, teams, organizations or an alternative observability backend;
- approved the canonical CLI surface from `DESIGN-009` and the resource tree from `DESIGN-008`;
- approved retaining `DEC-009`, `DEC-010` and `DEC-012` as evidence-gated decisions;
- confirmed that no additional unsupported v0.2 promises, including gratuity, profiles or team compatibility, are retained;
- next action is to prepare the reviewed changes for commit/push and obtain the first green remote CI result before `SPIKE-001`.

## 2026-09-09 — First green remote CI

- pushed the approved v0.3 documentation and state changes to `main` over SSH;
- fixed the validator so result documents under `docs/spikes/results/` are not mistaken for spike briefs requiring duplicate IDs;
- GitHub Actions run `34339325620` passed on `windows-latest` with Python 3.13;
- repository validation is now green locally and remotely;
- `SPIKE-001` is unblocked as the next technical-validation step.

## 2026-09-09 — SPIKE-001 executed with bounded evidence

- rechecked the publication gate: `601d068` is an ancestor of `origin/main`; its historical CI failure was corrected by `1c90a51`, and the current `origin/main` commit `fde157d` passed CI in run `34339478515`;
- installed `opencode-ai@1.18.30` under a disposable npm prefix and isolated OpenCode state with native Windows PowerShell;
- demonstrated global/project/custom/inline config merge, Git-root discovery, `.opencode/` agents/commands/skills, permission last-match behavior, local server startup, synthetic parallel session records, plugin config-hook loading, and copied/rendered materialization;
- observed that root JSON plus JSONC merge in the tested version and `.opencode/opencode.jsonc` is loaded as a higher project layer; these are evidence for contract review, not silent policy changes;
- observed symbolic-link creation failing with `UnauthorizedAccessException` while a junction succeeded in the temporary fixture;
- classified the result as `INCONCLUSIVE` because auth, provider-backed turns, real command/subtask execution, formatter execution, watcher events, compaction/context limits, managed settings and organization configuration were not proven;
- removed disposable package, fixture, session, server and materialization artifacts; no commit or push was made;
- next action is review and reconciliation of `docs/spikes/results/SPIKE-001_RESULT.md` before SPIKE-002.

## 2026-09-09 — SPIKE-001 reconciled before SPIKE-002

- kept `SPIKE-001` `INCONCLUSIVE` and preserved the original result evidence without provider-backed execution or credential use;
- synchronized the version-scoped configuration findings: root JSON plus JSONC merge and `.opencode/opencode.jsonc` loading are observed only in `opencode-ai@1.18.30`, while the canonical root `opencode.jsonc` and duplicate/noncanonical-file policy remain unchanged;
- recorded the Windows PowerShell 5.1 BOM hazard as an implementation test, kept symbolic-link creation as `FAIL`, and kept junction success from becoming a link substitution policy;
- kept provider-backed execution, auth-store mechanics, formatter execution, organization configuration and managed Windows settings as `NOT TESTED`, with watcher/compaction/context-pressure limitations still `INCONCLUSIVE`;
- corrected stale CI and specification-v0.3 state to remote-green, and marked SPIKE-002 unblocked after this reconciliation without starting it;
- next action is to execute SPIKE-002 under its own brief and safety boundary.

## 2026-09-09 — SPIKE-002 executed without private authentication

- confirmed the reconciled SPIKE-001 result remains version-scoped `INCONCLUSIVE` with its provider/auth/runtime limitations intact;
- checked the official OpenRouter v1 preset list, get, version and create-from-skin documentation and observed HTTP `401` for unauthenticated list/get requests;
- used only the run-scoped temporary slug names in the test boundary, made no remote mutation, and did not read or print credentials;
- proved missing/in-sync/reordered/unknown-field/drift/unauthorized comparison outcomes and a one-slug-at-a-time partial-failure model in a disposable local synthetic prototype;
- kept `DEC-020`, the three semantic role mappings and the no-automatic-delete policy, while leaving the exact OpenCode representation `BLOCKED / UNVERIFIED` and the concrete manifest pending;
- recorded documented privacy, routing, fallback, usage, cache, reasoning and cost fields without claiming live availability;
- updated the state, roadmap, component notes and design evidence; no SPIKE-003 or SPIKE-004 work was started and no commit or push was made.

**Next action:** obtain a separately authorized private credential context for the authenticated portions, then validate the OpenCode preset path before promoting any concrete manifest values.

## 2026-09-09 — SPIKE-004 executed with partial Windows-native evidence

- installed Graphify `0.9.56` from `graphifyy==0.9.56` in a disposable Python 3.12 venv and RTK `0.48.0` from the verified official Windows ZIP downloaded through `winget`;
- exercised synthetic fixtures for Graphify extraction, `.gitignore`/`.graphifyignore`, quality comparisons, deterministic report generation with `PYTHONHASHSEED=0`, clone/incremental update, manifest portability, corruption recovery and disposable hook install/uninstall;
- accepted the versioned Graphify allowlist `graph.json`, `GRAPH_REPORT.md` and conditional `manifest.json`; kept cache, HTML, cost, query logs, analysis/root files and optional exports private or ignored;
- verified Graphify OpenCode installation as an upstream project integration and RTK `rtk init -g --opencode` as an upstream global TypeScript plugin delegating to `rtk rewrite`; no provider-backed OpenCode turn was run;
- verified RTK exclusions, private failures-only tee, gain statistics and pass-through degradation; no alternate filter layer or Graphify MCP was added;
- backed up and removed the accidental disposable-test write to the real RTK OpenCode plugin target, verified the global target absent, and left no integration active;
- classified SPIKE-004 as `PARTIAL`, updated `DESIGN-003`, `DESIGN-008`, `config/components.jsonc`, state and roadmap, and did not start SPIKE-003 or use OpenRouter credentials.

## 2026-09-09 — Final reconciliation of SPIKE-001, SPIKE-002 and SPIKE-004

- preserved the final classifications: SPIKE-001 `INCONCLUSIVE`, SPIKE-002 `INCONCLUSIVE` and SPIKE-004 `PARTIAL`;
- promoted only Graphify `0.9.56` and RTK `0.48.0` with their evidenced Windows-native mechanisms; OpenCode, OpenRouter and Phoenix remain pending;
- reconciled result-document frontmatter with the repository lifecycle schema without changing the classifications stated in the reports;
- recorded the exact authenticated SPIKE-002 gate: private credential boundary, live three-slug lifecycle, normalization/idempotence, partial failure, exact OpenCode representation, role/tool/fallback smoke tests, privacy visibility and usage metadata;
- audited `docs/superpowers/plans/2026-09-09-spike-002-openrouter-policy.md` as a disposable execution plan: it is not a canonical source or spike deliverable, and its evidence is superseded by the sanitized result;
- removed the disposable plan and confirmed no fixtures, processes, hooks, plugins, caches or temporary logs remain in the repository;
- kept SPIKE-003 defined, blocked and not started until the authenticated SPIKE-002 gate is complete; no commit or push was performed.

## 2026-09-10 — DESIGN-013 review corrections

- reconciled the private environment-state contract to schema `0.2.0`, including the guided-install lifecycle, plan phases, authentication epoch, checkpoint sequence, progress and recovery fields;
- made preflight explicitly read-only: it returns in-memory evidence and does not persist state or create a checkpoint; the first checkpoint is written transactionally only after approval and immediately before an approved side effect;
- added the mandatory post-authentication inspection, authenticated plan and second explicit approval, with pre-authentication plans unable to authorize remote mutations;
- replaced the `--json` illustration with an envelope valid against `schemas/operation-result.schema.json` and prohibited browser/native-auth UI in non-interactive mode;
- documented that a checksum published by the same GitHub Release detects transfer corruption but is not an origin trust root; production bootstrap requires an independently provisioned trust anchor, with the mechanism still evidence-gated by `DEC-012`;
- kept implementation, `SPIKE-003`, credentials, commit and push out of scope while owner review was still pending at the time of that entry; approval is now recorded below.

## 2026-09-10 — DESIGN-013 security and outcome corrections

- required independent authentication of the exact bootstrap bytes before PowerShell execution and prohibited download-and-pipe execution of unverified scripts;
- removed the temporary-write preflight exception and defined all write/process-side-effect checks as approved, checkpointed plan operations;
- closed the secret boundary by requiring child-process environment allowlists, sanitized native-auth status only, no captured auth I/O and fail-closed verification when sanitized status is unavailable;
- defined transactional bootstrap staging, immutable activation, previous-CLI preservation, interruption recovery and ownership-safe cleanup without selecting the package mechanism;
- added mandatory `last_outcome` to private environment state and distinguished it from lifecycle and health classification;
- clarified that `diagnostics` is always an array and may be empty for healthy results; no synthetic success finding is emitted;
- kept `DEC-009`, `DEC-012`, OpenCode, the authenticated `SPIKE-002` gate, `SPIKE-003`/Phoenix and all implementation work pending.

## 2026-09-10 — Owner approval of DESIGN-013

- recorded the owner's approval of `DESIGN-013` and retained `DEC-022` as accepted;
- changed the current next action from design review to implementation planning;
- preserved `DEC-009`, `DEC-012`, `SPIKE-001` `INCONCLUSIVE`, `SPIKE-002` `INCONCLUSIVE` with its authenticated gate pending, `SPIKE-003` blocked/not started, `SPIKE-004` `PARTIAL`, Phoenix/`DEC-010` pending and the absence of a concrete OpenRouter preset manifest;
- did not authorize implementation of any mechanism whose evidence gate remains unresolved.

## 2026-09-10 — DESIGN-013 acquisition-gate and bootstrap-ownership correction

- separated the already trusted acquisition launcher/gate, which authenticates the exact bootstrap bytes before execution, from the authenticated `bootstrap.ps1`, which verifies the Release manifest and establishes the CLI;
- limited bootstrap ownership and recovery to its private staging roots, immutable CLI identities, active selector, identity metadata, recognized temporaries and last-verified-CLI restoration;
- kept environment lifecycle, managed resources, plans, approvals, checkpoints, backups, ownership, drift and recovery exclusively under `portable-opencode install`;
- recorded that the installed CLI is not part of the environment managed-resource graph and kept the launcher, signature, trust-root and package mechanisms evidence-gated.
