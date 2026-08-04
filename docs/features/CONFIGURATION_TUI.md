---
type: Feature Definition
id: FEAT-001
title: Interactive Configuration TUI
description: Proposed first-party Ratatui interface for configuring, initializing, diagnosing and repairing portable-opencode.
status: proposed
created: 2026-08-04
modified: 2026-08-04
decision: DEC-013
sources:
  - ../context/PROJECT.md
  - ../context/VISION.md
  - ../context/ARCHITECTURE.md
  - ../context/DECISIONS.md
  - ../context/ROADMAP.md
  - https://ratatui.rs/
verified:
  - by: repository-owner
    status: pending
---

# Interactive Configuration TUI

## 1. Summary

`portable-opencode` should provide an optional first-party terminal user interface for installing, configuring, initializing, diagnosing and repairing the OpenCode + OpenRouter environment.

The proposed implementation technology is **Ratatui**.

The TUI is not the product core and must not own business logic. It is a presentation adapter over the same application engine used by the headless CLI.

```text
                    ┌──────────────────┐
                    │   Ratatui TUI    │
                    └────────┬─────────┘
                             │
┌──────────────────┐   ┌─────▼─────────────────┐
│   Headless CLI   │──▶│  Application engine  │
└──────────────────┘   │ plans · validation   │
                       │ state · operations    │
                       └──────────┬────────────┘
                                  │
                       ┌──────────▼────────────┐
                       │ System adapters       │
                       │ filesystem · process  │
                       │ OpenCode · OpenRouter │
                       │ Graphify · RTK        │
                       └───────────────────────┘
```

## 2. Product classification

The TUI is classified as a:

> **Strategic first-party frontend, optional at runtime and subsequent to the core lifecycle engine.**

It is more than a cosmetic add-on because it can make a distributed and potentially destructive configuration understandable, reviewable and repairable. It is not foundational to the first technical proof because every operation must remain available through a non-interactive or conventional CLI.

## 3. Problem statement

The product coordinates configuration across several systems:

- OpenCode global and project configuration;
- OpenRouter roles, providers, privacy and budget policies;
- local observability;
- Graphify installation, scope and pending decisions;
- RTK;
- project context and lifecycle state;
- generated files, backups, upgrades and migrations.

A sequence of isolated terminal prompts becomes difficult to reason about when decisions are interdependent. Users need to see:

- current state;
- desired state;
- detected problems;
- proposed changes;
- consequences of profile choices;
- progress and failures;
- safe repair actions.

## 4. Goals

The TUI should:

1. present the environment and project state as a coherent whole;
2. guide configuration without hiding the underlying files or operations;
3. let the user review a complete plan before applying changes;
4. show current, proposed and inherited values;
5. support backwards navigation before execution;
6. expose diagnostics and actionable repair operations;
7. show operation progress, warnings and failures clearly;
8. help resolve accumulated Graphify decisions;
9. preserve a headless equivalent for every operation;
10. remain keyboard-operable and usable on supported terminals.

## 5. Non-goals

The TUI must not:

- replace the OpenCode TUI or agent conversation;
- recreate OpenCode session, chat or coding functionality;
- replace Phoenix or another observability explorer;
- become a general Graphify visualization client;
- replace versioned configuration files as the source of truth;
- contain filesystem, process or configuration mutation logic;
- become mandatory in CI, remote automation or non-TTY environments;
- turn the semantic `/init-project` interview into a rigid form.

The deterministic project scaffold may be configured through the TUI. Semantic project definition remains an OpenCode agent workflow.

## 6. Primary workflows

### 6.1. Environment installation

The user can inspect detected prerequisites and select a profile before installation.

```text
Environment
  ✓ Git
  ✓ OpenCode
  ! Rust toolchain not detected
  ✗ Graphify missing
  ✓ OpenRouter credential detected
  ✗ Observability backend stopped

Profile
  Privacy          standard-private
  Observability    Phoenix local
  Graphify         enabled
  RTK              enabled

[Review plan] [Install] [Doctor] [Exit]
```

### 6.2. Change-plan review

Before mutation, the TUI presents:

- files to create, update, link or remove;
- backups to create;
- external software to install;
- commands to execute;
- state transitions;
- warnings and approval requirements;
- an inspectable diff when possible.

Applying through the TUI and applying the equivalent CLI plan must produce the same result.

### 6.3. Doctor and repair

The user can inspect diagnostics grouped by component:

- OpenCode;
- OpenRouter;
- observability;
- Graphify;
- RTK;
- context;
- state;
- security.

Each failure should provide evidence, impact and a safe remediation action. Repair actions must generate a normal application plan rather than bypassing the engine.

### 6.4. Project scaffold initialization

For `portable-opencode init-project`, the TUI may guide deterministic choices such as:

- project path;
- selected base profile;
- components to enable;
- template and stack profile when already known;
- generated context structure;
- Graphify baseline;
- verification profile.

It must clearly stop at `scaffolded`. The semantic `/init-project` workflow inside OpenCode is responsible for reaching `ready`.

### 6.5. Pending Graphify decisions

The TUI may present ambiguous paths in a batch-oriented decision view.

```text
Pending graph decisions

[ ] src/generated/   Generated OpenAPI client
[ ] migrations/      SQL migration history
[ ] fixtures/        Test data

Recommendation: exclude src/generated/
Reason: generated implementation with low semantic value

(E) Exclude  (I) Include  (T) Types only  (L) Later
```

Decisions must be persisted through the same state service used by the CLI and OpenCode tools.

### 6.6. Upgrade and migration

A future workflow may compare:

- installed repository version;
- current local configuration;
- target version;
- migrations required;
- user overrides that would be affected.

No migration may be performed solely by view-layer code.

## 7. Candidate information architecture

The first useful version should remain small.

### Primary views

1. **Home** — overall status and next recommended action.
2. **Environment** — prerequisites and installed component versions.
3. **Profiles** — OpenRouter, privacy, observability, Graphify and RTK choices.
4. **Plan** — proposed operations and configuration diff.
5. **Execution** — progress, logs, warnings, cancellation and result.
6. **Doctor** — diagnostics and repair actions.
7. **Project** — scaffold state and initialization progress.
8. **Pending decisions** — unresolved Graphify or configuration decisions.

### Explicitly deferred views

- observability dashboards;
- graph visualization;
- OpenCode session browser;
- model marketplace;
- plugin marketplace;
- team administration.

## 8. Application-engine contract

The TUI depends on a presentation-independent engine. The engine should expose typed or serializable concepts equivalent to:

```text
CurrentState
DesiredConfiguration
Plan
PlanOperation
Diagnostic
Remediation
ProgressEvent
OperationOutcome
PendingDecision
```

Required properties:

- deterministic planning from the same inputs;
- no mutation during plan construction;
- dry-run support;
- structured diagnostics;
- cancellable operations where safe;
- explicit non-cancellable boundaries;
- machine-readable output for tests and automation;
- stable identifiers for operations and diagnostics;
- redaction before data reaches the view.

The TUI must never write files or execute arbitrary commands directly.

## 9. CLI equivalence

Every TUI capability must have a headless equivalent. Candidate commands include:

```text
portable-opencode
portable-opencode tui
portable-opencode install --profile <name>
portable-opencode doctor --json
portable-opencode plan install --json
portable-opencode apply <plan-id>
portable-opencode init-project <path> --profile <name>
portable-opencode graph decisions --json
```

Exact command names remain open. The invariant is that the TUI invokes application operations, not shell commands assembled inside UI components.

In a non-TTY environment, the application must not attempt to launch the TUI.

## 10. Ratatui boundary

Ratatui is the proposed rendering and interaction library. Crossterm is the expected terminal backend unless a spike identifies a concrete reason to choose another.

Ratatui does not settle the implementation language of the entire product. The technical spike must compare at least:

### Option A — Rust application core, CLI and TUI

Advantages:

- one binary and shared types;
- straightforward Ratatui integration;
- strong process and filesystem control;
- reduced runtime prerequisites.

Costs:

- OpenCode plugins and tools may still require TypeScript;
- a multi-language repository remains likely;
- higher initial implementation learning cost.

### Option B — Non-Rust core with a separate Rust TUI

Advantages:

- preserves another language for the domain layer.

Costs:

- protocol and process boundary;
- duplicated models or generated bindings;
- two packaging and update paths;
- greater MVP complexity.

Option B should not be adopted without evidence that the separation is worth its operational cost.

## 11. Safety and privacy requirements

- Secret values must never be rendered by default.
- Credential presence may be shown; credential contents may not.
- Destructive or external operations require explicit confirmation.
- The final confirmation must summarize irreversible effects.
- A quit or cancellation action must leave the terminal and project state recoverable.
- Errors and panics must restore terminal mode.
- Raw prompts, responses or trace payloads must not appear unless content capture is explicitly enabled.
- TUI logs must follow the same redaction policy as other outputs.

## 12. Accessibility and fallback requirements

- All essential actions must be keyboard accessible.
- Mouse support may be additive but never required.
- Key bindings must be visible or discoverable.
- Colour cannot be the only carrier of status.
- Terminal resize must not corrupt interaction state.
- A conventional CLI path is mandatory for users or environments for which the TUI is unsuitable.
- Small terminal sizes must fail gracefully with a clear minimum-size message or reduced layout.

## 13. Quality requirements

The TUI should be:

- responsive while operations run;
- explicit about current focus and active operation;
- recoverable after failed subprocesses;
- consistent across Windows Terminal, Linux terminals and macOS terminals in the supported matrix;
- testable through state/update logic without requiring terminal rendering;
- snapshot-tested selectively for important layouts;
- low in idle resource use.

## 14. Acceptance criteria

The feature cannot move to `accepted-for-implementation` until:

1. the shared application engine can generate and apply plans without the TUI;
2. identical inputs produce equivalent plan identifiers through CLI and TUI;
3. the TUI performs no direct filesystem or process mutations;
4. non-TTY execution falls back safely;
5. terminal state is restored after normal exit, error and forced cancellation scenarios;
6. a user can inspect an install plan before applying it;
7. `doctor` findings provide actionable remediation;
8. secrets are redacted in all screens and logs;
9. Windows Terminal and at least one Linux terminal pass the spike scenario;
10. the implementation boundary does not create an unjustified second lifecycle engine.

## 15. Technical spike: SPIKE-005

### Objective

Determine whether Ratatui provides sufficient product value and whether it should influence the language and packaging architecture.

### Minimal prototype

Implement only:

1. a home/doctor view backed by fixture diagnostics;
2. an install-plan review view backed by a serialized plan;
3. a profile selector that produces desired configuration without applying it;
4. simulated asynchronous progress and cancellation;
5. clean terminal restoration after controlled failure.

### Questions to resolve

- Does Ratatui behave reliably on the intended platform matrix?
- Can the event/update model remain separate from domain operations?
- What is the cleanest progress and cancellation contract?
- Is a single Rust binary materially simpler than another runtime?
- How are OpenCode TypeScript extensions packaged alongside it?
- What test strategy gives confidence without brittle visual snapshots?
- Does the TUI reduce configuration error compared with guided CLI prompts?
- What is the minimum viable screen set?

### Evidence produced

- prototype source;
- recorded platform results;
- measured startup and idle resource use;
- failure and recovery notes;
- recommendation on core language boundary;
- revised feature status and decision.

## 16. Delivery position

The TUI must not precede the core planning and state engine.

Recommended order:

```text
configuration matrix
  → technical spikes
  → shared application engine
  → headless CLI and structured output
  → minimal Ratatui frontend
  → expanded install and doctor flows
  → project-scaffold and maintenance flows
```

## 17. Open questions

- Should `portable-opencode` without arguments open the TUI or show CLI help?
- Is Ratatui shipped in the canonical binary or as an optional package?
- Does the first version support project scaffold initialization or only environment setup?
- Which operations need real-time logs versus summarized progress?
- How are long diffs inspected without turning the TUI into an editor?
- Which accessibility limitations must be documented explicitly?
- Should Graphify decision resolution live in the first TUI release?
- How should the TUI expose inherited versus overridden configuration?

## 18. Related decision

This feature is governed by [DEC-013](../context/DECISIONS.md#dec-013--provide-an-optional-first-party-configuration-tui-with-ratatui).

Changes to the strategic role, optionality, application-engine boundary or selected rendering technology require updating both this feature definition and DEC-013.
