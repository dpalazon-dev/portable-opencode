---
type: Project Context
title: Portable OpenCode Project Definition
description: Current identity, primary user, scope, constraints and development state of portable-opencode.
status: active
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../SPECIFICATION.es.md
  - ../../README.md
  - DECISIONS.md
verified:
  - by: repository-owner
    status: pending
---

# Project

## Current definition

`portable-opencode` is a public, versioned and reproducible **personal configuration system** for creating and maintaining an opinionated but configurable agentic coding environment built jointly on OpenCode and OpenRouter.

OpenCode is the runtime and interaction surface. OpenRouter is the control plane for models, providers, routing, privacy, fallbacks and cost. Local observability, Graphify, RTK and structured context complete the environment.

The project is developed first for the repository owner's real workflow. Publishing it on GitHub provides versioning, transparency and the possibility of reuse by others, but third-party adoption is not an MVP requirement.

The project is not currently an implemented installer or production-ready tool. It remains in the **definition and architectural design phase**.

## Product posture

The governing principle is:

> **Personal-first, reusable by others.**

This means:

- the repository owner is the only primary user of the MVP;
- the canonical configuration should represent a real working environment, not an abstract average user;
- portability initially means reproducibility across the owner's machines and new projects;
- configurability exists so decisions can be changed without rebuilding the system;
- public reuse is welcome, but must not force premature multi-user, team, enterprise or universal-platform abstractions;
- generalization should follow demonstrated needs rather than precede them.

The project may become useful to other developers because its configuration is explicit and replaceable. It will not initially optimize onboarding, support or governance for those developers.

## Problem

A personal agentic coding environment can grow through uncoordinated local changes:

- prompts and instructions are spread across files;
- permissions are implicit;
- model selection is manually coupled to agents;
- project knowledge disappears between sessions;
- graph and context maintenance become optional chores;
- costs, fallbacks and provider behaviour are opaque;
- setup cannot be reproduced reliably on another machine or project;
- personal conventions become difficult to audit or change because they are undocumented.

## Proposed solution

Provide one canonical workflow that configures:

1. the repository owner's development machine;
2. OpenCode and its global behaviour;
3. OpenRouter policies and semantic model roles;
4. a local observability path between OpenCode and OpenRouter;
5. a new project's agentic scaffold;
6. structured context and decisions;
7. Graphify and RTK;
8. project verification and cross-session continuity.

The workflow should encode the owner's preferred defaults while keeping important values explicit and replaceable.

## Primary user

The primary user of the MVP is:

- the repository owner, who is also the initial design authority and first real user.

No additional user personas are required for MVP acceptance.

Other developers may inspect, fork or reuse the repository, but their needs do not justify new abstractions until they align with or reveal a concrete limitation in the primary workflow.

## Primary environment

The first supported environment is **Windows native**, operated through PowerShell and Windows Terminal.

WSL is not part of the canonical path and must not be required by installation, execution, testing or recovery workflows.

This means:

- installation and lifecycle scripts are PowerShell-first;
- dependencies must provide a usable native Windows path;
- subprocess, filesystem, path, quoting and process-lifecycle behaviour must be validated on Windows;
- unsupported Unix-only assumptions are implementation blockers rather than hidden prerequisites;
- Linux, macOS and WSL support are deferred until a real need appears.

The exact supported Windows version and PowerShell version will be recorded in the supported-version manifest before the first release.

## Initial use case

The first supported path is a **new project created by the repository owner from an empty or freshly created directory**.

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

The initial success case is not “works for every developer”. It is:

> The repository owner can reproduce the same understood, observable and safe environment on Windows and use it repeatedly across new projects.

## Core scope

- install and configure OpenCode for the canonical personal workflow;
- define and verify the owner's OpenRouter policy;
- run local observability;
- install and configure RTK and Graphify;
- deploy global and project OpenCode configuration;
- scaffold project context and agent infrastructure;
- provide only the agents, commands, skills, plugins and custom tools required by the canonical workflow;
- encode permissions and safety boundaries;
- maintain project state and continuity;
- verify that a project is genuinely ready;
- explain active defaults, overrides and degraded conditions.

## Explicit non-goals for the first version

- building a new agentic coding client;
- creating a generic multi-agent framework;
- supporting every coding tool or LLM provider equally;
- supporting multiple user personas or team roles;
- team workspaces, shared governance or organization administration;
- a generic profile marketplace or extensive profile hierarchy;
- WSL, Linux or macOS as required or equivalent first-release paths;
- optimizing installation and onboarding for unknown third parties;
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
- reduced personal-first configuration matrix awaiting owner review;
- Windows native selected as the primary environment;
- no executable implementation yet;
- no language or package manager permanently selected;
- no technical spike completed;
- Graphify lifecycle not active because there is no source implementation yet;
- verification profile is documentation-only.

## Constraints

- the system must solve the repository owner's actual workflow before optimizing for reuse;
- the canonical MVP must run on Windows without WSL;
- configuration must be portable across the owner's supported Windows machines and projects;
- secrets and private state must remain outside Git;
- native OpenCode and OpenRouter capabilities must be preferred over duplication;
- default behaviour must be safe and understandable;
- optional components must not blur core responsibility boundaries;
- the system must remain maintainable by one person;
- abstractions require a current use case, repeated variation or verified technical need;
- public readability is desirable, but productization for third parties is deferred.

## Success in the current phase

The definition phase is complete when:

- context documents consistently express the personal-first scope;
- architecture boundaries are explicit;
- the configuration matrix represents the canonical Windows-native workflow;
- MVP acceptance criteria are testable against the owner's Windows environment;
- major technical uncertainties have named spikes;
- implementation can begin without rediscovering product intent;
- deferred generalization is clearly separated from MVP requirements.
