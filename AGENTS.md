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

The repository is in **definition and architectural design**.

At this stage:

- documentation is a first-class deliverable;
- architectural boundaries may be specified before implementation details;
- prototypes must be clearly labelled as spikes;
- unverified capabilities of OpenCode, OpenRouter or third-party tools must remain hypotheses;
- no document may claim a component is implemented merely because it is planned.

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

## 6. Dogfooding rules

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

## 7. Architecture boundaries

Preserve these responsibility boundaries:

- **OpenCode:** sessions, agents, commands, tools, permissions and user interaction.
- **OpenRouter:** model and provider routing, fallbacks, privacy, budgets and usage accounting.
- **Local observability:** transparent request tracing, operational events, latency, cost and failures.
- **Graphify:** structural memory of the repository and graph quality lifecycle.
- **RTK:** compact, structured terminal output for agent context.
- **Context documents:** curated knowledge, rationale, constraints and project continuity.

Do not duplicate a native OpenCode or OpenRouter capability unless the repository documents a concrete gap.

## 8. Safety and privacy

Never read, print, persist or commit:

- API keys, tokens or credentials;
- `.env` files containing real values;
- SSH keys or certificates;
- raw prompts or responses captured without explicit opt-in;
- local observability databases;
- private traces or user source code copied from unrelated projects.

Destructive Git operations, force pushes and broad filesystem deletion require explicit user approval. Prefer reversible operations and narrow file scopes.

## 9. Documentation rules

Context documents must:

- state their purpose and scope;
- distinguish current state from desired state;
- use links instead of duplicating large sections;
- preserve rationale for non-obvious decisions;
- expose unresolved questions rather than hiding them;
- update `modified` metadata when materially changed;
- avoid claims unsupported by the specification, implementation or verified documentation.

`docs/SPECIFICATION.es.md` is the broad product specification. Do not turn every operational detail into a specification edit; place it in the appropriate context document.

## 10. Implementation rules

When source code is introduced:

- prefer TypeScript for OpenCode plugins, custom tools and portable orchestration unless a documented decision selects another language;
- keep adapters around external services and CLIs;
- make installers and migrations idempotent;
- support dry-run or explain modes for state-changing operations;
- validate configuration against schemas;
- return structured errors with actionable remediation;
- make platform-specific behaviour explicit;
- add tests for configuration generation, state transitions and safety boundaries.

These are current defaults, not irrevocable commitments. Changes require a recorded decision.

## 11. Verification

The current verification profile is `docs-only`:

- Markdown files are present and internally linked;
- JSON files parse successfully;
- no secrets or generated local state are committed;
- project status and decision records match the actual repository state.

Once executable code exists, define and record canonical commands for formatting, linting, type checking, tests, builds and smoke checks in `OPERATIONS.md` and `.portable-opencode/state.json`.

## 12. Completion criteria for agent work

A task is not complete until:

- the requested outcome exists in the repository;
- relevant context and decisions are consistent;
- verification has been performed or its absence is explicitly explained;
- no unsupported implementation claim has been introduced;
- the next agent can identify the current state and next step from versioned files.
