# portable-opencode

> Opinionated, portable and configurable agentic coding environment built around **OpenCode + OpenRouter**.

`portable-opencode` is a versioned and reproducible configuration system for preparing developer machines and new repositories for agentic coding. OpenCode acts as the runtime and interaction layer; OpenRouter provides model and provider routing, privacy controls, fallbacks, usage accounting and cost governance.

The system is completed by:

- **local observability** for sessions, models, providers, latency, errors and cost;
- **Graphify** for a continuously maintained structural graph of the codebase;
- **RTK** for reducing terminal noise and context usage;
- structured project documentation and cross-session continuity;
- explicit agents, commands, skills, tools, permissions and lifecycle hooks.

## Status

**Definition and contract design — pre-implementation.**

There is no executable product implementation yet. Owner-level defaults and pre-spike operational contracts are defined; the next technical work is a bounded Windows-native validation phase before the CLI architecture and packaging are fixed from evidence.

The broad Spanish specification is still Draft v0.2 and remains pending synchronization as personal-first v0.3.

## Project knowledge

This repository follows the same context model it intends to generate for other projects:

- [Agent operating rules](AGENTS.md)
- [Canonical context index](docs/context/index.md)
- [Current project definition](docs/context/PROJECT.md)
- [Vision](docs/context/VISION.md)
- [Architecture](docs/context/ARCHITECTURE.md)
- [Conventions](docs/context/CONVENTIONS.md)
- [Operations](docs/context/OPERATIONS.md)
- [Decision log](docs/context/DECISIONS.md)
- [Roadmap](docs/context/ROADMAP.md)
- [Configuration matrix](docs/design/CONFIGURATION_MATRIX.md)
- [Canonical resource catalog](docs/design/CANONICAL_RESOURCE_CATALOG.md)
- [CLI operation contracts](docs/design/CLI_OPERATION_CONTRACTS.md)
- [Evidence and spike mapping](docs/design/EVIDENCE_AND_SPIKE_MAPPING.md)
- [Conceptual and functional specification — Spanish](docs/SPECIFICATION.es.md)

Machine-readable lifecycle state lives in [`.portable-opencode/state.json`](.portable-opencode/state.json). Evidence-gated component intent and canonical resource catalogs live under [`config/`](config/).

## Core idea

```text
OpenCode
├── sessions, agents, commands, tools and permissions
│
├── local observability proxy
│       └── traces, latency, usage, cost and failures
│
└── OpenRouter
        ├── model routing
        ├── provider routing
        ├── fallbacks
        ├── privacy
        └── budgets

Graphify → structural memory of the repository
RTK      → compact operational output
Docs     → curated project context and decisions
```

## Design principles

- Use OpenCode's native capabilities before extending it.
- Be opinionated by default and configurable by design.
- Encode safety in permissions and tooling, not only prompts.
- Automate deterministic operations and ask about ambiguous ones.
- Keep secrets, credentials and private state outside Git.
- Mutate, replace or retire only resources whose ownership is proven.
- Treat pending versions or paths as evidence gaps, not implementation choices.
- Optimize the first release for projects created from scratch.
- Develop this repository according to the same principles it will install elsewhere.

## Planned workflow

```text
portable-opencode install
    ↓
inspect → plan → approve → apply → doctor
    ↓
configure OpenCode + OpenRouter + observability + RTK + Graphify
    ↓
portable-opencode init-project <path>
    ↓
create the portable project scaffold
    ↓
/init-project
    ↓
define context, generate the technical baseline, build the first graph and verify the project
```

## Technical validation

Four bounded Windows-native spikes now own upstream uncertainty:

1. [SPIKE-001 — OpenCode Windows lifecycle](docs/spikes/SPIKE-001_OPENCODE_LIFECYCLE.md)
2. [SPIKE-002 — OpenRouter preset and policy contract](docs/spikes/SPIKE-002_OPENROUTER_POLICY.md)
3. [SPIKE-004 — Graphify and RTK integration](docs/spikes/SPIKE-004_GRAPHIFY_RTK.md)
4. [SPIKE-003 — Windows-native observability](docs/spikes/SPIKE-003_OBSERVABILITY.md)

The order is intentional: OpenCode mechanics first, then OpenRouter representation and Graphify/RTK integration, then the observability proxy against the validated request path.

## Next milestone

Review the operational contracts, then execute `SPIKE-001` as the first bounded Codex assignment. Spike evidence will populate exact supported versions/mechanisms, correct invalid assumptions and provide the basis for resolving implementation language, Phoenix acceptance and final packaging.

Metadata migration and specification v0.3 synchronization remain documentation work before formal definition-phase closure; they do not authorize a spike or implementation agent to invent missing runtime behaviour.

## License

MIT. See [LICENSE](LICENSE).
