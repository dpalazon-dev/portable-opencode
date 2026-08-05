---
type: Conventions
title: Portable OpenCode Repository Conventions
description: Minimal conventions that keep the personal-first repository explicit, safe and maintainable.
status: active
---

# Conventions

## 1. Purpose

These conventions reduce mistakes, forgotten assumptions and maintenance cost in the repository owner's real workflow. They are not a contributor handbook, public SDK contract or attempt to standardize every possible project.

A convention belongs here only when it prevents a recurring error, protects safety, preserves reproducibility, clarifies ownership or gives agents a stable repeated rule.

## 2. Governing rules

- Personal-first, reusable by others.
- One canonical personal configuration before profiles.
- Explicit state before implicit memory.
- Native capability before custom code.
- Deterministic operation before conversational automation.
- Inspect before changing; plan before applying; verify after applying.
- Keep secrets and private operational data outside Git.
- Do not claim support or implementation without evidence.
- Prefer the smallest coherent abstraction that solves the current problem.

## 3. Source-of-truth discipline

| Concern | Source of truth |
|---|---|
| Current identity, scope and status | `PROJECT.md` |
| Desired personal outcome | `VISION.md` |
| Component boundaries and lifecycle | `ARCHITECTURE.md` |
| Repeated repository rules | `CONVENTIONS.md` |
| How work is performed | `OPERATIONS.md` |
| Durable decisions and rationale | `DECISIONS.md` |
| Delivery order | `ROADMAP.md` |
| Current external evidence | `docs/research/` |
| Implementable contracts | `docs/design/` |
| Feature-specific future behaviour | `docs/features/` |
| Machine-readable state | `.portable-opencode/state.json` |
| Concise transitions | `log.md` |

Do not duplicate large sections. Link to the owning source and record only the local implication. Resolve conflicts explicitly through the hierarchy in `AGENTS.md`.

## 4. Language and naming

- Code, schemas, identifiers, commands and machine-readable values use English.
- Do not maintain duplicate translations without a real maintenance purpose.
- Product and CLI: `portable-opencode` until renamed by decision.
- CLI and slash commands: lowercase kebab-case.
- Custom tools: lowercase snake_case.
- Decisions: `DEC-NNN`.
- Research: `RESEARCH-NNN`.
- Features: `FEAT-NNN`.
- Designs: `DESIGN-NNN`.
- Spikes: `SPIKE-NNN`.
- Semantic model roles: short stable nouns such as `main`, `reason` and `fast`.

Do not create identifiers for speculative components.

## 5. Documentation metadata

`DEC-011` and [DESIGN-004](../design/CONTEXT_METADATA_SCHEMA.md) define the repository-owned OKF-compatible subset.

Every curated Markdown document except reserved `index.md` and `log.md` requires:

```yaml
type: <document type>
title: <display title>
description: <one-line responsibility>
status: <lifecycle status>
```

Allowed document statuses:

```text
active
proposed
draft
deferred
superseded
deprecated
archived
```

Conditional fields:

- `id` for independently addressable research, design, feature and spike documents;
- `decision` when a design or feature has a governing decision;
- `sources` only for material provenance, using objects with a required `resource`;
- `resource`, `tags` and `generated` only when they change consumption or validation.

Do not use:

- `created` or `modified`; Git owns history;
- generic `verified`; decisions, spikes, tests and project state own verification;
- decorative tags;
- exhaustive related-document lists disguised as provenance.

`index.md` and `log.md` have no frontmatter. Parsed non-reserved frontmatter is validated against `schemas/context-document.schema.json`.

The current repository still contains inherited metadata. New or substantially edited documents follow the new schema immediately; the controlled migration must remove the remaining deprecated fields before `docs-only` can pass.

## 6. Documentation content

Documentation distinguishes:

- current fact;
- accepted decision;
- proposal;
- technical hypothesis;
- future direction;
- implemented and validated behaviour.

`log.md` records meaningful outcomes, resulting state and next action. It is not a transcript.

Create a document only when it has a stable responsibility that cannot be handled cleanly by an existing source.

## 7. Decision and evidence discipline

A durable decision requires an identifier, status, date, context, decision, consequences and an evidence gate when needed.

Decision states:

```text
accepted
proposed
deferred
rejected
superseded
```

Upstream documentation proves documented capability, not Windows-native integration. Material runtime uncertainty requires a reproducible spike or implementation test.

## 8. Configuration and state

Maintain four ownership boundaries:

1. canonical versioned configuration;
2. managed configuration materialized on Windows;
3. project-versioned generated configuration;
4. private local values and operational data.

Rules:

- one canonical personal configuration;
- overrides only for demonstrated needs;
- no generic profile framework before a second real configuration;
- generated output has an identifiable source and deterministic inputs;
- installed state is not automatically the source of truth;
- secrets are referenced through private mechanisms;
- derived state is reconstructible or explicitly local-only;
- use the format natively consumed by each component.

## 9. OpenCode and OpenRouter

- Root `opencode.jsonc` owns project runtime configuration.
- `.opencode/` contains native assets only.
- Preserve native `build`, `plan`, `general`, `explore` and `scout`.
- Add only `review` and `verify` until evidence justifies another agent.
- Use `main`, `reason` and `fast` as semantic model roles.
- Concrete models and provider policies belong to OpenRouter presets.
- Do not guess preset syntax inside OpenCode; validate it in `SPIKE-002`.

## 10. Graphify output

`DEC-019` and [DESIGN-003](../design/GRAPHIFY_OUTPUT_POLICY.md) define:

```text
versioned:
  graphify-out/graph.json
  graphify-out/GRAPH_REPORT.md
  graphify-out/manifest.json

ignored:
  graph.html
  cache/
  cost.json
  query logs
  optional exports
```

The manifest remains conditional on SPIKE-004 portability validation. `.graphifyignore` excludes `graphify-out/` from source extraction. Do not commit Graphify output after every edit; synchronize at meaningful structural boundaries.

## 11. Implementation conventions

Until superseded by evidence:

- keep a small presentation-independent core;
- keep the CLI as required control interface;
- keep Ratatui deferred;
- use narrow adapters around external components;
- separate planning/validation from mutation;
- expose plans or dry-runs for state changes;
- make operations idempotent or fail safely;
- return structured findings and outcomes;
- include actionable remediation;
- implement the canonical path before extension points;
- do not create registries, public SDKs or cross-platform abstraction layers without a current need.

TypeScript remains proposed, not accepted, until Windows-native spike evidence exists.

## 12. Dependency policy

Add a dependency only when it provides a concrete canonical capability and is cheaper to maintain than implementing the required subset.

Evaluate existing ownership, Windows installation cost, operational burden, failure behaviour, privacy and packaging consequences. Wrap unstable boundaries narrowly; do not build adapters for unused alternatives.

## 13. Safety

- Deny real secret access or persistence by default.
- Use narrow command allowlists when automation exists.
- Require explicit approval for destructive operations.
- Back up managed files before replacement unless safely reconstructible.
- Capture observability metadata by default; content requires opt-in.
- Redact credentials before logs, traces or UI.
- Bind local services to loopback.
- Never commit credentials, private traces, databases, Graphify cost/query logs or unrelated source.

Prompt instructions alone are insufficient enforcement.

## 14. Verification

Current profile: `docs-only`.

It remains pending until:

- inherited metadata is migrated;
- reserved files lose frontmatter;
- all frontmatter validates;
- internal links resolve;
- decisions, matrix, roadmap and state agree;
- no unsupported implementation claim exists.

When executable code exists, prioritize schema, planning, mutation, lifecycle, security and canonical Windows journey tests.

## 15. Git

- Keep commits conceptually coherent.
- Direct `main` commits are acceptable for low-risk verified documentation and state changes.
- Use branches for spikes, executable implementation, migrations and risky work.
- Pull requests are optional and useful when review, CI or Codex work benefits from an explicit merge boundary.
- Do not mix generated noise, disposable experiments and canonical changes unnecessarily.

## 16. Completion rule

A change is complete when the outcome exists, follows personal-first architecture, sources agree, relevant verification ran or is explicitly pending, state is honest and the next action is discoverable without conversation memory.

## 17. Deferred process

The MVP does not require contributor governance, mandatory PRs, a public extension API, a marketplace, universal generated-project style, cross-platform parity, release trains or support guarantees for hypothetical users.
