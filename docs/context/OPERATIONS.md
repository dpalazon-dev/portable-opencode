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
  - ROADMAP.md
verified:
  - by: repository-owner
    status: pending
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

The workflow is personal-first. It does not assume a team, release train or permanent pull-request ceremony.

## 2. Current operating mode

The repository is in definition and configuration design.

Current facts:

- no executable product, runtime choice or package manager has been accepted;
- Windows native, PowerShell and Windows Terminal are binding through `DEC-015`;
- root `opencode.jsonc` plus `.opencode/` assets are binding through `DEC-017`;
- `DEC-016` is superseded and must not guide implementation;
- the TUI is deferred;
- upstream configuration research is complete and corrected;
- the roadmap is aligned pending owner review;
- the matrix contains 81 contracts and six unresolved personal defaults;
- the active verification profile is `docs-only`;
- SPIKE-001 through SPIKE-004 are the next technical validation layer after design closure.

## 3. Starting a session

Read the smallest authoritative set:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. task-specific source-of-truth documents;
5. accepted and superseded decisions relevant to the task.

Before changing anything, identify:

- observable outcome;
- affected canonical workflow;
- task class: documentation, design, spike, implementation or maintenance;
- owning source of truth;
- verification evidence;
- Windows-native constraints when executable behaviour is involved.

## 4. Evidence discipline

Use evidence in this order where relevant:

```text
current repository context
→ accepted decisions
→ current primary upstream documentation
→ bounded Windows-native experiment
→ implementation fixtures and tests
```

Do not infer an upstream configuration surface from naming symmetry. The correction from `DEC-016` to `DEC-017` is the canonical example: `.opencode/` is an asset directory, not evidence that `.opencode/opencode.jsonc` is a supported runtime config.

A documented upstream surface may still require a spike to prove Windows integration. A spike may not replace clear upstream documentation with a private convention unless the divergence is explicit and justified.

## 5. Standard change workflow

### Orient

Read current state, binding decisions and the narrowest affected documents.

### Define outcome

Describe an observable result, not an activity. Example:

> The scaffold generates root `opencode.jsonc`, discovers `.opencode/` assets and reports active override provenance.

### Inspect evidence

For external behaviour, verify current official documentation. For runtime uncertainty, design a reproducible PowerShell experiment.

### Plan

Identify affected files, decisions, risky boundaries, validation and rollback/discard boundary.

### Change

Make the smallest coherent change. Do not:

- introduce profiles for one configuration;
- abstract unused alternatives;
- add unsupported config paths;
- mix spike code with production architecture;
- broaden platform support;
- describe planned behaviour as implemented.

### Verify

Match checks to risk:

- docs: links, frontmatter, decision/state consistency and unsupported claims;
- config: schema, discovery, precedence and provenance;
- planner: determinism and no mutation;
- installer: first run, rerun, backup and drift;
- Windows adapter: paths, quoting, exit codes, processes, ports and locked files;
- security: permissions, secret redaction and destructive boundaries.

### Synchronize

Update only sources whose meaning changed:

| Meaning changed | Source |
|---|---|
| current scope/state | `PROJECT.md` |
| desired outcome | `VISION.md` |
| boundaries/lifecycle | `ARCHITECTURE.md` |
| repeated rule | `CONVENTIONS.md` |
| workflow | `OPERATIONS.md` |
| durable choice | `DECISIONS.md` |
| delivery order | `ROADMAP.md` |
| configuration contract | `docs/design/` |
| evidence | `docs/research/` or `docs/spikes/` |
| machine state | `.portable-opencode/state.json` |
| meaningful transition | `log.md` |

### Close

Leave verified repository state, explicit gaps and one discoverable next action.

## 6. Git model

### Direct `main`

Use for low-risk documentation, state synchronization and small reversible maintenance.

### Branch

Use for spikes, executable work, dependency experiments, migrations and risky multi-file changes.

```text
spike/001-opencode-lifecycle
feat/configuration-core
fix/state-recovery
```

### Pull request

Use when deliberate review, CI evidence or Codex-produced executable work benefits from an explicit merge boundary. It is not mandatory for every edit.

## 7. Spike workflow

Each spike gets:

```text
docs/spikes/SPIKE-NNN.md
experiments/spike-NNN-*/   # only when useful
```

Required content:

- question and architectural relevance;
- hypotheses;
- tested Windows, PowerShell and dependency versions;
- reproducible procedure;
- observed evidence;
- limitations;
- decision and matrix impact;
- recommendation;
- retained and discarded artefacts.

A spike removes uncertainty. It does not need production quality and must not silently create production abstractions.

## 8. Working with Codex

Delegate only bounded tasks specifying:

- exact result;
- repository sources to read;
- accepted and superseded decisions;
- files/directories in scope;
- forbidden operations;
- required Windows-native evidence;
- spike versus production status;
- documentation/state updates;
- branch and PR boundary.

The first suitable Codex task remains `SPIKE-001`, after the remaining design defaults and CLI/file-tree contracts are sufficiently explicit.

## 9. Verification profiles

### `docs-only` — active

- canonical files exist;
- links resolve;
- JSON parses;
- required frontmatter exists;
- decisions, research, matrix, roadmap and state agree;
- superseded decisions are not presented as active;
- no implementation is falsely claimed;
- no secrets or private traces are committed.

### `repo` — future

Formatting, linting, type checking, unit/integration tests, schema validation and build after executable code exists.

### `canonical-journey` — future

```text
clean Windows
→ inspect
→ plan
→ install
→ healthy environment
→ scaffold project
→ semantic initialization
→ ready project
→ rerun without corruption
→ later session recovers state
```

## 10. Failure and recovery

On failure:

1. stop broad mutation;
2. preserve the original error and operation;
3. detect partial changes;
4. restore known backups when available;
5. mark state honestly;
6. provide narrow remediation;
7. avoid blind retries.

Repair converges toward versioned desired state rather than undocumented manual state.

## 11. Secrets and private state

Never version API keys, real `.env` values, SSH keys, certificates, private overrides, observability databases, raw traces, caches or unsanitized failure output.

## 12. Current next sequence

1. define initial OpenCode agents and OpenRouter semantic roles together;
2. decide Graphify output ownership;
3. define minimal context metadata;
4. decide Phoenix lifecycle and retention;
5. decide first-CLI OpenRouter preset reconciliation;
6. delegate implementation language and packaging to spike evidence;
7. define canonical file trees and CLI contracts;
8. approve the matrix and prepare SPIKE-001 for Codex.
