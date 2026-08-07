# AGENTS.md

This file defines the permanent operating rules for AI coding agents working in this repository.

## 1. Project identity

`portable-opencode` is an opinionated, portable and configurable **OpenCode + OpenRouter agentic coding environment**.

It is not merely a collection of OpenCode dotfiles. OpenCode is the runtime and interaction layer; OpenRouter is the model, provider, privacy, routing and cost control plane. Local observability, Graphify, RTK and structured project context complete the system.

The repository must develop itself according to the same principles it intends to apply to other projects. This is a dogfooding requirement, not a cosmetic preference.

## 2. Mandatory reading order

Before planning or changing the repository, read the smallest relevant set of sources in this order:

1. `docs/context/index.md`
2. `docs/context/PROJECT.md`
3. `docs/context/VISION.md`
4. `docs/context/ARCHITECTURE.md`
5. `docs/context/CONVENTIONS.md`
6. `docs/context/OPERATIONS.md`
7. `docs/context/DECISIONS.md`
8. `docs/context/ROADMAP.md`
9. `docs/SPECIFICATION.es.md` when deeper product detail is required

Do not treat this file as a substitute for the project context.

## 3. Source-of-truth hierarchy

When sources disagree, apply this order:

1. explicit user instruction in the current task;
2. accepted decisions in `docs/context/DECISIONS.md`;
3. current architecture and conventions documents;
4. current project and roadmap documents;
5. the conceptual specification;
6. implementation code and generated state;
7. historical notes and logs.

Do not silently reconcile contradictions. Report them and update the appropriate source of truth once resolved.

## 4. Current phase

The repository is in **definition and technical-validation readiness**.

At this stage:

- documentation is a first-class deliverable;
- architectural boundaries may be specified before implementation details;
- prototypes must be clearly labelled as spikes;
- unverified capabilities of OpenCode, OpenRouter, Codex or third-party tools must remain hypotheses;
- no document may claim a component or orchestration mechanism is implemented/reliable merely because it is planned or configured.

Consult `.portable-opencode/state.json` for the machine-readable project state.

## 5. Working method

For any non-trivial change:

1. establish the goal and affected source-of-truth documents;
2. inspect existing decisions before proposing new ones;
3. distinguish fact, adopted decision, proposal and open question;
4. make the smallest coherent change;
5. update documentation and state in the same change when behaviour or architecture changes;
6. run the relevant verification profile;
7. leave the repository in a state another agent can understand without hidden context.

## 6. Codex development orchestration

`.codex/` is repository-development tooling for building `portable-opencode` with Codex. It is not part of the OpenCode product agent surface and must never be copied into `.opencode/agents/` or generated project templates.

For **non-trivial Codex development work**, the canonical parent role is:

```text
development-orchestrator
```

`docs/design/CODEX_DEVELOPMENT_ORCHESTRATION.md` (`DESIGN-012`) defines the binding protocol. `docs/spikes/SPIKE-000_CODEX_ORCHESTRATION.md` must validate the installed Codex behavior before this hierarchy is treated as structurally reliable.

### 6.1 Topology

Use a flat parent-mediated hierarchy:

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

Rules:

- `development-orchestrator` is the only master role;
- specialists report directly to the master;
- specialists do not recursively spawn or command other specialists;
- delegation depth remains `1` unless a later accepted design changes it;
- the master should not implement the same substantial scope concurrently with the worker that owns it;
- use parallel workers only for genuinely independent scopes or read-only evidence tasks.

### 6.2 Advisory roles

`context-manager` and `prompt-engineer` advise the master. They do not form a command chain and do not own product implementation.

Use `context-manager` to recover/synchronize bounded authoritative context when task state spans multiple sources.

Use `prompt-engineer` when complex execution instructions, agent prompts, eval prompts or output contracts materially benefit from prompt-specialist work. Do not invoke it ceremonially for every small task.

### 6.3 Work Packages

Non-trivial delegated implementation must have a bounded Work Package matching the intent of:

```text
schemas/codex-work-package.schema.json
```

It must identify:

- task/goal;
- assigned specialist;
- authoritative sources;
- include/exclude scope;
- invariants;
- required verification;
- stop conditions;
- deliverables;
- parent/depth contract;
- Task Receipt contract.

Do not delegate vague work when repository contracts can make the assignment precise.

### 6.4 Task Receipts

A delegated worker must return observable completion evidence matching the intent of:

```text
schemas/codex-task-receipt.schema.json
```

At minimum report:

- status;
- files changed;
- commands/checks run and real outcomes;
- verification evidence;
- assumptions/deviations;
- blockers/residual risks;
- parent decisions still required.

No receipt means the delegated work is not ready for acceptance.

### 6.5 Verification and fresh review

The implementation owner does not provide the final independent acceptance signal for its own meaningful change.

Use deterministic checks first, `test-engineer` when additional risk-driven verification is required, and a fresh `code-reviewer` for meaningful implementation, safety-sensitive lifecycle/configuration work, or when deterministic checks are insufficient.

The reviewer should receive the original Work Package/goal, resulting diff and verification evidence, not depend on the implementer's private reasoning.

The master returns the final `ACCEPT`, `RETRY`, `NARROW` or `BLOCK` decision.

### 6.6 Orchestration failure

If Codex cannot demonstrably invoke the intended named role, do not silently substitute another agent and claim the hierarchy worked. Record the routing limitation and follow the `SPIKE-000` outcome policy.

Do not build custom dispatch wrappers/hooks merely to hide an upstream limitation unless a later explicit design accepts that work.

## 7. Dogfooding rules

The repository must model the future generated project structure wherever doing so is useful and honest.

Required behaviours:

- keep curated context in `docs/context/`;
- use explicit lifecycle metadata in context documents;
- record durable decisions in `DECISIONS.md`;
- record meaningful progress in `log.md`;
- keep machine-readable state in `.portable-opencode/state.json`;
- use `.graphifyignore` as a first-class configuration file;
- avoid storing credentials, private traces, local databases or generated caches;
- encode safety in configuration and tooling when implementation begins, not only in prompts.

Do not create placeholder agents, commands, plugins or tools merely to make the tree look complete. Add them when their behaviour and validation criteria are defined.

## 8. Architecture boundaries

Preserve these responsibility boundaries:

- **OpenCode:** sessions, agents, commands, tools, permissions and user interaction.
- **OpenRouter:** model and provider routing, fallbacks, privacy, budgets and usage accounting.
- **Local observability:** transparent request tracing, operational events, latency, cost and failures.
- **Graphify:** structural memory of the repository and graph quality lifecycle.
- **RTK:** compact, structured terminal output for agent context.
- **Context documents:** curated knowledge, rationale, constraints and project continuity.
- **`.codex/`:** repository-local development orchestration only; never generated product configuration.

Do not duplicate a native OpenCode or OpenRouter capability unless the repository documents a concrete gap.

## 9. Safety and privacy

Never read, print, persist or commit:

- API keys, tokens or credentials;
- `.env` files containing real values;
- SSH keys or certificates;
- raw prompts or responses captured without explicit opt-in;
- local observability databases;
- private traces or user source code copied from unrelated projects.

Destructive Git operations, force pushes and broad filesystem deletion require explicit user approval. Prefer reversible operations and narrow file scopes.

## 10. Documentation rules

Context documents must:

- state their purpose and scope;
- distinguish current state from desired state;
- use links instead of duplicating large sections;
- preserve rationale for non-obvious decisions;
- expose unresolved questions rather than hiding them;
- follow `DESIGN-004` metadata rules and never reintroduce deprecated `created`, `modified` or generic `verified` frontmatter;
- avoid claims unsupported by the specification, implementation or verified documentation.

`docs/SPECIFICATION.es.md` is the broad product specification. Do not turn every operational detail into a specification edit; place it in the appropriate context document.

## 11. Implementation rules

When source code is introduced:

- treat TypeScript as the current leading option, not an accepted final language, until `DEC-009` is resolved by evidence;
- keep adapters around external services and CLIs;
- make installers and migrations idempotent;
- support dry-run or explain modes for state-changing operations as defined by CLI contracts;
- validate configuration against schemas;
- return structured errors with actionable remediation;
- make platform-specific behaviour explicit;
- add tests for configuration generation, state transitions and safety boundaries.

Do not resolve evidence-gated language or packaging decisions by implementation-agent preference.

## 12. Verification

The current verification profile is `docs-only`:

- Markdown metadata and reserved-file rules conform to `DESIGN-004`;
- JSON/JSONC and repository-owned schemas validate;
- internal references resolve;
- no secrets or generated local state are committed;
- project status and decision records match the actual repository state.

Canonical repository validation currently runs through:

```text
scripts/verify-docs.ps1
```

and `.github/workflows/ci.yml` is a thin Windows CI adapter over that validator.

Once executable product code exists, define and record canonical commands for formatting, linting, type checking, tests, builds and smoke checks in `OPERATIONS.md` and `.portable-opencode/state.json`.

## 13. Completion criteria for agent work

A task is not complete until:

- the requested outcome exists in the repository;
- relevant context and decisions are consistent;
- required verification has been performed or its absence is explicitly explained;
- delegated work has the required Receipt and independent acceptance evidence when applicable;
- no unsupported implementation or orchestration claim has been introduced;
- the next agent can identify the current state and next step from versioned files.
