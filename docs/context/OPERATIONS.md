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

## 2. Current operating mode

The repository is in definition and configuration design.

Binding facts:

- Windows native, PowerShell and Windows Terminal through `DEC-015`;
- root `opencode.jsonc` plus `.opencode/` native assets through `DEC-017`;
- `DEC-016` is superseded;
- native OpenCode agents plus custom `review` and `verify` through `DEC-018`;
- semantic roles are `main`, `reason` and `fast`;
- the TUI is deferred;
- the matrix contains 81 contracts and five remaining resolution items;
- the active verification profile is `docs-only`;
- SPIKE-001 through SPIKE-004 are the technical validation layer after design closure.

## 3. Starting a session

Read the smallest authoritative set:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. task-specific source documents;
5. accepted and superseded relevant decisions.

Identify the observable outcome, affected workflow, task class, source of truth, evidence and Windows constraints.

## 4. Evidence discipline

```text
current repository context
→ accepted decisions
→ current primary upstream documentation
→ bounded Windows-native experiment
→ implementation fixtures and tests
```

Do not infer configuration surfaces from naming symmetry. Do not duplicate built-in agents without a demonstrated gap. A documented surface may still require a spike for Windows integration.

## 5. Standard workflow

### Orient

Read current state and relevant sources.

### Define outcome

Describe an observable result rather than an activity.

### Inspect evidence

Verify current official documentation for external behaviour. Use reproducible PowerShell experiments for runtime uncertainty.

### Plan

Identify affected files, decisions, risks, validation and rollback/discard boundary.

### Change

Make the smallest coherent change. Do not add profiles, unsupported config paths, duplicate native agents, unused abstractions, hidden platform expansion or false implementation claims.

### Verify

Match checks to risk:

- docs: links, frontmatter, state and decision consistency;
- config: schema, discovery, precedence and provenance;
- agents: modes, permissions, task invocation and output contracts;
- presets: identity, tool compatibility, privacy and fallback;
- Windows: paths, quoting, exit codes, processes, ports and locked files;
- security: denied actions, redaction and backup boundaries.

### Synchronize

Update only sources whose meaning changed: project, architecture, decisions, roadmap, design/research, state and concise log as applicable.

### Close

Leave verified state, explicit gaps and one discoverable next action.

## 6. Git model

Use direct `main` for low-risk documentation and state synchronization. Use branches for spikes, executable work, dependency experiments, migrations and risky changes. Use PRs when review, CI or an explicit Codex merge boundary adds value.

## 7. Spike workflow

Each spike documents question, relevance, hypotheses, tested Windows/PowerShell/dependency versions, reproducible procedure, evidence, limitations, decision impact, recommendation and discard boundary.

A spike removes uncertainty; it does not silently create production architecture.

## 8. Working with Codex

Delegate only bounded tasks specifying outcome, sources, binding/superseded decisions, scope, forbidden operations, required Windows evidence, spike/production status, state updates and branch/PR boundary.

SPIKE-001 becomes suitable after the remaining owner defaults and CLI/file-tree contracts are closed.

## 9. Verification profiles

### Active: `docs-only`

- canonical files and links exist;
- JSON and frontmatter parse;
- decisions, research, matrix, roadmap and state agree;
- superseded decisions are not active;
- no unsupported implementation is claimed;
- no secrets or private traces are committed.

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

## 10. Failure and recovery

Stop broad mutation, preserve the original error, detect partial changes, restore known backups, mark state honestly, provide narrow remediation and avoid blind retries.

## 11. Secrets and private state

Never version API keys, real `.env` values, SSH keys, certificates, private overrides, observability databases, raw traces, caches or unsanitized failure output.

## 12. Current next sequence

1. decide Graphify output ownership;
2. define minimal context metadata;
3. decide Phoenix lifecycle and retention;
4. decide first-CLI OpenRouter preset reconciliation;
5. leave language and packaging to bounded spike evidence;
6. define canonical file trees and CLI contracts;
7. approve the matrix and prepare SPIKE-001 for Codex.
