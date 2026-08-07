---
type: Operations
title: Portable OpenCode Development Operations
description: Personal-first workflow for understanding, changing, verifying and handing off the repository.
status: active
---

# Operations

## 1. Operating objective

Move from intent to a verified repository change with the least process that preserves safety, evidence and continuity.

```text
orient
→ define outcome
→ inspect evidence
→ plan
→ change
→ verify
→ synchronize
→ close
```

For non-trivial Codex work, `DESIGN-012` refines that into a master-mediated delegation lifecycle rather than replacing the repository workflow.

## 2. Current operating mode

The repository is in definition and **technical-validation readiness**, with the operational contract surface complete enough to delegate bounded technical spikes after validating the Codex development factory.

Binding facts:

- Windows native, PowerShell and Windows Terminal;
- root `opencode.jsonc` plus `.opencode/` assets;
- native OpenCode agents plus non-mutating `review`/`verify`;
- `main`, `reason`, `fast` semantic roles;
- Graphify minimal output allowlist;
- minimal context metadata schema;
- declarative three-preset reconciliation;
- explicit managed-resource materialization and proven-ownership mutation;
- canonical environment/project resource catalogs and state/result schemas;
- exact headless CLI operation contracts;
- proposed native Phoenix lifecycle with private SQLite and 30-day retention;
- repository-local Codex specialists plus one `development-orchestrator` master;
- Work Package and Task Receipt schemas for bounded Codex delegation;
- `SPIKE-000` defined to validate actual Codex role routing before relying on the hierarchy;
- four product runtime spike briefs with evidence and discard boundaries;
- the TUI is deferred;
- all owner-level defaults are resolved;
- `DEC-009`, `DEC-010` and `DEC-012` remain evidence-gated;
- metadata migration is pending, so `docs-only` has not passed.

## 3. Starting a session

Read the smallest authoritative set:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. task-specific source documents;
5. accepted, proposed and superseded relevant decisions.

For Codex-orchestrated work also read `DESIGN-012`. For spike execution read the owning spike brief and the relevant evidence-mapping design before touching the environment.

Identify observable outcome, owning source, required evidence and Windows constraints.

## 4. Evidence discipline

```text
current repository context
→ accepted decisions
→ current primary upstream documentation
→ bounded Windows-native experiment
→ implementation fixtures and tests
```

Do not infer unsupported surfaces, duplicate native capabilities, commit every generated artefact or add metadata without a consumer.

A `pending` component version, path, Codex routing guarantee or remote representation is an evidence gap. It is never permission for an agent to select a convenient value silently.

## 5. Standard workflow

### Orient
Read state and relevant sources.

### Define outcome
Describe an observable result rather than an activity.

### Inspect evidence
Use official documentation and reproducible PowerShell experiments. For a reported defect, first reproduce it through the closest feasible end-user or end-to-end path; otherwise record why reproduction is unavailable and what evidence substitutes for it.

### Plan
Identify files, decisions, risks, validation and rollback/discard boundary.

For non-trivial Codex delegation, the plan is converted into one or more bounded Work Packages under `DESIGN-012`.

### Change
Make the smallest coherent change. Avoid profiles, unsupported paths, duplicate agents, unused abstractions, hidden platform expansion, unnecessary generated output and false implementation claims. Never hand-edit generated artefacts: change their canonical source, generator or inputs and regenerate them. Preserve unrelated findings for a separate change unless they block the current outcome.

### Verify
Match checks to risk:

- docs: metadata schema, reserved files, links and state consistency;
- config: schema, discovery, precedence, provenance, materialization, ownership and drift;
- agents: modes, permissions, invocation and parent/child identity where relevant;
- presets: normalized diff, versioning, tools, privacy and fallback;
- observability: protocol, redaction, PIDs, ports, retention, storage, context pressure and compaction correlation where available;
- Graphify: scope, allowlist, determinism and manifest portability;
- Windows: paths, quoting, exit codes, processes and locked files;
- security: denied actions, redaction and backups.

For delegated implementation, deterministic verification precedes independent review. The implementation worker's self-assessment is not the final acceptance signal.

### Synchronize
Update only sources whose meaning changed.

### Close
Leave verified state, explicit gaps and one discoverable next action.

## 6. Metadata migration

The accepted schema applies immediately to new and substantially edited documents.

Repository-wide migration:

1. remove `created`, `modified` and generic `verified`;
2. remove frontmatter from `index.md` and `log.md`;
3. convert only material `sources` to `{resource, title}` objects;
4. delete non-material source lists;
5. preserve IDs and status;
6. validate against `schemas/context-document.schema.json`;
7. repair links without rewriting bodies.

Use an isolated branch and do not mark `docs-only` successful until all checks pass.

## 7. Git and Codex

Use direct `main` for low-risk documentation/state synchronization. Use branches for spikes, executable work, migrations and risky changes. PRs are useful when review, CI or Codex work benefits from an explicit merge boundary.

### Codex hierarchy

For non-trivial Codex development, use:

```text
user
→ development-orchestrator
  → bounded specialists
  → verification
  → fresh review
  → parent acceptance
```

`development-orchestrator` is the only master role. Specialists report to it directly; they do not recursively spawn or command other specialists. Configured delegation depth remains `1`.

`context-manager` and `prompt-engineer` are advisory to the master. They help recover context and shape difficult execution briefs, but they do not own implementation or create a hidden command chain.

### Work Packages

Delegated implementation must be bounded by the intent of:

```text
schemas/codex-work-package.schema.json
```

A package identifies outcome, authoritative sources, assigned agent, include/exclude scope, invariants, required verification, stop conditions and deliverables.

### Task Receipts

Workers return observable evidence matching the intent of:

```text
schemas/codex-task-receipt.schema.json
```

Receipts report real changed files/checks/outcomes, assumptions, deviations, blockers and residual risks. They do not replace independent verification.

### Fresh review

Meaningful code, safety-sensitive lifecycle/configuration work and ambiguous deterministic results require a fresh `code-reviewer`. The reviewer receives the original task/Work Package, diff and verification evidence rather than relying on the implementation worker's private reasoning.

### Orchestration limitation policy

If Codex cannot demonstrably invoke the intended named role, do not silently substitute another role and claim success. `SPIKE-000` classifies which guarantees are structural, semantic/prompt-enforced or unavailable in the installed build.

Do not build a custom dispatcher/hook workaround unless a later explicit design accepts that work.

## 8. Spike workflow

Each spike records question, relevance, hypotheses, tested versions, reproducible procedure, evidence, limitations, decision impact, recommendation and discard boundary.

Canonical briefs:

- `docs/spikes/SPIKE-000_CODEX_ORCHESTRATION.md` — development-process preflight;
- `docs/spikes/SPIKE-001_OPENCODE_LIFECYCLE.md`;
- `docs/spikes/SPIKE-002_OPENROUTER_POLICY.md`;
- `docs/spikes/SPIKE-003_OBSERVABILITY.md`;
- `docs/spikes/SPIKE-004_GRAPHIFY_RTK.md`.

Recommended execution order:

```text
SPIKE-000
→ metadata migration + green CI
→ SPIKE-001
→ SPIKE-002
→ SPIKE-004
→ SPIKE-003
```

`SPIKE-000` validates the development hierarchy, not product runtime behavior. If it is only partially supported, record exactly which guarantees are structural versus prompt-enforced before proceeding.

SPIKE-002 and SPIKE-004 may run in parallel after SPIKE-001 if their branches and global-configuration mutations remain isolated.

Each result is written under `docs/spikes/results/` with safe reusable fixtures only when they improve later testing.

A spike validates mechanism; it does not silently redesign policy.

## 9. Verification profiles

### Active: `docs-only`

Pending metadata migration, link checks, schema validation, decision/state consistency and secret scan.

Canonical command:

```text
scripts/verify-docs.ps1
```

`.github/workflows/ci.yml` is only a thin Windows adapter over the same validator.

### Future: `repo`

Formatting, linting, type checking, unit/integration tests, schema validation and build.

### Future: `canonical-journey`

```text
clean Windows
→ inspect and plan
→ install
→ healthy environment
→ scaffold and initialize
→ ready project
→ rerun without corruption
→ later session recovers state
```

`DESIGN-010` maps the product evidence contracts that must pass before this E2E can be trusted.

## 10. Failure, recovery and secrets

Stop broad mutation, preserve original errors, detect partial changes, restore known backups, mark state honestly, provide narrow remediation and avoid blind retries.

Never version credentials, real `.env`, SSH keys, private overrides, observability databases, raw traces, Graphify cost/query logs, caches or unsanitized failure output.

Normal recovery remains `inspect → plan → apply → doctor`. PowerShell does not become a parallel recovery engine.

## 11. Current next sequence

1. execute `SPIKE-000` on the actual Windows Codex environment and record PASS / INCONCLUSIVE / FAIL;
2. if orchestration is usable, use the validated master/specialist workflow to complete the controlled metadata migration;
3. make `scripts/verify-docs.ps1` and repository CI green without redesigning `DESIGN-004`;
4. execute `SPIKE-001` and apply only evidence-backed contract corrections;
5. execute SPIKE-002 and SPIKE-004, then SPIKE-003;
6. resolve `DEC-009`, `DEC-010` and `DEC-012` from evidence;
7. synchronize specification v0.3 and complete formal Phase 0 closure/active matrix approval;
8. implement the CLI against the accepted post-spike contracts and run `E2E-001`.
