---
type: Operations
title: Portable OpenCode Development Operations
description: Personal-first workflow for understanding, changing, verifying and handing off the repository.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../../AGENTS.md
  - PROJECT.md
  - ARCHITECTURE.md
  - CONVENTIONS.md
  - DECISIONS.md
verified:
  - by: repository-owner
    status: pending
---

# Operations

## 1. Operating objective

Repository operations should help the owner move from intent to a verified change with the least process necessary to preserve safety, clarity and continuity.

The workflow is personal-first. It does not assume a team, release train, support organization or permanent pull-request process.

The governing sequence is:

```text
orient
→ define outcome
→ inspect evidence
→ plan
→ change
→ verify
→ synchronize state
→ close with a discoverable next action
```

## 2. Current operating mode

The repository remains in definition and architectural design.

Current facts:

- no executable product exists;
- no runtime or package manager has been accepted;
- the active verification profile is `docs-only`;
- `PROJECT.md`, `VISION.md` and `ARCHITECTURE.md` are aligned with `DEC-014`;
- `CONVENTIONS.md` and this document are now under personal-first alignment;
- `FEAT-001`, `ROADMAP.md` and `DESIGN-001` still require personal-first review;
- technical spikes must not begin until the reduced MVP design provides bounded questions.

## 3. Starting a session

Read only the smallest authoritative set required by the task.

Minimum orientation:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. the specific source-of-truth documents affected by the task;
5. accepted decisions and relevant proposals in `DECISIONS.md`.

Do not reread the full repository by ritual. Expand the source set only when the task crosses additional boundaries or exposes a contradiction.

Before changing anything, identify:

- the concrete outcome;
- the canonical personal workflow affected;
- whether the task is documentation, design, spike, implementation or maintenance;
- which source of truth owns the result;
- what evidence will count as verification.

## 4. Task classes

### Documentation and scope work

Use when clarifying product intent, architecture, conventions, operations, features, roadmap or design.

Rules:

- change the narrowest canonical documents;
- preserve distinctions between fact, decision, proposal and hypothesis;
- update state and log only when the project state or next action changes materially;
- do not create implementation claims.

### Technical spike

Use when an upstream capability or architectural mechanism is materially uncertain.

A spike is bounded research, not production implementation. It must answer named questions with reproducible evidence and may be discarded afterward.

### Implementation

Use only after the relevant behaviour and acceptance boundary are clear enough that the agent is not forced to invent the product.

Implementation must follow the canonical personal path first. Generalization is not part of the task unless explicitly approved.

### Maintenance and repair

Use for dependency updates, schema migrations, configuration drift, security issues or broken generated state.

Prefer restoration of the known desired state over manual one-off repair.

## 5. Standard change workflow

### Step 1 — Orient

Read current state and the relevant context. Identify accepted constraints and unresolved decisions.

### Step 2 — Define the outcome

State the change as an observable result, for example:

- “The architecture describes one canonical personal configuration.”
- “SPIKE-001 determines actual OpenCode configuration precedence.”
- “The installer produces the same plan on a second run.”

Avoid activity-based goals such as “work on the CLI”.

### Step 3 — Inspect evidence

Use the cheapest reliable evidence source:

```text
curated context
→ accepted decisions
→ Graphify when code exists
→ LSP
→ textual search
→ direct file reading
→ current primary upstream documentation
→ controlled experiment
```

External behaviour that can change must be verified against current primary documentation before implementation.

### Step 4 — Plan

For non-trivial work, identify:

- affected files and contracts;
- intended changes;
- decisions applied or challenged;
- risky or destructive boundaries;
- verification method;
- rollback or discard boundary.

The plan should be proportional. A small documentation correction does not need an artificial project plan.

### Step 5 — Change

Make the smallest coherent change that delivers the outcome.

Do not:

- add placeholders without a current contract;
- introduce a profile system for one configuration;
- abstract around alternatives that are not used;
- mix a spike with production architecture silently;
- broaden platform support as a side effect;
- preserve obsolete text solely to avoid editing several documents.

### Step 6 — Verify

Run the active verification profile and any task-specific checks.

Verification must answer the actual risk of the change. Examples:

- documentation change: links, frontmatter, state consistency and unsupported claims;
- schema change: parsing, fixtures and migration behaviour;
- planner change: deterministic output and no unintended mutation;
- installer change: first-run and repeated-run behaviour;
- adapter change: contract fixture and real-environment spike where required;
- safety change: denied paths, redaction and destructive-command boundaries.

Report skipped checks explicitly.

### Step 7 — Synchronize

Update only the sources whose meaning changed.

| Change | Usually update |
|---|---|
| Current scope or factual state | `PROJECT.md` |
| Desired product outcome | `VISION.md` |
| Component responsibility or lifecycle | `ARCHITECTURE.md` |
| Repeated working rule | `CONVENTIONS.md` |
| Development workflow | `OPERATIONS.md` |
| Durable choice | `DECISIONS.md` |
| Feature contract | `docs/features/` |
| Configuration design | `docs/design/` |
| Delivery order | `ROADMAP.md` |
| Machine-readable state or next action | `.portable-opencode/state.json` |
| Meaningful transition | `log.md` |

Do not update every document automatically. Synchronization means consistency, not widespread churn.

### Step 8 — Close

A completed change leaves:

- the outcome in the repository;
- verification evidence or an explicit gap;
- actual state synchronized;
- a next action when one materially exists;
- no dependency on hidden conversational context.

## 6. Git operating model

Use the lightest useful boundary.

### Direct commit to `main`

Appropriate for:

- low-risk documentation changes;
- state synchronization;
- small repository maintenance;
- corrections whose diff is easy to inspect and reverse.

### Branch

Use for:

- technical spikes;
- executable features;
- dependency or packaging experiments;
- migrations;
- risky multi-file changes;
- work delegated to Codex that benefits from isolation.

Suggested branch forms:

```text
spike/001-opencode-lifecycle
feat/configuration-core
fix/state-recovery
```

### Pull request

A PR is optional and useful when:

- a substantial diff needs deliberate review;
- a spike should preserve discussion and evidence;
- Codex has implemented a bounded task;
- CI results form part of acceptance;
- merging should remain an explicit decision.

Do not create issue, branch and PR ceremony for every documentation edit.

## 7. Spike workflow

Each spike should have one bounded document under `docs/spikes/` and, when useful, disposable code under `experiments/`.

Required spike content:

- identifier and status;
- question and why it matters;
- hypotheses;
- tested environment and versions;
- reproducible procedure;
- evidence and observed behaviour;
- limitations;
- impact on architecture and decisions;
- recommendation;
- artefacts worth retaining;
- explicit discard boundary for temporary code.

A spike completes when it changes uncertainty into evidence. It does not need production quality.

After review:

1. accept, revise, reject or defer the affected decision;
2. update architecture or design only where evidence warrants it;
3. retain minimal reproducible evidence;
4. delete disposable code that no longer serves a purpose;
5. update state and next action.

## 8. Working with Codex

Pass work to Codex only when the task is bounded enough to avoid silent product invention.

A Codex task should specify:

- exact outcome;
- repository sources to read;
- accepted constraints;
- files or directories in scope;
- operations that are forbidden;
- required evidence or tests;
- whether the result is a spike or production code;
- expected state and documentation updates;
- branch or PR boundary when used.

Bad task:

> Implement portable-opencode.

Good task:

> On `spike/001-opencode-lifecycle`, create a reproducible experiment that determines global versus project configuration precedence in the current OpenCode version. Do not create production abstractions. Record commands, fixtures, observed behaviour and implications in `docs/spikes/SPIKE-001.md`.

Review Codex output against the repository sources of truth, not against how convincing the implementation appears.

## 9. Verification profiles

### Current: `docs-only`

Required checks:

- canonical documents exist;
- internal links resolve;
- JSON parses;
- frontmatter contains required fields;
- accepted decisions and machine state agree;
- planned behaviour is not described as implemented;
- no secrets, private traces, databases or generated caches are committed.

### Future: `repo`

Activate only when executable repository code exists. It should include the canonical format, lint, type, unit, integration, schema and build commands selected by the implementation.

### Future: `canonical-journey`

Activate when installation and project initialization exist. It validates the real owner workflow:

```text
inspect environment
→ create plan
→ install safely
→ verify environment
→ scaffold new project
→ initialize project
→ verify ready state
→ rerun without corruption
```

### Additional platform checks

Add smoke tests only for environments the owner actually supports. Do not build a universal compatibility matrix in advance.

## 10. State management

Environment state and project state are separate.

State updates must be:

- derived from verification where possible;
- explicit about `healthy`, `degraded`, `blocked`, `dirty` or `update-required` conditions;
- independent from CLI or TUI navigation state;
- honest when evidence is missing;
- reconstructible from canonical configuration and inspection where practical.

Do not mark a project `ready` because files were generated. Readiness requires its defined verification gates.

## 11. Failure and recovery

When an operation fails:

1. stop before broadening the mutation scope;
2. preserve the original error and affected operation;
3. determine whether partial changes occurred;
4. restore from backup or execute the known rollback when available;
5. mark state honestly as `degraded` or `blocked`;
6. provide a narrow remediation action;
7. avoid repeated blind retries.

Repair should converge toward the versioned desired state. Avoid undocumented manual fixes that cannot be reproduced later.

## 12. Secrets and private state

Never version or expose:

- API keys and tokens;
- real `.env` values;
- SSH keys or certificates;
- raw private prompts and responses without explicit opt-in;
- observability databases;
- unrelated project source;
- unsanitized traces;
- private local overrides.

If a secret enters Git:

1. rotate or revoke it immediately;
2. stop propagation;
3. remove it from accessible history where appropriate;
4. inspect logs and traces for copies;
5. record the incident without reproducing the value;
6. add a preventive control.

## 13. Handoff and continuity

Because this is a personal project, handoff means continuity across sessions and agents, not management reporting.

Add a `log.md` entry only for a meaningful transition. Keep it to:

- outcome;
- resulting decision or state;
- verification status;
- next action.

Do not repeat full file lists, rationale or discussion already captured elsewhere.

The repository is ready for the next session when another agent can identify:

- what is true now;
- which decisions bind;
- what remains proposed;
- what was verified;
- the next bounded action.

## 14. Releases and broader support

No release process is active.

Do not design release trains, support windows, public compatibility guarantees or distribution channels until an executable personal version exists and the owner needs to install or update it outside the development checkout.

When that need appears, define the smallest release process that supports the actual distribution method and primary environment.

## 15. Current next sequence

After this conventions and operations alignment:

1. review `FEAT-001` against personal-first value;
2. review `ROADMAP.md` and remove productization phases or gates;
3. reduce `DESIGN-001` to the canonical personal MVP;
4. verify the complete context set;
5. create bounded technical spikes;
6. pass the first spike to Codex.