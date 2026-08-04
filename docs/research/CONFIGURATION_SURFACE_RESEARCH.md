---
type: Research Note
id: RESEARCH-001
title: Configuration Surface Research
description: Official configuration and integration surfaces that constrain the portable-opencode design.
status: active
created: 2026-08-05
modified: 2026-08-05
sources:
  - ../SPECIFICATION.es.md
  - ../context/PROJECT.md
  - ../context/VISION.md
  - ../context/ARCHITECTURE.md
verified:
  - by: repository-owner
    status: pending
---

# Configuration surface research

## 1. Purpose

This document records what the selected upstream tools already support and how those capabilities should shape `portable-opencode`.

It is evidence for [DESIGN-001](../design/CONFIGURATION_MATRIX.md), not a replacement for upstream documentation. Facts below come from current primary documentation reviewed on **2026-08-05**. Product choices remain governed by accepted repository decisions.

## 2. Research rule

For every desired capability:

1. use the upstream native surface when it is sufficient;
2. configure it through its documented file, command or API;
3. wrap it only when lifecycle coordination, validation or reproducibility is missing;
4. create a spike when the documented surface does not prove runtime behaviour;
5. avoid building generic abstractions for a single personal configuration.

## 3. OpenCode

### Documented configuration surfaces

OpenCode supports JSON or JSONC configuration and publishes a JSON Schema. It loads global configuration from `~/.config/opencode/opencode.json(c)` and project configuration from direct `opencode.json(c)` files and `.opencode/opencode.json(c)` directories. Project files are merged according to documented precedence, with `.opencode` configuration overriding direct configuration in the same hierarchy.

OpenCode also exposes runtime override locations through environment variables such as `OPENCODE_CONFIG`, `OPENCODE_CONFIG_DIR` and `OPENCODE_CONFIG_CONTENT`.

Native configurable capabilities relevant to this project include:

- global and project configuration;
- provider and model definitions;
- environment and file substitution for secret references;
- global and project `AGENTS.md` rules;
- primary agents and subagents;
- custom commands;
- on-demand skills;
- permissions with `allow`, `ask` and `deny`;
- per-agent permission overrides;
- LSP and formatter configuration;
- context compaction;
- watcher ignore patterns;
- plugins and custom tools;
- separate `tui.json(c)` preferences;
- session sharing policy.

Credentials added through `/connect` are stored by OpenCode in its local authentication store rather than in project configuration.

### Design implications

- `portable-opencode` should generate or manage documented OpenCode files instead of creating a parallel configuration format for OpenCode concepts.
- The canonical project should choose one project config form and use it consistently. Mixing direct and `.opencode` config forms should be avoided unless precedence is intentional.
- `AGENTS.md`, agents, commands and skills should remain native assets.
- Permission policy is a first-class generated configuration because OpenCode defaults are permissive.
- OpenCode plugins should be limited to gaps that cannot be solved with configuration. The V2 plugin API is currently documented as beta, so plugin-dependent lifecycle behaviour requires a spike.
- OpenCode's own TUI preferences are distinct from the deferred portable configuration TUI.

### Primary sources

- [OpenCode configuration](https://opencode.ai/docs/config/)
- [OpenCode rules and AGENTS.md precedence](https://opencode.ai/docs/rules/)
- [OpenCode providers and OpenRouter integration](https://opencode.ai/docs/providers/)
- [OpenCode agents](https://opencode.ai/docs/agents/)
- [OpenCode permissions](https://opencode.ai/docs/permissions/)
- [OpenCode commands](https://opencode.ai/docs/commands/)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode tools](https://opencode.ai/docs/tools/)
- [OpenCode TUI configuration](https://opencode.ai/docs/tui/)
- [OpenCode V2 plugins](https://opencode.ai/v2/docs/build/plugins)

## 4. OpenRouter

### Documented configuration surfaces

OpenRouter supports request-level provider routing through the `provider` object, including ordered providers, sorting by price, throughput or latency, provider fallbacks, parameter compatibility, data-collection restrictions and Zero Data Retention routing.

It supports model fallback arrays and returns the model ultimately used.

Presets are named, versioned remote configurations that can encapsulate:

- model selection;
- model fallbacks;
- provider routing;
- system prompts;
- generation parameters;
- provider inclusion or exclusion.

Presets can be referenced as `@preset/<slug>` and can be created or versioned through API endpoints from known-good inference request bodies.

Usage accounting is included in every response, including streaming responses, and exposes tokens, cost, reasoning and cache information. Prompt and response logging is off by default; OpenRouter still retains operational metadata.

### Design implications

- Semantic model roles can be implemented with a small set of OpenRouter presets rather than a custom routing service.
- A versioned local manifest should describe the expected preset names and policy. The CLI should reconcile or verify remote presets instead of treating remote state as invisible.
- Provider routing and privacy should remain OpenRouter policy, while OpenCode references the resulting model or preset.
- Personal guardrails and key-management automation are optional. Organization administration is outside the MVP.
- Cost and usage capture should consume the response data already returned by OpenRouter.
- Session affinity should not be assumed until verified.

### Primary sources

- [OpenRouter presets](https://openrouter.ai/docs/guides/features/presets)
- [OpenRouter provider routing](https://openrouter.ai/docs/guides/routing/provider-selection)
- [OpenRouter model fallbacks](https://openrouter.ai/docs/guides/routing/model-fallbacks)
- [OpenRouter usage accounting](https://openrouter.ai/docs/cookbook/administration/usage-accounting)
- [OpenRouter data collection and privacy](https://openrouter.ai/docs/guides/privacy/data-collection)
- [OpenRouter guardrails](https://openrouter.ai/docs/guides/features/guardrails/overview)

## 5. Graphify

### Documented configuration surfaces

Graphify is distributed through the `graphifyy` Python package and provides platform-specific installation for OpenCode. Its documented OpenCode workflow includes:

- `graphify install --platform opencode`;
- `graphify opencode install` to install persistent OpenCode guidance;
- graph extraction and update commands;
- optional Git hooks;
- `.graphifyignore`.

`.graphifyignore` uses gitignore-style syntax. Graphify also respects `.gitignore`. Current documentation states that `.graphifyignore` is evaluated as an additional exclusion layer and cannot re-include a file already excluded by `.gitignore`; `--no-gitignore` is the explicit escape hatch when ignored generated code must be analyzed.

Graphify documentation recommends versioning useful graph output for shared use, while local cost and cache artefacts can remain ignored. A personal project may choose a narrower output policy, but it must be explicit.

### Design implications

- Installation and OpenCode integration already exist and should be invoked, verified and recorded rather than reimplemented.
- `.graphifyignore` generation must account for `.gitignore` merge semantics.
- The first graph and ignore audit remain part of project initialization.
- Automatic hooks should follow a stable explicit-update workflow, not precede it.
- Graph freshness and graph quality are portable lifecycle concerns.
- MCP exposure remains optional and is not needed for the canonical path.

### Primary sources

- [Graphify repository and command reference](https://github.com/safishamsi/graphify)
- [Graphify Spanish installation and platform integration](https://github.com/Graphify-Labs/graphify/blob/v8/docs/translations/README.es-ES.md)
- [graphifyy package](https://pypi.org/project/graphifyy/)

## 6. RTK

### Documented configuration surfaces

RTK is a standalone Rust binary that filters verbose command output before it reaches an agent context.

Current documentation provides a native OpenCode integration:

```text
rtk init -g --opencode
```

The integration uses an OpenCode TypeScript plugin and the `tool.execute.before` hook to rewrite supported commands transparently.

RTK maintains local configuration in a TOML file and supports:

- exclusions for commands that should not be rewritten;
- raw-output tee files, especially on failures;
- token-saving statistics through `rtk gain`;
- prebuilt binaries, including Windows;
- verification that the installed `rtk` is the intended token-reduction project rather than another package with the same name.

### Design implications

- `portable-opencode` should call RTK's own installer and verify the resulting OpenCode plugin.
- It should not implement command filtering itself.
- The canonical configuration only needs a small local RTK configuration and exclusions.
- Full raw output on failures is important for diagnosis and should remain locally private.
- Platform behaviour, particularly Windows versus WSL, must be validated on the owner's primary environment.

### Primary sources

- [RTK repository](https://github.com/rtk-ai/rtk)
- [RTK supported agents](https://github.com/rtk-ai/rtk/blob/master/docs/guide/getting-started/supported-agents.md)
- [RTK installation guide](https://github.com/rtk-ai/rtk/blob/develop/INSTALL.md)
- [RTK hook architecture](https://github.com/rtk-ai/rtk/blob/develop/hooks/README.md)

## 7. Arize Phoenix and local observability

### Documented configuration surfaces

Phoenix is an open-source local observability collector and UI built on OpenTelemetry and OpenInference. It accepts OTLP over HTTP and supports Python and TypeScript instrumentation.

Phoenix can store and display traces, spans, latency and model/tool activity. Project routing can be set with OpenInference resource attributes or an OTLP HTTP header.

Phoenix does not itself make an uninstrumented OpenCode-to-OpenRouter request observable. `portable-opencode` still needs an instrumentation boundary, most likely:

```text
OpenCode
→ transparent local proxy or compatible instrumentation layer
→ OpenRouter
→ OTLP/OpenInference spans
→ Phoenix
```

### Design implications

- Phoenix is a backend candidate, not the proxy itself.
- The proxy must preserve streaming, tool calls, errors and OpenRouter-specific fields.
- The default trace policy should capture metadata, usage, cost and errors while redacting secrets and excluding prompt/response content.
- Observability must have explicit start, stop, health and bypass behaviour.
- The exact proxy and correlation mechanism requires a technical spike.

### Primary sources

- [Phoenix overview](https://arize.com/docs/phoenix)
- [How Phoenix tracing works](https://arize.com/docs/phoenix/tracing/concepts-tracing/how-tracing-works)
- [Phoenix OTEL setup](https://www.arize.com/docs/phoenix/tracing/how-to-tracing/setup-tracing/setup-using-phoenix-otel)

## 8. Resulting design boundaries

The research supports these boundaries:

```text
portable-opencode owns
  inspection
  planning
  safe materialization
  verification
  lifecycle state
  cross-tool coordination

OpenCode owns
  agent runtime
  rules
  agents
  commands
  skills
  tools
  permissions
  LSP
  formatters
  compaction
  user interaction

OpenRouter owns
  model and provider policy
  presets
  routing
  fallbacks
  privacy
  usage and cost

Graphify owns
  graph extraction
  graph updates
  graph files
  ignore semantics

RTK owns
  command rewriting
  output filtering
  failure tee output

Phoenix owns
  OTLP collection
  trace storage
  trace inspection
```

## 9. Required technical spikes

Documentation is sufficient to reduce the configuration matrix, but not to prove all runtime contracts.

The remaining spikes are:

1. **OpenCode lifecycle:** precedence, asset discovery, plugin stability, session metadata and permissions.
2. **OpenRouter policy:** preset reconciliation, provider options through OpenCode, fallbacks, privacy and returned metadata.
3. **Observability:** transparent proxying, streaming, redaction, correlation and Phoenix ingestion.
4. **Graphify and RTK on the primary platform:** installation, OpenCode integration, explicit updates, hooks and failure recovery.

The Ratatui spike is parked until a useful CLI exists.
