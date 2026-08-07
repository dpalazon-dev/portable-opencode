---
type: Design
id: DESIGN-012
title: Codex Development Orchestration
description: Repository-local master-worker protocol for bounded Codex delegation, verification, review and context synchronization.
status: active
sources:
  - resource: ../../.codex/config.toml
    title: Repository-local Codex configuration
  - resource: ../../AGENTS.md
    title: Repository agent operating rules
  - resource: CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: ../context/OPERATIONS.md
    title: Portable OpenCode Operations
---

# Codex Development Orchestration

## 1. Objective

Make multi-agent Codex development predictable enough to use for `portable-opencode` without confusing agent capability with agent authority.

The repository uses one master coordinator and a flat set of specialist workers/advisors:

```text
user
  -> development-orchestrator
       -> context-manager
       -> prompt-engineer
       -> cli-developer
       -> powershell-7-expert
       -> powershell-ui-architect
       -> test-engineer
       -> code-reviewer
```

The master owns decomposition, delegation, acceptance and escalation. Specialists own bounded technical work. No specialist becomes a second master.

This is **repository-development tooling only**. It does not change the OpenCode product-agent policy in `DESIGN-002`, and `.codex/agents/` must never be copied into generated project templates or `.opencode/agents/`.

## 2. Why a protocol is required

Custom role files alone do not guarantee useful orchestration. A reliable workflow needs explicit answers to:

- who owns the task;
- what authority each role has;
- what context a worker receives;
- what a worker may change;
- how success is checked;
- who independently reviews the result;
- what evidence returns to the parent;
- when work retries versus blocks.

The protocol therefore uses four layers:

```text
role definition
+ Work Package
+ Task Receipt
+ parent acceptance gate
```

`SPIKE-000` must validate that the installed Codex build actually loads and executes these roles as intended before this mechanism becomes a relied-upon development dependency.

## 3. Topology

### 3.1 One master

`development-orchestrator` is the only repository-local master role.

It may:

- classify work;
- recover context;
- construct Work Packages;
- choose specialists;
- coordinate independent parallel work;
- require verification and fresh review;
- accept, retry, narrow or block results;
- trigger durable context synchronization.

It should not implement the same substantial scope that it has delegated to a worker.

### 3.2 Flat specialists

All specialists report directly to the orchestrator. The initial configuration fixes:

```toml
max_depth = 1
```

Specialists must not recursively create a second delegation tree. If a worker discovers another specialty is required, it returns that need to the orchestrator.

### 3.3 Parent-mediated coordination

Specialists exchange information through the parent, not through an implicit shared memory or hidden peer-to-peer protocol.

This keeps responsibility observable:

```text
worker A receipt
    -> orchestrator
        -> bounded input to worker B
```

## 4. Role classes

### 4.1 Master

| Role | Responsibility |
|---|---|
| `development-orchestrator` | decomposition, routing, Work Packages, acceptance, retries, blocking and final integration |

### 4.2 Advisory/context specialists

| Role | Responsibility | Must not own |
|---|---|---|
| `context-manager` | minimal authoritative context, durable synchronization, handoffs, contradiction discovery | product architecture invention |
| `prompt-engineer` | complex prompt/work-brief quality, agent instructions, eval prompts, structured output contracts | model policy, product architecture, implementation |

These roles improve the worker's input. They do not become a chain of command beneath the master.

### 4.3 Implementation specialists

| Role | Responsibility |
|---|---|
| `cli-developer` | product CLI/core implementation against accepted contracts |
| `powershell-7-expert` | PowerShell 7 and Windows-native bootstrap/process/path/CI/spike mechanics |
| `powershell-ui-architect` | PowerShell presentation/UI boundaries and future UI advice; product TUI remains deferred |

A task should have one clear implementation owner whenever possible. Multiple implementation workers are used only when their write scopes are separable or one worker is collecting evidence rather than modifying the same files.

### 4.4 Quality specialists

| Role | Responsibility |
|---|---|
| `test-engineer` | risk-driven verification, fixtures, regression checks and CI/test implementation |
| `code-reviewer` | read-only independent diff review and merge recommendation |

The implementation owner cannot substitute for independent final review when fresh review is required.

## 5. Canonical orchestration lifecycle

For non-trivial implementation work:

```text
CLASSIFY
  -> GROUND
  -> SHAPE
  -> DELEGATE
  -> RECEIVE
  -> VERIFY
  -> REVIEW
  -> DECIDE
  -> SYNCHRONIZE
```

### CLASSIFY

Determine whether the task is:

- context/research;
- prompt/instruction work;
- spike/evidence collection;
- implementation;
- test/verification;
- review;
- orchestration-only housekeeping.

### GROUND

Read the smallest authoritative source set. Use `context-manager` when the task spans multiple decisions/designs or when current state is easy to misread.

The context packet should contain only:

```text
task
binding decisions
binding contracts
relevant state
relevant schemas
known evidence
unknowns/blockers
authoritative files
```

### SHAPE

Create one Work Package per delegated ownership unit.

Use `prompt-engineer` when:

- instructions have multiple interacting constraints;
- the target agent is prone to over-broad interpretation;
- exact output format/tool behavior matters;
- a spike needs a high-fidelity experimental prompt;
- agent/prompt assets themselves are being designed.

Do not invoke it mechanically for every trivial task.

### DELEGATE

Assign the package to one named specialist. Parallel execution is allowed only for independent packages.

### RECEIVE

Require a Task Receipt. A worker's prose claim that work is complete is insufficient by itself.

### VERIFY

Run deterministic checks first. Delegate to `test-engineer` when additional risk-driven verification is required.

### REVIEW

Use a fresh `code-reviewer` for meaningful code changes, safety-sensitive changes, lifecycle/ownership code, or when deterministic verification cannot establish correctness alone.

The reviewer receives:

```text
original goal / Work Package
+ resulting diff
+ verification evidence
```

It should not depend on the implementing worker's private reasoning.

### DECIDE

The orchestrator returns one of:

```text
ACCEPT
RETRY
NARROW
BLOCK
```

Retry only with concrete failed criteria/evidence. Block rather than inventing a missing product decision.

### SYNCHRONIZE

After accepted work, use `context-manager` when canonical context/state/log documents materially changed. Do not generate documentation churn when no durable meaning changed.

## 6. Work Package contract

Machine-readable contract:

```text
schemas/codex-work-package.schema.json
```

A Work Package includes:

- `task_id`;
- `title`;
- `goal`;
- `assigned_agent`;
- optional advisors;
- authoritative sources;
- explicit include/exclude scope;
- invariants;
- required verification;
- stop conditions;
- deliverables;
- orchestration metadata;
- Task Receipt schema.

The schema constrains the parent to `development-orchestrator` and delegation depth to `1`.

Work Packages are **execution objects, not automatically permanent project records**. They may remain session-local. Persist one only when it materially improves reproducibility, such as a spike, incident, complex handoff or reusable development workflow.

### Invalid package examples

Do not delegate when a package effectively says:

```text
"Implement the feature correctly."
```

or when:

- include/exclude ownership is unclear;
- success cannot be tested;
- an unresolved decision is assumed;
- required evidence is missing;
- destructive work lacks explicit safety/ownership preconditions.

## 7. Task Receipt contract

Machine-readable contract:

```text
schemas/codex-task-receipt.schema.json
```

A worker reports:

- task and agent identity;
- status (`completed`, `partial`, `blocked`, `failed`);
- changed files;
- commands/checks run and their real outcomes;
- acceptance verification evidence;
- assumptions;
- deviations;
- blockers;
- residual risks;
- decisions still required from the parent.

The Receipt is evidence for the parent, not proof by itself. The parent still applies verification/review gates.

## 8. Prompt/context advisor pattern

`context-manager` and `prompt-engineer` advise the master; they do not command implementation workers.

Preferred flow:

```text
                    context-manager
                   /               \
user -> orchestrator                 -> orchestrator -> worker
                   \               /
                    prompt-engineer
```

Not:

```text
orchestrator -> context-manager -> prompt-engineer -> cli-developer -> test-engineer
```

The second pattern creates hidden chains of authority and makes failures harder to attribute.

## 9. Freshness and information boundaries

### Fresh reviewer

The reviewer should begin from the Work Package/diff/evidence rather than inheriting the worker's persuasive narrative.

### Minimal worker context

Workers receive enough context to act correctly, not the entire project history by default. Excess irrelevant context increases conflicts and accidental scope expansion.

### No private reasoning dependency

Work Packages and Receipts contain observable requirements/evidence only. The protocol never requires private chain-of-thought to cross agent boundaries.

## 10. Parallelism

Parallelize when:

- write sets are independent;
- one task is read-only evidence gathering;
- results can be integrated deterministically by the parent.

Do not parallelize two workers that both own the same lifecycle/config/state surface without an explicit merge strategy.

The initial thread limit remains a capacity ceiling, not a target. The orchestrator should use fewer agents when fewer are sufficient.

## 11. Failure and escalation

Block and return to the user/parent decision boundary when:

- a new architecture/product decision is required;
- Codex cannot demonstrably load the intended custom role;
- upstream behavior needed by the task is unknown;
- destructive mutation ownership is ambiguous;
- privacy/safety requirements cannot be met;
- repeated bounded retries fail;
- specialist output contradicts an accepted source of truth.

Never hide orchestration failure by having the master silently complete the worker's task and claim delegation succeeded.

## 12. SPIKE-000 gate

`SPIKE-000` validates the actual Codex build before relying on this design.

Required evidence includes:

- repository-local config discovery;
- custom role discovery;
- explicit or otherwise observable role invocation;
- role-specific instruction adherence;
- depth-1 behavior;
- parent-mediated return;
- Work Package/Receipt round trip;
- fresh reviewer invocation;
- behavior when a named role cannot be selected reliably.

Possible outcomes:

### PASS

Use this orchestration as the default for non-trivial Codex development tasks.

### PARTIAL/INCONCLUSIVE

Keep role files, but treat some routing as semantic/prompt-enforced rather than structurally guaranteed. Record the exact limitation before starting SPIKE-001.

### FAIL

Do not invent a custom dispatcher immediately. Return the development-orchestration decision for review with evidence of the missing Codex capability.

## 13. Completion gate

This design is operationally usable when:

- the master role is registered;
- Work Package and Receipt schemas exist;
- `AGENTS.md` requires the protocol for non-trivial Codex work;
- `SPIKE-000` has an executable brief;
- the installed Codex behavior has been tested before the first product runtime spike.
