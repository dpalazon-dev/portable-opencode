---
type: Conventions
title: Portable OpenCode Repository Conventions
description: Current documentation, code, configuration and collaboration conventions.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - ARCHITECTURE.md
  - ../../AGENTS.md
verified:
  - by: repository-owner
    status: pending
---

# Conventions

## General principles

- Prefer explicit structure over implicit agent memory.
- Prefer native OpenCode and OpenRouter features over custom duplication.
- Separate product intent, architecture, operations and implementation detail.
- Make defaults strong, documented and replaceable.
- Treat safety, observability and verification as architecture, not polish.
- Do not claim implementation or support that has not been validated.

## Repository language

- Machine-facing identifiers, code, schemas and CLI names use English.
- The current canonical product specification and context documents may remain in Spanish while the project is owner-led.
- Public-facing English documentation may be added later without deleting the Spanish source until both are maintained deliberately.
- Avoid mixing languages inside identifiers or a single technical concept.

## Naming

- Product and CLI name: `portable-opencode` until explicitly renamed.
- Context documents: uppercase semantic names under `docs/context/`.
- Commands: lowercase kebab-case, for example `/graph-update`.
- Custom tools: lowercase snake_case, for example `graph_status`.
- Plugins: lowercase kebab-case prefixed with `portable-`.
- Semantic model roles: lowercase stable nouns such as `main`, `build`, `explore`, `review`, `verify`.
- Decision identifiers: `DEC-NNN`.
- Spike identifiers: `SPIKE-NNN`.

## Documentation

- Use Markdown with YAML frontmatter for curated context.
- Include `type`, `title`, `description`, `status`, `created` and `modified`.
- Add `sources` when a document derives from other repository artefacts.
- Mark verification honestly; never invent an approval.
- Link to the canonical source instead of copying long sections.
- Current state belongs in `PROJECT.md`; desired state in `VISION.md`.
- Durable rationale belongs in `DECISIONS.md`.
- Chronological progress belongs in `log.md`, not in architecture documents.
- Large research notes should not become canonical context until distilled.

## Decision discipline

A decision is accepted only when it has:

- an identifier;
- status;
- date;
- context;
- decision;
- rationale;
- consequences.

Use these statuses:

- `accepted`;
- `proposed`;
- `superseded`;
- `rejected`;
- `deferred`.

Unresolved questions are not accepted decisions.

## Configuration

- Prefer JSONC, YAML or TOML only when the consumer supports them natively and comments or structure add value.
- Define schemas for generated or user-edited configuration.
- Separate versioned defaults from local overrides.
- Never interpolate secrets into generated files that may be committed.
- Every generated file should have a clear source template or generator.
- Generated changes should be deterministic for identical inputs.

## Code defaults

Until superseded by a decision:

- TypeScript is preferred for OpenCode plugins, custom tools and orchestration that benefits from its ecosystem.
- Shell scripts should be small wrappers, not the primary domain layer.
- External systems should be accessed through adapters.
- Pure configuration-generation logic should be separated from filesystem mutation.
- Functions that change state should support dry-run or return an explicit change plan where practical.
- Public APIs and state transitions require tests.
- Errors must include cause, affected component and remediation.

These defaults do not yet select the final CLI framework or package manager.

## Security

- Deny access to real secrets by default.
- Prefer allowlists for executable commands when feasible.
- Destructive operations must be narrow and approved.
- Logging must default to metadata-only.
- Redact sensitive values before persistence.
- Bind local UIs to loopback by default.
- Never store API keys in repository templates or examples.

## Testing

The intended test layers are:

1. schema and fixture validation;
2. unit tests for composition and policy logic;
3. integration tests for filesystem and CLI state transitions;
4. contract tests for OpenCode/OpenRouter adapters;
5. smoke tests on supported platforms;
6. end-to-end bootstrap tests in disposable environments.

A feature is not complete when only its happy path works locally.

## Commits and pull requests

- Keep commits conceptually coherent.
- Explain architectural changes in the relevant decision record.
- Do not mix generated noise with hand-authored changes when avoidable.
- PR descriptions should state what changed, why, validation and remaining risk.
- Prefer draft PRs for incomplete architectural work.

## Dependency policy

- Add dependencies for clear capability, not convenience alone.
- Prefer maintained, inspectable libraries with stable APIs.
- Avoid hard dependencies on enterprise-only services.
- Wrap rapidly changing external APIs behind repository-owned interfaces.
- Record a decision for foundational dependencies.

## Generated and local files

Generated artefacts, caches, Graphify output, trace databases and private local state must remain ignored unless a specific artefact is intentionally committed as a fixture.
