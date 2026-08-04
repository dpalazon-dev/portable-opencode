---
type: Vision
title: Portable OpenCode Vision
description: Desired future state and long-term product direction for portable-opencode.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - PROJECT.md
  - ../SPECIFICATION.es.md
verified:
  - by: repository-owner
    status: pending
---

# Vision

## Vision statement

A developer should be able to take a new machine and an empty project, run a small number of explicit commands, and obtain a secure, observable and understandable agentic coding environment whose behaviour can be reproduced, inspected and changed without becoming dependent on a single model vendor.

## Desired experience

The system should feel like a coherent development environment rather than a bag of scripts.

The user should be able to answer at any moment:

- what configuration is active;
- which decisions came from defaults and which were overridden;
- which model and provider executed a task;
- how much a session or project cost;
- whether the graph and project context are current;
- what an agent is allowed to do;
- what remains incomplete or ambiguous;
- how to reproduce the environment elsewhere.

## Product promise

`portable-opencode` should provide:

### A strong starting point

A recommended set of agents, commands, permissions, context documents, routing policies and operational workflows that work together from the beginning.

### Controlled configurability

Opinionated defaults should be replaceable through explicit profiles, fragments and local overrides, not by forking every file.

### Model and provider independence

Agents should depend on semantic roles such as `build`, `explore` or `review`, while OpenRouter resolves concrete models and providers according to policy.

### Local understanding

The repository graph, context, decisions and operational state should live close to the project. Observability should be local by default and privacy-preserving.

### Honest automation

The system should automate deterministic, reversible operations while surfacing semantic or risky decisions to the user.

### Continuity

A new session or agent should be able to recover the project goal, architecture, decisions, touched areas, verification state and next action without relying on invisible conversational memory.

## What excellent looks like

For a new project, the full bootstrap should produce:

- a runnable minimum application;
- structured and linked project context;
- safe OpenCode permissions;
- semantic OpenRouter roles;
- working local observability;
- an audited initial Graphify graph;
- canonical verification commands;
- an explicit ready/not-ready state;
- a clean first commit or a prepared commit boundary.

For ongoing development, the environment should:

- encourage exploration before editing;
- use Graphify and LSP as complementary evidence;
- keep context and graph maintenance low-friction;
- make model routing and cost visible without clutter;
- preserve important state through compaction and handoff;
- prevent accidental secret exposure and destructive operations.

## Long-term direction

After the new-project MVP is reliable, the system may expand toward:

- adoption of existing repositories;
- multiple operating-system profiles;
- team and workspace policies;
- richer observability and evaluation;
- project templates and stack profiles;
- optional integrations such as MCPs or GitHub automation;
- shareable configuration packs without losing local ownership.

These are directions, not promises for the initial release.

## Anti-vision

The project must not become:

- a new proprietary coding client;
- an opaque autonomous agent platform;
- an ever-growing catalogue of prompts and tools;
- a wrapper that hides OpenCode and OpenRouter rather than configuring them;
- a system that requires cloud observability to understand local work;
- a configuration so personal that others cannot reason about or override it;
- a security model based solely on asking the model to behave.

## Vision-level success measures

The vision is being achieved when:

- a fresh setup can be reproduced from versioned configuration;
- users can explain the active architecture and policies;
- model substitutions do not require rewriting project agents;
- the environment detects incomplete initialization and stale state;
- safety restrictions are enforced technically;
- local observability provides trustworthy session and cost attribution;
- another developer can adopt the system without learning its creator's hidden habits.
