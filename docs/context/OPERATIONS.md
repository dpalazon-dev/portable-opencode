---
type: Operations
title: Portable OpenCode Development Operations
description: How the repository is explored, changed, verified and handed off.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - ../../AGENTS.md
  - CONVENTIONS.md
verified:
  - by: repository-owner
    status: pending
---

# Operations

## Current operating mode

The repository is documentation-first. There is no executable product, dependency installation or technical test suite yet.

The active verification profile is `docs-only`.

## Starting a work session

1. Read `AGENTS.md`.
2. Read `docs/context/index.md` and the documents relevant to the task.
3. Inspect `DECISIONS.md` for binding constraints and open questions.
4. Inspect `.portable-opencode/state.json`.
5. Confirm whether the task changes product intent, architecture, operations or implementation.
6. Avoid implementation until required uncertainties are resolved or explicitly accepted as spike scope.

## Change workflow

### 1. Explore

Gather evidence from the smallest authoritative source set. Once source code exists, the expected order becomes:

```text
context → Graphify → LSP → textual search → direct read
```

### 2. Plan

State:

- intended outcome;
- files and contracts affected;
- decisions being applied or introduced;
- validation method;
- risks and rollback boundary.

### 3. Implement or edit

Make the smallest coherent change. Do not add future-looking placeholders that have no executable contract or owner.

### 4. Synchronize context

Update the relevant combination of:

- `PROJECT.md` for current scope or state;
- `VISION.md` for desired future changes;
- `ARCHITECTURE.md` for boundaries and contracts;
- `CONVENTIONS.md` for repository rules;
- `DECISIONS.md` for durable choices;
- `ROADMAP.md` for ordering and milestone changes;
- `.portable-opencode/state.json` for machine state;
- `log.md` for meaningful progress.

### 5. Verify

Run the active verification profile and report any skipped checks explicitly.

### 6. Handoff

Leave a concise entry in `log.md` when work changes the project state, resolves a decision or creates a meaningful next step.

## Current verification profile: `docs-only`

Checks:

- required context files exist;
- internal Markdown links resolve;
- JSON files parse;
- frontmatter contains required fields;
- no file claims implementation that is absent;
- accepted decisions and project state are consistent;
- no secrets, trace databases or generated caches are committed.

A future repository command should automate these checks.

## Planned verification profiles

### `repo`

For the portable-opencode implementation itself:

- formatting;
- linting;
- type checking;
- unit and integration tests;
- package build;
- schema validation;
- security checks;
- platform smoke tests.

### `generated-project`

For a scaffolded fixture project:

- expected file tree;
- valid configuration;
- idempotent regeneration;
- correct private/versioned boundaries;
- Graphify initialization;
- OpenCode config loading;
- verification command execution.

### `end-to-end`

For disposable environments:

- install from clean machine image;
- authenticate or use mocked external services;
- initialize new project;
- run `/init-project` equivalent workflow;
- reach `ready` state;
- inspect traces and graph;
- rerun installer without damage.

## External documentation verification

OpenCode, OpenRouter, Graphify, Phoenix and other external capabilities can change. Before implementing against a capability:

1. verify it against current primary documentation;
2. record the tested version or date;
3. distinguish documented support from repository inference;
4. create a spike when behaviour is uncertain;
5. update the decision record after evidence exists.

## Releases

No release process is active yet.

The intended future release process should include:

- semantic versioning or an explicitly documented alternative;
- changelog generation;
- migration notes for configuration and state schemas;
- signed or verifiable release artefacts where practical;
- compatibility matrix for OpenCode, Graphify and supported platforms.

## Incident and security handling

Follow `SECURITY.md` for vulnerability reporting.

If a secret is committed:

1. revoke or rotate it immediately;
2. stop further propagation;
3. remove it from current history where appropriate;
4. assess logs and observability stores;
5. document the incident without reproducing the secret;
6. add a preventive control.

## Local development state

Do not version:

- `.env` values;
- credentials;
- observability databases;
- raw private traces;
- temporary Graphify output;
- local caches;
- editor-specific transient state.

## Repository handoff format

A handoff entry should contain:

- date;
- objective;
- completed work;
- decisions made;
- validation performed;
- unresolved risks;
- recommended next action.
