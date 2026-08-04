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

**Definition and architectural design — Draft v0.2.**

There is no executable implementation yet. The current work defines the product, architecture, responsibilities, lifecycle, decisions and MVP boundaries before implementation begins.

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
- [Conceptual and functional specification — Spanish](docs/SPECIFICATION.es.md)

Machine-readable lifecycle state lives in [`.portable-opencode/state.json`](.portable-opencode/state.json).

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
- Optimize the first release for projects created from scratch.
- Develop this repository according to the same principles it will install elsewhere.

## Planned workflow

```text
portable-opencode install
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

## Next milestone

The next step is the **configuration matrix**, describing for every capability:

- global, project and private ownership;
- default value and override mechanism;
- static versus generated configuration;
- user decisions;
- related hooks or tools;
- validation criteria.

After that, focused technical spikes will validate OpenCode's extension lifecycle, OpenRouter semantic routing, local observability and Graphify maintenance before implementation architecture is fixed.

## License

MIT. See [LICENSE](LICENSE).
