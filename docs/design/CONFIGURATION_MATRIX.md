---
type: Design Matrix
id: DESIGN-001
title: Portable OpenCode Configuration Matrix
description: Reduced personal-first Windows-native configuration contracts grounded in the canonical specification and current upstream documentation.
status: draft
---

# Configuration matrix

## 1. Purpose

This matrix converts the complete personal-first scope into 81 implementable contracts without duplicating configuration owned by OpenCode, OpenRouter, Graphify, RTK or Phoenix.

It preserves installation, configuration, scripts, security, observability, project initialization, continuity, upgrades and verification while excluding speculative teams, profiles, marketplaces, universal platforms and the parked TUI.

## 2. Evidence codes

- **A** — accepted project policy;
- **D** — documented upstream surface;
- **S** — requires a runtime spike or implementation test;
- **P** — proposed evidence-gated component choice;
- **L** — intentionally later than the first complete CLI path.

All owner-level product defaults are resolved. `P` now marks a technical component decision that cannot be accepted without evidence.

## 3. Governing defaults

### Environment

```text
Windows native
PowerShell
Windows Terminal
no WSL
```

### OpenCode

```text
root opencode.jsonc
root AGENTS.md
.opencode/ native assets
```

### Agents and roles

```text
native: build, plan, general, explore, scout
custom: review, verify
roles: main, reason, fast
```

### Graphify

```text
version graph.json, GRAPH_REPORT.md, validated manifest.json
ignore HTML, cache, cost, logs and optional exports
```

### Context metadata

```text
required: type, title, description, status
conditional: id, decision, sources, resource, tags, generated
reserved without frontmatter: index.md, log.md
```

### Phoenix intended default

```text
native terminal process
isolated Python environment
loopback-only
SQLite in %LOCALAPPDATA%
30-day retention
telemetry/external resources disabled
on-demand lifecycle
```

Phoenix remains proposed until SPIKE-003 validates this shape.

### OpenRouter reconciliation

```text
local manifest
→ inspect remote
→ plan diff
→ explicit approval
→ create missing preset or new version
→ verify designated version and smoke test
```

No automatic remote deletion, rename or archival.

### Managed configuration materialization

```text
rendered or copied by default
linked only after Windows-native evidence
queried state remains externally owned
private values and state stay outside Git
mutate or remove only proven-owned resources
```

### Effective OpenCode provenance

```text
remote config
→ global config
→ OPENCODE_CONFIG
→ project opencode.jsonc
→ .opencode assets
→ OPENCODE_CONFIG_CONTENT
→ managed settings
```

---

## 4. Core configuration and lifecycle — 10

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CORE-01 | One canonical personal desired configuration; no profile catalogue | repository manifest + schemas | ownership conflicts block · A |
| CORE-02 | One optional private local override for demonstrated machine needs | private file outside Git | unsupported keys block · A |
| CORE-03 | Inspect installed versions, Windows paths, active overrides and health before mutation | filesystem, env and CLI adapters | missing required evidence blocks · A |
| CORE-04 | Produce deterministic inspectable plans before every mutation | typed plan | equivalent input produces equivalent plan · A |
| CORE-05 | Apply approved operations only to proven-owned resources and back up managed files before replacement | managed-resource inventory + DESIGN-007 | partial outcome recorded; unknown ownership blocks mutation · A |
| CORE-06 | Second run is no-op or explained drift; absence from desired state never authorizes deletion of unmanaged resources | current vs desired state | unexplained divergence or ownership ambiguity blocks apply · A |
| CORE-07 | Environment states: absent, inspected, planned, installed, healthy, degraded, update-required, blocked | private environment state | predicates verified by doctor · A |
| CORE-08 | Project states: uninitialized, scaffolded, configuring, ready, dirty, degraded, blocked | `.portable-opencode/state.json` | ready requires gates · A |
| CORE-09 | Diagnostics expose stable code, severity, evidence, impact and remediation | diagnostic registry | JSON and human-output fixtures · A |
| CORE-10 | Version all managed config/state and supported component identities; migrate only known versions | schemas + supported-version manifest + explicit migrations | backup first; unknown version blocks · A |

## 5. OpenCode — 15

| ID | Contract and personal default | Native/managed surface | Validation / evidence |
|---|---|---|---|
| OC-01 | Detect or install one supported Windows-native OpenCode version | official installer/package path | PowerShell smoke test · S |
| OC-02 | Manage global runtime configuration in the effective Windows home using JSONC | `~/.config/opencode/opencode.jsonc` | schema + load test · D/S |
| OC-03 | Manage project runtime configuration only at root `opencode.jsonc` | `<project>/opencode.jsonc` | root discovery and load test · A/D/S · DEC-017 |
| OC-04 | Explain native config merge and provenance instead of replacing it | remote/global/env/project/inline/managed layers | SPIKE-001 precedence fixture · D/S |
| OC-05 | Keep global rules small and project rules in root `AGENTS.md` | native rule discovery | precedence and contradiction test · D/S |
| OC-06 | Authenticate OpenRouter through `/connect` or supported private references; never write keys to Git | OpenCode auth store + provider config | credential and test-request check · D/S |
| OC-07 | Map agents to `main`, `reason`, `fast`; do not embed concrete models in prompts | root config + preset manifest | exact preset representation in SPIKE-002 · A/S |
| OC-08 | Preserve native agents; add only non-mutating `review` and `verify` | built-ins + `.opencode/agents/` | discovery, modes and permissions · A/D/S |
| OC-09 | Create commands only for repeated workflows; `/review` and `/verify` invoke subtasks | `.opencode/commands/` | discovery and bounded execution · A/D/S |
| OC-10 | Keep a small on-demand skill set; no catalogue | `.opencode/skills/<name>/SKILL.md` | discovery and permission test · D/S |
| OC-11 | Use plugins/tools only for RTK or verified gaps | `.opencode/plugins/`, `.opencode/tools/` | load, hook and failure tests · S |
| OC-12 | Risky operations ask/deny; `review` and `verify` deny edits | native permissions + per-agent overrides | adversarial and last-match fixtures · A/D/S |
| OC-13 | Enable only stack-relevant Windows-compatible LSP/formatter | native `lsp` and `formatter` config | availability and project smoke test · D/S |
| OC-14 | Use native compaction and watcher ignores; expose reliable context pressure and compaction events when available | native config + session metadata | long-session, parallel-session and self-loop fixtures · D/S |
| OC-15 | Sharing disabled; optional project TUI settings at root `tui.jsonc` | native config | load and no-share check · D |

### OpenCode conflicts

| Finding | Treatment |
|---|---|
| root `opencode.json` only | migration candidate |
| root JSON and JSONC | blocking ambiguity |
| `.opencode/opencode.json(c)` | misplaced unmanaged file |
| `OPENCODE_CONFIG` | custom-file provenance |
| `OPENCODE_CONFIG_DIR` | additional-asset provenance |
| `OPENCODE_CONFIG_CONTENT` | runtime override provenance |
| `%ProgramData%\opencode` | managed highest-priority provenance |

## 6. OpenRouter — 8

| ID | Contract and personal default | Native/managed surface | Validation / evidence |
|---|---|---|---|
| OR-01 | One personal API key outside Git | OpenCode auth/private reference | authenticated request · D/S |
| OR-02 | Three roles map to `portable-main`, `portable-reason`, `portable-fast` | DESIGN-002 + local intent + presets | OpenCode syntax in SPIKE-002 · A/D/S |
| OR-03 | Reconcile managed presets declaratively; create missing or new versions after approved diff; never delete automatically | `config/openrouter/presets.jsonc`, schema and preset APIs | normalized idempotent second run · A/D/S · DEC-020 |
| OR-04 | Provider routing/fallback remains OpenRouter policy | preset/request provider object | resolved-provider fixture · D/S |
| OR-05 | Model fallback only when task semantics and tools tolerate it | model arrays/preset config | compatibility tests · D/S |
| OR-06 | Prefer ZDR and deny collection where required; logging off | provider/account privacy | doctor verifies exposed state · D/S |
| OR-07 | Consume returned usage, cost, cache and resolved model | response fields | streaming/non-streaming fixtures · D/S |
| OR-08 | Spending cap optional until real usage gives a threshold | account/key guardrail | absence does not block initial setup · A |

## 7. Local observability — 7

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| OBS-01 | OpenCode uses a Windows localhost proxy for OpenRouter-compatible traffic | provider `baseURL` + native process | transparent inference test · S |
| OBS-02 | Preserve SSE, tools, structured output, headers and errors | proxy contract | protocol fixture suite · S |
| OBS-03 | Record project/session/agent/command/model/provider/usage/cost/latency/cache/fallback/error plus reliable context-limit, utilization and compaction metadata where available | OTel/OpenInference spans | field coverage; unavailable values remain explicit · A/S |
| OBS-04 | Content capture off; redact keys, auth headers and secret-like values | proxy redaction | secret persistence fixtures · A/S |
| OBS-05 | Attempt Phoenix as native isolated process with private SQLite, loopback and 30-day retention; no Docker/WSL/Postgres/service | DESIGN-005 + Phoenix env | SPIKE-003 acceptance gate · P/D/S · DEC-010 |
| OBS-06 | Correlate inference with OpenCode context where runtime metadata permits | plugin/events + attributes | session fixture · S |
| OBS-07 | Explicit start/stop/status/open/purge; on-demand lifecycle; bypass degraded | CLI + private state | PIDs, ports, retention, cleanup and locked-file tests · A/S |

## 8. Graphify — 8

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| GR-01 | Use native Windows Graphify package and OpenCode installer | official commands | PowerShell install/version · D/S |
| GR-02 | Generate first graph after useful source baseline | extraction/update | source coverage and usefulness · A/S |
| GR-03 | Generate `.graphifyignore` from stack, tree and decisions | fragments + project file | graph quality comparison · A/S |
| GR-04 | Respect `.gitignore`; `--no-gitignore` only explicitly | native ignore engine | Windows paths/negation · D/S |
| GR-05 | Version graph, report and validated portable manifest only | `.gitignore` allowlist + DESIGN-003 | clone/update/private-path/determinism · A/D/S |
| GR-06 | Explicit updates before hooks | native update via command/CLI | dirty-to-fresh fixture · A/S |
| GR-07 | Hooks deferred until explicit workflow is reliable | native hook installer | loops, latency, recovery · A/S |
| GR-08 | Record freshness and quality in state | state + diagnostics | stale/noisy graph visible · A/S |

## 9. RTK — 5

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| RTK-01 | Install supported native Windows binary and verify identity | official install + version | PowerShell discovery · D/S |
| RTK-02 | Use native OpenCode integration | `rtk init -g --opencode` | representative rewrite · D/S |
| RTK-03 | Minimal private TOML with exclusions | RTK config | excluded commands untouched · D/S |
| RTK-04 | Preserve full raw output locally on failures only | failure tee | private path fixture · D/S |
| RTK-05 | Doctor reports integration and gain; savings do not gate readiness | RTK queries | failure degrades optimization · A/S |

## 10. Context and continuity — 7

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CTX-01 | Global rules small; project `AGENTS.md` points to context | native rules | load/contradiction review · A/D |
| CTX-02 | Canonical context contains only documents needed by the project | templates | required-file/link checks · A |
| CTX-03 | Minimal frontmatter and frontmatter-free reserved files | DESIGN-004 + schema | migration and validation · A/D |
| CTX-04 | Create DEC/FEAT/DESIGN/SPIKE only for durable reviewable behaviour | conventions | link/status consistency · A |
| CTX-05 | Log meaningful transitions, never transcripts | `log.md` | reserved structure · A |
| CTX-06 | `/init-project` completes semantic/technical baseline | OpenCode command/agents | ready fixture · A/S |
| CTX-07 | Active decisions/context override old spec/chat | hierarchy + state | session recovery · A |

## 11. Security and privacy — 6

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| SEC-01 | Credentials remain private | auth/env/private files | secret scan · A/D |
| SEC-02 | OpenCode permissions use least privilege | native rules | adversarial fixtures · A/S |
| SEC-03 | Destructive/external/remote mutations require approved plan | core + permissions | unapproved action impossible · A |
| SEC-04 | Proxy/Phoenix bind loopback | process config | socket check · A/S |
| SEC-05 | Sharing/content logging off by default | native/privacy settings | doctor/persistence fixtures · A/S |
| SEC-06 | Backup managed files before replacement/migration | resource inventory | restore/locked-file fixtures · A |

## 12. CLI, scripts and installation — 9

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CLI-01 | Select language/packaging from Windows-native evidence | DEC-009/012 + prototypes | clean-machine comparison · P/S |
| CLI-02 | Core commands: status, inspect, plan, apply, doctor | CLI contracts | unit/integration fixtures · A |
| CLI-03 | `install` converges global OpenCode, OpenRouter presets, RTK, Graphify and observability | adapters + plans | clean/existing machine fixtures · A/S |
| CLI-04 | `init-project` generates canonical config/assets/context/graph policy/state | templates + Windows filesystem | spaces/rerun fixtures · A |
| CLI-05 | Add component lifecycle commands only where native commands are insufficient | narrow adapters | interruption/failure · A/S |
| CLI-06 | Updates compare supported and installed versions, plan, back up and migrate | early supported-version manifest + functions | upgrade/rollback · A/S |
| CLI-07 | Small `.ps1` bootstrap/recovery wrappers only; bootstrap establishes and invokes the CLI without duplicating lifecycle logic | PowerShell | clean session/quoting/exit/idempotence · A/S |
| CLI-08 | JSON output and stable failure classes | serialization | schema/exit-code tests · A |
| CLI-09 | Uninstall/detach later after ownership is proven | resource inventory | preserve-user-data tests · L |

## 13. Verification and readiness — 6

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| VER-01 | Validate links, metadata, reserved files, JSON/JSONC and schemas | verification scripts | pending metadata migration · A |
| VER-02 | Load OpenCode config/assets/permissions on Windows | fixture | invalid config blocks · S |
| VER-03 | Resolve/reconcile three presets and capture policy metadata through OpenCode | authenticated inference | missing role blocks · A/S |
| VER-04 | Persist useful Graphify allowlist and verify RTK | fixture | graph blocks; RTK degrades · A/S |
| VER-05 | Ready requires valid context/config/roles/LSP/graph/verification | `project doctor` | critical gaps block · A |
| VER-06 | E2E clean Windows to recoverable ready project | disposable environment | no WSL/chat context · A/S |

## 14. Matrix result

The matrix contains **81 capabilities**, reduced from 177 without reducing canonical scope.

All owner-level defaults are resolved. Remaining decisions are evidence-gated:

```text
DEC-009  implementation language
DEC-010  Phoenix backend acceptance
DEC-012  final packaging after language evidence
```

## 15. Work remaining before activation

- execute metadata migration and validation;
- instantiate DESIGN-007 as complete global/project resource manifests and ownership schemas;
- define CLI command contracts, diagnostics and scripts;
- map every `S` contract to SPIKE-001 through SPIKE-004 or an implementation test;
- execute the spikes and resolve DEC-009/010/012;
- synchronize specification v0.3;
- obtain owner approval of the resulting active matrix.
