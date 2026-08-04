---
type: Vision
title: Portable OpenCode Vision
description: Personal-first product vision, desired user experience and evidence required before broader productization.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - PROJECT.md
  - DECISIONS.md
  - ../SPECIFICATION.es.md
verified:
  - by: repository-owner
    status: pending
---

# Vision

## Vision statement

The repository owner should be able to move to a fresh supported machine or start a new project and recover the same deliberate agentic coding environment through a small number of explicit, inspectable and repeatable operations.

The resulting environment should be safe enough to trust, transparent enough to understand and structured enough to maintain over time without depending on hidden conversational memory or undocumented personal habits.

## Product thesis

A high-quality personal agentic coding environment should not be assembled repeatedly from scattered dotfiles, remembered commands and one-off prompts.

It should exist as a versioned system that coordinates:

- OpenCode as the agent runtime and interaction surface;
- OpenRouter as the model, provider, routing, privacy and cost control plane;
- local observability for trustworthy operational feedback;
- Graphify and LSP for complementary structural understanding;
- RTK for controlled terminal context;
- explicit project context, decisions and lifecycle state;
- safe installation, diagnosis, initialization and repair workflows.

The project succeeds first by improving one real workflow. General usefulness should emerge from clarity and replaceable configuration, not from designing prematurely for unknown users.

## Primary user

The only user required for MVP acceptance is the repository owner.

The system should optimize for:

- the owner's actual development machines;
- new projects created from empty or freshly initialized repositories;
- repeated use across many sessions;
- frequent experimentation with models and providers;
- a technically advanced user who wants strong defaults without losing control;
- public versioning without exposing credentials or private state.

Other developers may reuse the repository, but their onboarding, support, team structure and platform requirements are not initial product constraints.

## Core outcome

The project should turn this:

```text
new machine or empty project
+ remembered setup steps
+ scattered configuration
+ uncertain agent permissions
+ opaque routing and cost
+ lost context between sessions
```

into this:

```text
versioned personal configuration
→ inspect proposed changes
→ install or initialize safely
→ verify the resulting environment
→ work with explicit context and permissions
→ observe model, provider, cost and failures
→ recover the same state in a later session or machine
```

## Desired experience

### On a fresh machine

The owner should be able to:

1. inspect prerequisites and detected environment state;
2. preview what the tool will install or modify;
3. apply one canonical personal configuration;
4. supply credentials through private local mechanisms;
5. verify OpenCode, OpenRouter, Graphify, RTK and observability;
6. receive actionable remediation when something is incomplete;
7. rerun the process without corrupting an existing setup.

### On a new project

The owner should be able to:

1. scaffold the project agentic environment deterministically;
2. enter OpenCode and complete the semantic project definition;
3. generate linked context, decisions and operating rules;
4. establish safe permissions and verification commands;
5. build and audit the initial Graphify graph;
6. reach an explicit `ready` state only when required checks pass.

### During normal development

The environment should make it easy to answer:

- which configuration is active;
- which values are canonical defaults and which are local overrides;
- what an agent is allowed to do;
- which model and provider handled a task;
- how much a session or project cost;
- whether observability is complete or degraded;
- whether project context and Graphify are current;
- which decisions remain unresolved;
- what verification has passed;
- what the next session needs to know.

### When something changes or fails

The owner should be able to:

- inspect configuration drift;
- understand the source of each effective setting;
- preview repairs before applying them;
- recover safely from partial installation or interrupted operations;
- migrate versioned configuration without losing private state;
- see degraded capabilities instead of receiving false success.

## Product principles

### Personal-first, reusable by others

Optimize the canonical workflow for the owner. Keep configuration readable and replaceable so others can reuse it without making their needs an MVP dependency.

### One real default before many profiles

The first version should ship one coherent personal configuration. New profiles should appear only after a genuine repeated need demonstrates that one default is insufficient.

### Explicit over magical

The system should explain what it detected, what it plans to change, where a value originates and why an operation is blocked or degraded.

### Deterministic before conversational

Installation, file generation, validation and state transitions should be deterministic. Semantic project questions belong in the OpenCode agent workflow where natural-language reasoning adds value.

### Native before custom

Prefer OpenCode and OpenRouter capabilities before introducing wrappers, plugins or parallel abstractions. Custom code must close a documented gap.

### Local-first and private by default

Credentials, private traces and raw conversational content must stay outside Git. Observability should store metadata locally by default, with content capture requiring explicit opt-in.

### Safe and reversible

State-changing operations should support planning, narrow scope, backups where appropriate, idempotence and actionable recovery.

### Honest state

The system must distinguish `ready`, `dirty`, `degraded`, `blocked` and incomplete states. Planned capabilities must never appear as implemented merely because they exist in documentation.

### Maintainable after memory fades

The environment should remain understandable months later from versioned files, decisions, state and diagnostics rather than the owner's recollection of how it was assembled.

## MVP vision

The MVP is successful when the owner can complete one end-to-end personal workflow on the initial supported environment:

```text
fresh supported machine
→ portable-opencode installation
→ verified OpenCode + OpenRouter environment
→ new project scaffold
→ semantic /init-project workflow
→ initial graph and verification
→ explicit ready state
→ subsequent session recovers context and operational state
```

The MVP should prove:

- one canonical configuration can be reproduced;
- installation and project initialization are inspectable and repeatable;
- credentials and private state remain outside versioned configuration;
- model and provider choices can change without rewriting project instructions;
- permissions are enforced through configuration and tooling;
- observability provides useful local attribution of latency, usage, cost and failure;
- Graphify and curated context remain current enough to assist later sessions;
- the tool reports incomplete or degraded state accurately;
- the same core operations remain usable without a TUI.

## Definition of portability

For the MVP, portability means:

- reproducibility across the owner's explicitly supported machines;
- reuse of the same system across new projects;
- versioned and reviewable configuration;
- separation of portable configuration from local credentials and runtime data;
- replacement of explicit defaults without reconstructing the entire environment.

Portability does not initially require:

- equal support for every operating system;
- zero-dependency execution on every machine;
- a generic plugin ecosystem;
- team policy synchronization;
- compatibility with every coding agent or model provider;
- universal project templates.

## Public reuse

The public repository should remain understandable and forkable.

This requires:

- documented defaults and rationale;
- clear private-state boundaries;
- explicit assumptions about the supported environment;
- reproducible setup instructions;
- configuration that can be replaced without editing opaque internals.

It does not require the MVP to provide:

- generalized onboarding flows;
- compatibility guarantees for unknown environments;
- multi-user administration;
- support commitments;
- organization-level governance;
- a catalogue of user personas and profiles.

## Anti-vision

The project must not become:

- a generic framework designed around hypothetical users;
- a second agent runtime or replacement for OpenCode;
- an opaque autonomous system that hides decisions;
- an ever-growing catalogue of agents, prompts, profiles and integrations;
- a wrapper that duplicates native OpenCode or OpenRouter functionality;
- a platform whose architecture is driven by a visual interface;
- a cloud-dependent observability product;
- an enterprise governance system for a single-user problem;
- a personal setup so hard-coded that its assumptions cannot be inspected or changed;
- a documentation project that never reaches a working end-to-end workflow.

## Expansion triggers

Broader productization should occur only when evidence justifies it.

Possible triggers include:

- the owner needs two genuinely different workflows that cannot be expressed through small overrides;
- a second real user adopts the system and exposes a repeated limitation;
- another operating system is required by the owner's own work;
- a team workflow becomes an actual recurring need;
- external use becomes sustained enough to justify compatibility and support cost;
- an upstream OpenCode or OpenRouter capability changes the optimal product boundary.

Until one of these triggers occurs, expansion remains optional and must not increase MVP complexity.

## Vision-level success measures

The vision is being achieved when:

- the owner can rebuild the supported environment without relying on memory;
- a new project reaches `ready` through explicit, verifiable stages;
- rerunning installation or initialization is safe;
- active configuration and overrides can be explained;
- model substitutions do not require rewriting project agents;
- agent permissions and destructive boundaries are technically enforced;
- local observability attributes sessions, providers, costs and failures reliably;
- stale graph, context or verification state is visible;
- a later session can continue from repository state without hidden chat history;
- adding a capability requires a demonstrated personal need or explicit future trigger.
