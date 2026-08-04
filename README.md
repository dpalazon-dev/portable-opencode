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

**Specification stage — Draft v0.2.**

The current work defines the product, architecture, responsibilities, initialization lifecycle and MVP boundaries before implementation begins.

Read the full specification:

- [Conceptual and functional specification — Spanish](docs/SPECIFICATION.es.md)

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

## Repository roadmap

The next implementation step is to turn the specification into a configuration matrix describing, for every capability:

- global configuration;
- project configuration;
- default value;
- dynamic generation rules;
- user decisions;
- related hooks or tools;
- validation criteria.

## License

MIT. See [LICENSE](LICENSE).
