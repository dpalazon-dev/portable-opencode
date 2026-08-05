---
type: Design
id: DESIGN-002
title: Agent and Model Role Policy
description: Minimal mapping between native OpenCode agents, custom personal subagents and semantic OpenRouter roles.
status: active
created: 2026-08-05
modified: 2026-08-05
sources:
  - ../context/PROJECT.md
  - ../context/ARCHITECTURE.md
  - ../context/DECISIONS.md
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
  - CONFIGURATION_MATRIX.md
verified:
  - by: repository-owner
    status: pending
---

# Agent and model role policy

## 1. Objective

Define the smallest agent and model policy that supports the owner's real coding workflow without duplicating OpenCode built-ins or coupling agent names to concrete models.

The design separates:

```text
agent responsibility
≠
model policy
```

An OpenCode agent defines behaviour, permissions and task position. An OpenRouter semantic role defines model, provider, routing, privacy, fallback and generation policy.

## 2. Governing rules

- preserve OpenCode built-ins unless a demonstrated gap exists;
- do not create one preset per agent automatically;
- create a custom agent only for a repeated responsibility with distinct permissions or output contract;
- keep concrete model names outside agent prompts;
- map agents to semantic roles;
- let OpenRouter own routing and fallback policy;
- leave exact OpenCode preset-reference syntax to `SPIKE-002`;
- keep agent permissions stricter than or equal to the global baseline.

## 3. OpenCode agents

### Native primary agents

| Agent | Source | Purpose | Portable treatment |
|---|---|---|---|
| `build` | OpenCode built-in | implementation and normal development | keep as default primary; configure model role and safe permissions |
| `plan` | OpenCode built-in | analysis and planning without direct implementation | keep as second primary; map to reasoning role |

No custom `build.md` or `plan.md` is required unless a short override cannot be expressed cleanly in `opencode.jsonc`.

### Native subagents

| Agent | Source | Purpose | Portable treatment |
|---|---|---|---|
| `general` | OpenCode built-in | broad delegated task | retain; use only where a more specific agent does not apply |
| `explore` | OpenCode built-in | targeted codebase exploration | retain; do not create a duplicate custom explore agent |
| `scout` | OpenCode built-in | fast repository reconnaissance | retain; use for cheap initial discovery |

Built-in internal agents such as compaction, title and summary remain OpenCode implementation concerns. They may consume the configured lightweight model through native settings.

### Custom personal subagents

#### `review`

**Purpose:** independent analysis of code or a proposed change without mutation.

```yaml
mode: subagent
permission:
  edit: deny
  bash: ask
  external_directory: deny
```

Expected output:

- findings ordered by severity;
- evidence and affected location;
- consequences;
- recommended correction;
- explicit statement when no material issue is found.

`review` does not implement fixes unless the user returns to `build` and approves implementation.

#### `verify`

**Purpose:** execute and interpret the project's canonical verification manifest without editing source.

```yaml
mode: subagent
permission:
  edit: deny
  bash: ask
  external_directory: deny
```

At project initialization, exact canonical verification commands may be allowed narrowly for this agent. Unknown commands continue to ask.

Expected output:

- commands executed;
- exit status;
- failed checks and preserved raw-output location when RTK is active;
- readiness impact;
- narrow remediation.

`verify` may not silently repair failures.

## 4. Semantic OpenRouter roles

The MVP uses exactly three roles.

### `main`

For implementation and interactive coding.

Policy intent:

- high tool-calling reliability;
- strong code generation and editing;
- balanced reasoning and latency;
- conservative fallback to models with equivalent tool support;
- metadata-only observability by default.

Initial agent mapping:

```text
build → main
```

### `reason`

For planning, review and failure interpretation where reasoning quality matters more than speed.

Policy intent:

- stronger reasoning setting where supported;
- low response randomness;
- tool support retained where agent permissions allow it;
- fallback only to models suitable for analysis and code review.

Initial agent mapping:

```text
plan   → reason
review → reason
verify → reason
```

### `fast`

For exploration, reconnaissance, title/summary work and other lightweight tasks.

Policy intent:

- low latency and cost;
- sufficient context and tool-calling support;
- no fallback to models that cannot satisfy required tools;
- suitable candidate for OpenCode `small_model`.

Initial agent mapping:

```text
general → fast
explore → fast
scout   → fast
small_model → fast
```

## 5. Preset identity

The expected OpenRouter preset slugs are:

```text
portable-main
portable-reason
portable-fast
```

These slugs are remote identities, not concrete model names. Their desired policy will be stored in a versioned local manifest.

`SPIKE-002` must determine how OpenCode should reference them. The design must not assume that a guessed `provider/model` string is valid merely because OpenRouter accepts `@preset/<slug>` in direct API requests.

## 6. OpenCode configuration intent

The root `opencode.jsonc` should eventually express the equivalent of:

```text
default_agent = build
small_model   = fast role
build.model   = main role
plan.model    = reason role
review.model  = reason role
verify.model  = reason role
explore.model = fast role
scout.model   = fast role
general.model = fast role
```

Exact model identifiers are generated only after SPIKE-002 validates preset representation.

Custom agents are stored as:

```text
.opencode/agents/review.md
.opencode/agents/verify.md
```

The project may omit a custom agent when its responsibility is not needed, but the canonical personal scaffold includes both because review and verification are repeated cross-project workflows with distinct non-mutating permissions.

## 7. Commands

Initial commands that bind to custom agents:

```text
/review  → review subagent, subtask=true
/verify  → verify subagent, subtask=true
```

Other commands such as `/init-project` and `/graph-update` are lifecycle workflows and are designed separately. Commands must not duplicate built-in OpenCode commands accidentally.

## 8. Permission policy

Global policy remains the baseline. Per-agent policy narrows it.

Minimum invariants:

- `review` and `verify` cannot edit;
- `git push`, destructive deletion and external-directory mutation are denied or explicitly approved according to the global policy;
- exact project verification commands may be allowed for `verify` after initialization;
- subagent invocation is limited to required agents through `permission.task` when useful;
- agent rules are validated against OpenCode's last-match-wins semantics.

## 9. Explicit exclusions

The initial design does not create:

- custom copies of `build`, `plan`, `general`, `explore` or `scout`;
- `architect`, `docs`, `security`, `debug`, `test`, `research` or stack-specific agents;
- one preset per command;
- one preset per project;
- a dynamic model router inside portable-opencode;
- automatic agent creation from community catalogues.

A new agent requires repeated work with a distinct permission or output contract. A new semantic role requires materially different model/provider policy that cannot be represented by the three current roles.

## 10. Validation

`SPIKE-001` validates:

- built-in agent availability and customization;
- Markdown custom-agent discovery;
- primary versus subagent modes;
- per-agent permission merging;
- `permission.task` behaviour;
- `/review` and `/verify` command-to-subagent invocation.

`SPIKE-002` validates:

- exact OpenCode references for OpenRouter presets;
- role-to-preset mapping;
- tool compatibility and fallbacks;
- preset reconciliation and version identity;
- `small_model` use through the fast role.

## 11. Reconsideration triggers

Expand only when:

- repeated use shows one native agent has insufficient behaviour or permissions;
- review and verification need different model policies;
- a stack-specific workflow recurs across several projects;
- one of the three roles produces incompatible tool, privacy, latency or cost requirements;
- upstream OpenCode agents materially change.
