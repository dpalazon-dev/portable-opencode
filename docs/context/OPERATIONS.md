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
- native agents plus `review` and `verify`, with `main`, `reason`, `fast`, through `DEC-018`;
- Graphify minimal output allowlist through `DEC-019`;
- the TUI is deferred;
- the matrix contains 81 contracts and four remaining resolution items;
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

Do not infer configuration surfaces from naming symmetry, duplicate built-in agents without a demonstrated gap, or version generated output merely because upstream creates it.

A documented surface may still require a spike for Windows integration. A spike validates mechanism; it does not silently redesign product policy.

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

Make the smallest coherent change. Do not add profiles, unsupported config paths, duplicate native agents, unused abstractions, hidden platform expansion, unnecessary generated artefacts or false implementation claims.

### Verify

Match checks to risk:

- docs: links, frontmatter, state and decision consistency;
- config: schema, discovery, precedence and provenance;
- agents: modes, permissions, task invocation and output contracts;
- presets: identity, tool compatibility, privacy and fallback;
- Graphify: source scope, output allowlist, deterministic graph/report, manifest portability and private-path absence;
- Windows: paths, quoting, exit codes, processes, ports and locked files;
- security: denied actions, redaction and backup boundaries.

### Synchronize

Update only sources whose meaning changed: project, architecture, decisions, roadmap, design/research, state and concise log as applicable.

### Close

Leave verified state, explicit gaps and one discoverable next action.

## 6. Git model

Use direct `main` for low-risk documentation and state synchronization. Use branches for spikes, executable work, dependency experiments, migrations and risky changes. Use PRs when review, CI or an explicit Codex merge boundary adds value.

## 7. Generated Graphify output

Graphify output follows `DESIGN-003`:

- commit `graph.json`, `GRAPH_REPORT.md` and validated portable `manifest.json`;
- ignore HTML, cache, cost, query logs and optional exports;
- do not commit after every edit;
- synchronize at meaningful structural boundaries;
- mark state `dirty` when source structure changes;
- block readiness for missing/corrupt graph; degrade for rebuildable manifest absence;
- never let `graphify-out/` feed back into source extraction.

## 8. Spike workflow

Each spike documents question, relevance, hypotheses, tested Windows/PowerShell/dependency versions, reproducible procedure, evidence, limitations, decision impact, recommendation and discard boundary.

A spike removes uncertainty; it does not need production quality or silently create production architecture.

## 9. Working with Codex

Delegate only bounded tasks specifying outcome, sources, binding/superseded decisions, scope, forbidden operations, required Windows evidence, spike/production status, state updates and branch/PR boundary.

SPIKE-001 becomes suitable after the remaining owner defaults and CLI/file-tree contracts are closed.

## 10. Verification profiles

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
→ ready project with valid graph allowlist
→ rerun without corruption
→ later session recovers state
```

## 11. Failure and recovery

Stop broad mutation, preserve the original error, detect partial changes, restore known backups, mark state honestly, provide narrow remediation and avoid blind retries.

## 12. Secrets and private state

Never version API keys, real `.env` values, SSH keys, certificates, private overrides, observability databases, raw traces, Graphify cost/query logs, caches or unsanitized failure output.

## 13. Current next sequence

1. define minimal context metadata;
2. decide Phoenix lifecycle and retention;
3. decide first-CLI OpenRouter preset reconciliation;
4. leave language and packaging to bounded spike evidence;
5. define canonical file trees and CLI contracts;
6. approve the matrix and prepare SPIKE-001 for Codex.
