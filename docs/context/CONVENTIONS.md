---
type: Conventions
title: Portable OpenCode Repository Conventions
description: Minimal conventions that keep the personal-first repository explicit, safe and maintainable.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - PROJECT.md
  - VISION.md
  - ARCHITECTURE.md
  - DECISIONS.md
  - ../../AGENTS.md
verified:
  - by: repository-owner
    status: pending
---

# Conventions

## 1. Purpose

These conventions exist to reduce mistakes, forgotten assumptions and maintenance cost in the repository owner's real workflow.

They are not a contributor handbook, public SDK contract or attempt to standardize every possible project.

A convention belongs here only when it does at least one of the following:

- prevents a recurring error;
- makes behaviour inspectable after memory fades;
- protects secrets or destructive boundaries;
- keeps generated output reproducible;
- clarifies ownership between portable-opencode, OpenCode, OpenRouter and external tools;
- provides a stable rule that agents must follow repeatedly.

If a rule serves only hypothetical collaborators, profile variants or unsupported platforms, defer it until the need exists.

## 2. Governing rules

- Personal-first, reusable by others.
- One canonical personal configuration before additional profiles.
- Explicit state before implicit memory.
- Native capability before custom code.
- Deterministic operation before conversational automation.
- Inspect before changing; plan before applying; verify after applying.
- Keep secrets and private operational data outside Git.
- Do not claim support or implementation without evidence.
- Prefer the smallest coherent abstraction that solves the current problem.

## 3. Source-of-truth discipline

Use the narrowest canonical document:

| Concern | Source of truth |
|---|---|
| Current identity, scope and status | `PROJECT.md` |
| Desired personal outcome | `VISION.md` |
| Component boundaries and lifecycle | `ARCHITECTURE.md` |
| Repeated repository rules | `CONVENTIONS.md` |
| How work is performed | `OPERATIONS.md` |
| Durable decisions and rationale | `DECISIONS.md` |
| Delivery order | `ROADMAP.md` |
| Feature-specific behaviour | `docs/features/` |
| Implementable configuration contracts | `docs/design/` |
| Machine-readable current state | `.portable-opencode/state.json` |
| Concise chronological transitions | `log.md` |

Do not duplicate large sections between documents. Link to the source and record only the implication relevant to the current document.

When sources conflict, follow the hierarchy defined in `AGENTS.md` and resolve the inconsistency explicitly.

## 4. Language and naming

### Language

- Code, schemas, identifiers, CLI commands and machine-readable values use English.
- Canonical repository documentation may use English while the project remains owner-led.
- Do not maintain duplicate translations unless both have a real maintenance purpose.
- Avoid mixing languages inside one identifier or technical concept.

### Naming

- Product and CLI: `portable-opencode` until renamed by decision.
- Context documents: uppercase semantic names under `docs/context/`.
- CLI commands: lowercase kebab-case.
- OpenCode slash commands: lowercase kebab-case, for example `/graph-update`.
- Custom tools: lowercase snake_case, for example `graph_status`.
- Plugins: lowercase kebab-case prefixed with `portable-` only when a plugin actually exists.
- Semantic model roles: short stable nouns such as `build`, `explore`, `review` and `verify`.
- Decisions: `DEC-NNN`.
- Features: `FEAT-NNN`.
- Designs: `DESIGN-NNN`.
- Spikes: `SPIKE-NNN`.

Do not create identifiers for speculative components merely to make the repository appear complete.

## 5. Documentation conventions

Curated context documents use Markdown with YAML frontmatter.

Required fields:

- `type`;
- `title`;
- `description`;
- `status`;
- `created`;
- `modified`.

Use `sources` when another repository artefact materially supports the document. Verification metadata must describe real review or evidence; never invent approval.

Documentation must distinguish:

- current fact;
- accepted decision;
- proposal;
- technical hypothesis;
- future direction;
- implemented and validated behaviour.

`log.md` stays concise. It records meaningful outcomes, resulting state and the next action. It is not a transcript and does not repeat full rationale.

Create a new document only when it has a stable responsibility that cannot be handled cleanly by an existing source of truth.

## 6. Decision and evidence conventions

A durable decision requires:

- identifier;
- status;
- date;
- context;
- decision or proposal;
- consequences;
- evidence gate when acceptance depends on a spike.

Allowed decision states:

- `accepted`;
- `proposed`;
- `deferred`;
- `rejected`;
- `superseded`.

Do not convert an open question into an accepted decision for convenience.

Upstream documentation is evidence of documented capability, not proof that the capability works in the owner's environment. Behaviour that materially affects architecture requires a reproducible spike or implementation test.

## 7. Configuration and state conventions

Maintain four explicit ownership boundaries:

1. canonical versioned configuration in this repository;
2. managed configuration materialized on the owner's machine;
3. project-versioned configuration generated into target repositories;
4. private local values and operational data that never enter Git.

Rules:

- one canonical personal configuration is the default;
- add an override only for a demonstrated need;
- do not build a generic profile framework before a second real configuration exists;
- generated output must have an identifiable source and be deterministic for equivalent inputs;
- user-editable or generated structured files require validation when implementation begins;
- installed state is not automatically the source of truth;
- secrets must be referenced through private mechanisms, never interpolated into committable templates;
- derived state must be reconstructible or clearly marked as local-only.

Prefer the format natively consumed by the target component. Do not introduce YAML, TOML, JSONC or another format solely for stylistic consistency.

## 8. Implementation conventions

Until superseded by evidence and an accepted decision:

- keep a small presentation-independent application core;
- keep the CLI as the required control interface;
- treat the Ratatui TUI as an optional adapter, not an architectural driver;
- use narrow adapters around OpenCode, OpenRouter, Graphify, RTK, Phoenix and filesystem/process boundaries;
- keep pure planning and validation separate from mutation;
- state-changing operations must expose an explicit plan or dry-run where practical;
- make operations idempotent or fail safely when repetition is unsafe;
- return structured findings, operations and outcomes;
- include actionable remediation in errors;
- implement the canonical personal path before generalized extension points;
- do not create plugin systems, registries, public SDKs or cross-platform abstraction layers without a current use case.

TypeScript remains a proposed default for OpenCode extensions and orchestration. Ratatui introduces a possible Rust boundary. Neither is accepted for the whole implementation until the relevant spikes provide evidence.

## 9. Dependency conventions

Add a dependency only when it provides a concrete capability needed by the canonical workflow and is cheaper to maintain than implementing the required subset directly.

Before adding a foundational dependency, evaluate:

- whether an existing component already owns the capability;
- installation cost on the primary environment;
- operational and update burden;
- failure behaviour;
- privacy implications;
- whether it forces an unnecessary runtime or packaging model.

Wrap unstable external boundaries narrowly. Do not build adapters for alternatives that are not being used.

## 10. Safety conventions

- Deny reading or persisting real secrets by default.
- Prefer narrow command allowlists once executable automation exists.
- Destructive operations require explicit approval and a visible target scope.
- Back up an existing managed file before replacing it unless the operation is safely reconstructible.
- Local observability captures metadata by default; content capture requires explicit opt-in.
- Redact credentials and sensitive values before logs, traces or UI rendering.
- Bind local service interfaces to loopback by default.
- Never commit API keys, credentials, private traces, observability databases or unrelated source code.

Safety rules are enforced in code, permissions and adapters when possible. Prompt instructions alone are insufficient.

## 11. Verification conventions

Verification grows with the implementation. Do not create ceremonial test layers before there is code to test.

Current profile: `docs-only`.

When executable code exists, prioritize tests for:

1. configuration and state schemas;
2. pure planning and composition logic;
3. filesystem mutation and rollback boundaries;
4. lifecycle state transitions;
5. safety and secret-redaction behaviour;
6. the canonical end-to-end personal journey;
7. only the platform environments the owner actually supports.

Test a second platform or profile when it becomes part of the real supported path, not because a generic product might need it eventually.

A change is not verified merely because it worked once interactively. Record the command, fixture or procedure that produced the evidence.

## 12. Git conventions

This is a personal repository. Process should create useful review boundaries, not bureaucracy.

- Keep commits conceptually coherent.
- Commit messages describe the outcome, not the editing activity.
- Direct commits to `main` are acceptable for low-risk documentation and repository-maintenance changes after verification.
- Use a branch for technical spikes, executable implementation, risky migrations or changes that benefit from an isolated review boundary.
- Pull requests are optional for personal work and useful when reviewing a substantial diff, preserving experiment discussion or asking an agent to implement against a bounded task.
- Do not require issue, branch and PR ceremony for every small change.
- Do not mix generated noise, experimental output and canonical changes when they can be separated.

## 13. Generated and local files

Ignore by default:

- credentials and real `.env` files;
- observability databases and raw private traces;
- caches and temporary logs;
- build output and coverage;
- generated Graphify output unless a specific artefact is deliberately versioned;
- editor and terminal transient state;
- disposable spike output that is not evidence.

Fixtures and small evidence artefacts may be committed when they are intentionally sanitized, reproducible and necessary to validate a contract.

## 14. Completion rule

A repository change is complete when:

- the requested outcome exists;
- it follows the personal-first architecture;
- affected sources of truth agree;
- relevant verification was executed or explicitly deferred;
- project state reflects the actual situation;
- no unsupported capability claim was introduced;
- the next action is discoverable without relying on conversation memory.

## 15. Explicitly deferred process

The MVP does not require:

- contributor governance;
- mandatory pull requests;
- a public extension API;
- a profile marketplace;
- a universal style guide for generated projects;
- cross-platform parity policies;
- release trains or formal support windows;
- compatibility guarantees for users who are not part of the canonical personal workflow.

Introduce these only after a concrete need appears.