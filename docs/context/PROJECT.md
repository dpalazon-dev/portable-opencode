---
type: Project Context
title: Portable OpenCode Project Definition
description: Current identity, users, scope, constraints and development state of portable-opencode.
status: active
created: 2026-08-04
modified: 2026-08-04
sources:
  - ../SPECIFICATION.es.md
  - ../../README.md
verified:
  - by: repository-owner
    status: pending
---

# Project

## Current definition

`portable-opencode` is a public, versioned and reproducible configuration system for creating an opinionated but configurable **agentic coding environment built jointly on OpenCode and OpenRouter**.

OpenCode is the runtime and interaction surface. OpenRouter is the control plane for models, providers, routing, privacy, fallbacks and cost. Local observability, Graphify, RTK and structured context complete the environment.

The project is not currently an implemented installer or production-ready tool. It is in the **definition and architectural design phase**.

## Problem

Agentic coding environments tend to grow through uncoordinated local changes:

- prompts and instructions are spread across files;
- permissions are implicit;
- model selection is manually coupled to agents;
- project knowledge disappears between sessions;
- graph and context maintenance are optional chores;
- costs, fallbacks and provider behaviour are opaque;
- setup cannot be reproduced reliably on another machine or project.

## Proposed solution

Provide a canonical workflow that configures:

1. the developer machine;
2. OpenCode and its global behaviour;
3. OpenRouter policies and semantic model roles;
4. a local observability path between OpenCode and OpenRouter;
5. a new project's agentic scaffold;
6. structured context and decisions;
7. Graphify and RTK;
8. project verification and cross-session continuity.

## Initial users

- the repository owner, as the first real user and design authority;
- developers who want a strong default configuration without accepting vendor lock-in;
- small teams that need reproducible agent behaviour and model governance;
- advanced users willing to override defaults through profiles and local configuration.

## Initial use case

The first supported path is a **new project created from an empty or freshly created directory**.

The intended journey is:

```text
portable-opencode install
    ↓
portable-opencode init-project <path>
    ↓
OpenCode /init-project
    ↓
project reaches ready state
    ↓
normal agentic development with maintained context and graph
```

## Core scope

- install and configure OpenCode;
- define and verify OpenRouter policy;
- run local observability;
- install and configure RTK and Graphify;
- deploy global and project OpenCode configuration;
- scaffold project context and agent infrastructure;
- provide base agents, commands, skills, plugins and custom tools;
- encode permissions and safety boundaries;
- maintain project state and continuity;
- verify that a project is genuinely ready.

## Explicit non-goals for the first version

- building a new agentic coding client;
- creating a generic multi-agent framework;
- supporting every coding tool or LLM provider equally;
- mandatory MCP infrastructure;
- autonomous background agents;
- complete support for legacy repositories;
- remote-first observability;
- automatic architectural decisions;
- installing large catalogues of community skills.

## Current repository state

- public GitHub repository created;
- conceptual specification v0.2 published;
- initial curated context established;
- no executable implementation yet;
- no language or package manager permanently selected;
- no technical spike completed;
- Graphify lifecycle not active because there is no source implementation yet;
- verification profile is documentation-only.

## Constraints

- configuration must be portable across machines;
- secrets and private state must remain outside Git;
- native OpenCode and OpenRouter capabilities must be preferred over duplication;
- Windows support matters, with Unix-like environments likely used for development and CI;
- default behaviour must be safe and understandable;
- optional components must not blur core responsibility boundaries;
- the system must remain useful to one developer without requiring enterprise services.

## Success in the current phase

The definition phase is complete when:

- context documents are coherent and non-duplicative;
- architecture boundaries are explicit;
- a configuration matrix exists;
- MVP acceptance criteria are testable;
- major technical uncertainties have named spikes;
- implementation can begin without rediscovering product intent.
