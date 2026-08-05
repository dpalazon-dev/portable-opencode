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

This document records what selected upstream tools support and how those surfaces constrain `portable-opencode`.

It is evidence for [DESIGN-001](../design/CONFIGURATION_MATRIX.md), not a substitute for upstream documentation. Facts were reviewed against current primary sources on **2026-08-05**.

## 2. Research rule

For each desired capability:

1. use the upstream native surface when sufficient;
2. configure it through its documented file, command or API;
3. wrap only missing lifecycle, validation or coordination behaviour;
4. create a spike when documentation does not prove runtime integration;
5. never promote an inference into an accepted path without verification.

## 3. OpenCode

### Documented runtime configuration

OpenCode supports JSON and JSONC and publishes a JSON Schema.

The relevant standard locations are:

```text
Global runtime config
~/.config/opencode/opencode.json(c)

Project runtime config
<project>/opencode.json(c)

Project TUI config
<project>/tui.json(c)
```

OpenCode searches for project configuration from the current directory upward to the nearest Git worktree. Configuration sources are merged rather than replaced; later sources override only conflicting keys.

The documented order includes:

```text
remote organizational config
→ global config
→ OPENCODE_CONFIG custom file
→ project root opencode.json(c)
→ .opencode asset directories
→ OPENCODE_CONFIG_CONTENT
→ managed settings
```

On Windows, file-based managed settings may exist under `%ProgramData%\opencode`.

### Documented project assets

`.opencode/` is the native project asset directory. Documented plural subdirectories include:

```text
.opencode/agents/
.opencode/commands/
.opencode/modes/
.opencode/plugins/
.opencode/skills/
.opencode/tools/
.opencode/themes/
```

OpenCode also discovers root `AGENTS.md` rules. Skills are loaded on demand from `.opencode/skills/<name>/SKILL.md`.

`OPENCODE_CONFIG_DIR` adds a directory searched like `.opencode/` for assets. It does not redefine the standard project runtime config file.

### Other relevant native capabilities

- provider and model definitions;
- environment and file substitution;
- primary agents and subagents;
- custom commands and skills;
- `allow`, `ask` and `deny` permissions;
- per-agent overrides;
- LSP and formatter configuration;
- compaction and watcher ignores;
- plugins and custom tools;
- separate TUI preferences;
- session sharing policy;
- explicit shell selection such as `"shell": "pwsh"`.

Credentials added through `/connect` are stored locally by OpenCode rather than in project configuration.

### Correction recorded on 2026-08-05

An earlier version of this note incorrectly stated that `.opencode/opencode.json(c)` was a documented project runtime configuration location. It is not. That inference confused the asset directory with the runtime config file.

The corrected design is:

```text
<project>/opencode.jsonc       runtime configuration
<project>/AGENTS.md            repository rules
<project>/.opencode/...        native assets
```

### Design implications

- generate native OpenCode files rather than a parallel format;
- use root `opencode.jsonc` as the canonical project runtime config;
- use `.opencode/` only for documented native assets;
- report active environment and managed overrides in configuration provenance;
- limit plugins to verified gaps because plugin behaviour can change;
- keep OpenCode TUI preferences separate from the deferred portable TUI.

### Primary sources

- [OpenCode configuration](https://opencode.ai/docs/config/)
- [OpenCode rules](https://opencode.ai/docs/rules/)
- [OpenCode providers](https://opencode.ai/docs/providers/)
- [OpenCode agents](https://opencode.ai/docs/agents/)
- [OpenCode permissions](https://opencode.ai/docs/permissions/)
- [OpenCode commands](https://opencode.ai/docs/commands/)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [OpenCode custom tools](https://opencode.ai/docs/custom-tools/)
- [OpenCode plugins](https://opencode.ai/docs/plugins/)

## 4. OpenRouter

### Documented surfaces

OpenRouter supports request-level provider routing through the `provider` object, including order or sorting, provider fallbacks, parameter compatibility, data-collection restrictions and Zero Data Retention routing.

Presets are named and versioned remote configurations. They may encapsulate:

- model selection and model fallbacks;
- provider routing;
- system prompts;
- generation parameters;
- provider inclusion and exclusion.

Presets can be referenced directly as:

```text
@preset/<slug>
```

They can also be combined with a model or supplied through a preset field. Current API endpoints support listing, retrieving, creating or versioning presets from known-good inference request bodies.

Usage accounting is returned in responses, including streaming responses, and can expose token, cost, reasoning and cache data.

### Design implications

- semantic roles are a portable-opencode abstraction that can map to OpenRouter presets;
- the local repository should describe expected preset intent and remote identity;
- routing and privacy remain OpenRouter policy;
- usage capture should consume response fields already returned;
- the exact syntax accepted by OpenCode for preset references is not documented sufficiently and remains `SPIKE-002` work;
- session affinity must not be assumed without evidence.

### Primary sources

- [OpenRouter presets](https://openrouter.ai/docs/guides/features/presets)
- [OpenRouter preset API](https://openrouter.ai/docs/api/api-reference/presets/list-presets)
- [OpenRouter provider routing](https://openrouter.ai/docs/guides/routing/provider-selection)
- [OpenRouter model fallbacks](https://openrouter.ai/docs/guides/routing/model-fallbacks)
- [OpenRouter usage accounting](https://openrouter.ai/docs/cookbook/administration/usage-accounting)
- [OpenRouter privacy](https://openrouter.ai/docs/guides/privacy/data-collection)

## 5. Graphify

Graphify is distributed through the `graphifyy` Python package and documents OpenCode-specific installation, graph extraction and updates, optional hooks and `.graphifyignore`.

`.graphifyignore` uses gitignore-style syntax and acts as an additional exclusion layer over `.gitignore`. Files already excluded by `.gitignore` are not reintroduced unless `--no-gitignore` is used explicitly.

### Design implications

- call and verify native installation rather than reimplementing it;
- generate `.graphifyignore` from stack, repository structure and owner decisions;
- make the first graph and quality audit part of semantic project initialization;
- establish explicit updates before automatic hooks;
- record graph freshness and quality in portable state.

### Primary sources

- [Graphify repository](https://github.com/safishamsi/graphify)
- [Graphify documentation](https://github.com/Graphify-Labs/graphify/blob/v8/docs/translations/README.es-ES.md)
- [graphifyy package](https://pypi.org/project/graphifyy/)

## 6. RTK

RTK is a standalone Rust binary that reduces verbose command output before it reaches agent context.

Its native OpenCode integration is installed with:

```text
rtk init -g --opencode
```

It uses an OpenCode TypeScript plugin and `tool.execute.before` to rewrite supported commands. RTK also supports local TOML configuration, command exclusions, raw-output tee files and `rtk gain` statistics. Windows binaries are documented.

### Design implications

- invoke and verify RTK's native integration;
- do not implement a competing command-filtering layer;
- keep raw failure output locally private;
- validate Windows-native installation and command rewriting in `SPIKE-004`.

### Primary sources

- [RTK repository](https://github.com/rtk-ai/rtk)
- [RTK supported agents](https://github.com/rtk-ai/rtk/blob/master/docs/guide/getting-started/supported-agents.md)
- [RTK installation](https://github.com/rtk-ai/rtk/blob/develop/INSTALL.md)

## 7. Phoenix and observability

Phoenix is an open-source OpenTelemetry/OpenInference collector and UI. It accepts OTLP and can store and display traces, spans, latency and model/tool activity.

Phoenix does not automatically observe an uninstrumented OpenCode-to-OpenRouter request. A separate instrumentation boundary remains necessary:

```text
OpenCode
→ transparent localhost proxy or compatible instrumentation
→ OpenRouter
→ OTLP/OpenInference spans
→ Phoenix
```

### Design implications

- Phoenix is a backend candidate, not the proxy;
- the proxy must preserve streaming, tool calls, errors and OpenRouter fields;
- default capture remains metadata-only with redaction;
- lifecycle, retention and Windows-native viability require `SPIKE-003`.

### Primary sources

- [Phoenix overview](https://arize.com/docs/phoenix)
- [Phoenix tracing](https://arize.com/docs/phoenix/tracing/concepts-tracing/how-tracing-works)
- [Phoenix OTEL setup](https://www.arize.com/docs/phoenix/tracing/how-to-tracing/setup-tracing/setup-using-phoenix-otel)

## 8. Resulting ownership

```text
portable-opencode
  inspect · plan · apply · verify · state · coordinate

OpenCode
  runtime config · rules · agents · commands · skills · tools
  permissions · LSP · formatters · compaction · interaction

OpenRouter
  models · providers · presets · routing · fallbacks · privacy · usage

Graphify
  graph extraction · updates · graph files · ignore semantics

RTK
  command rewriting · output filtering · failure tee output

Phoenix
  OTLP collection · trace storage · trace inspection
```

## 9. Required spikes

1. **OpenCode lifecycle:** root config discovery, precedence, native asset discovery, environment overrides, managed Windows settings, plugin stability, permissions and session metadata.
2. **OpenRouter policy:** exact preset representation through OpenCode, reconciliation, provider options, fallbacks, privacy and returned metadata.
3. **Observability:** transparent proxying, streaming, redaction, correlation and Phoenix ingestion.
4. **Graphify and RTK:** Windows-native installation, OpenCode integration, explicit updates, hooks and recovery.

The Ratatui spike remains parked.
