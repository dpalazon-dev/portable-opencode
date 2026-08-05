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

## 2. Current operating mode

The repository is in definition and configuration design.

Binding facts:

- Windows native, PowerShell and Windows Terminal through `DEC-015`;
- root `opencode.jsonc` plus `.opencode/` assets through `DEC-017`;
- `DEC-016` is superseded;
- native agents plus `review`/`verify`, with `main`/`reason`/`fast`, through `DEC-018`;
- Graphify minimal output allowlist through `DEC-019`;
- minimal context metadata through `DEC-011` and `DESIGN-004`;
- the TUI is deferred;
- the matrix contains 81 contracts and three remaining resolution items;
- metadata migration is pending, so `docs-only` has not passed;
- SPIKE-001 through SPIKE-004 follow design closure.

## 3. Starting a session

Read the smallest authoritative set:

1. `AGENTS.md`;
2. `.portable-opencode/state.json`;
3. `docs/context/index.md`;
4. task-specific source documents;
5. accepted and superseded relevant decisions.

Identify observable outcome, affected workflow, task class, source of truth, evidence and Windows constraints.

## 4. Evidence discipline

```text
current repository context
→ accepted decisions
→ current primary upstream documentation
→ bounded Windows-native experiment
→ implementation fixtures and tests
```

Do not infer configuration surfaces from naming symmetry, duplicate native agents without a gap, version every generated output or add metadata without a consumer.

## 5. Standard workflow

### Orient

Read state and relevant sources.

### Define outcome

Describe an observable result rather than an activity.

### Inspect evidence

Verify official documentation for external behaviour. Use reproducible PowerShell experiments for runtime uncertainty.

### Plan

Identify affected files, decisions, risks, validation and rollback/discard boundary.

### Change

Make the smallest coherent change. Avoid profiles, unsupported paths, duplicate agents, unused abstractions, hidden platform expansion, unnecessary generated artefacts, decorative metadata and false implementation claims.

### Verify

Match checks to risk:

- docs: reserved-file structure, frontmatter schema, links and state consistency;
- config: schema, discovery, precedence and provenance;
- agents: modes, permissions, invocation and output contracts;
- presets: identity, compatibility, privacy and fallback;
- Graphify: source scope, allowlist, determinism and manifest portability;
- Windows: paths, quoting, exit codes, processes, ports and locked files;
- security: denied actions, redaction and backups.

### Synchronize

Update only sources whose meaning changed.

### Close

Leave verified state, explicit gaps and one discoverable next action.

## 6. Metadata migration

The accepted schema applies immediately to new and substantially edited documents.

The repository-wide migration is a bounded docs task:

1. remove `created`, `modified` and generic `verified`;
2. remove frontmatter from `index.md` and `log.md`;
3. convert only material `sources` to `{resource, title}` objects;
4. delete non-material source lists;
5. preserve stable IDs and status;
6. validate parsed frontmatter with `schemas/context-document.schema.json`;
7. resolve links without rewriting document bodies.

Do not mark `docs-only` successful until this migration is complete.

## 7. Git model

Use direct `main` for low-risk documentation/state synchronization. Use branches for spikes, executable work, migrations and risky changes. Use PRs when review, CI or Codex work benefits from an explicit merge boundary.

The metadata migration should use an isolated branch because it touches many canonical files and needs an all-or-nothing validation boundary.

## 8. Graphify output

Commit `graph.json`, `GRAPH_REPORT.md` and validated portable `manifest.json`. Ignore HTML, cache, cost, query logs and optional exports. Synchronize at meaningful structural boundaries and keep `graphify-out/` outside source extraction.

## 9. Spike workflow

Each spike documents question, relevance, hypotheses, tested Windows/PowerShell/dependency versions, reproducible procedure, evidence, limitations, decision impact, recommendation and discard boundary.

A spike validates mechanism; it does not silently redesign policy.

## 10. Working with Codex

Delegate only bounded tasks specifying outcome, sources, binding/superseded decisions, scope, forbidden operations, Windows evidence, spike/production status, state updates and branch/PR boundary.

SPIKE-001 becomes suitable after remaining product defaults and CLI/file-tree contracts close. The metadata migration is also suitable for Codex once the validator command is defined.

## 11. Verification profiles

### Active: `docs-only`

Pending until:

- reserved files have no frontmatter;
- non-reserved frontmatter validates;
- links resolve;
- decisions, research, matrix, roadmap and state agree;
- superseded decisions are not active;
- no unsupported implementation is claimed;
- no secrets/private traces are committed.

### Future: `repo`

Formatting, linting, type checking, unit/integration tests, schema validation and build.

### Future: `canonical-journey`

```text
clean Windows
→ inspect and plan
→ install
→ healthy environment
→ scaffold and initialize
→ ready project with valid context and graph
→ rerun without corruption
→ later session recovers state
```

## 12. Failure, recovery and secrets

Stop broad mutation, preserve the original error, detect partial changes, restore known backups, mark state honestly, provide narrow remediation and avoid blind retries.

Never version credentials, real `.env`, SSH keys, certificates, private overrides, observability databases, raw traces, Graphify cost/query logs, caches or unsanitized failure output.

## 13. Current next sequence

1. decide Phoenix lifecycle and retention;
2. decide first-CLI OpenRouter preset reconciliation;
3. leave language and packaging to bounded spike evidence;
4. define canonical file trees and CLI contracts;
5. execute metadata migration and validation;
6. approve the matrix and prepare SPIKE-001 for Codex.
