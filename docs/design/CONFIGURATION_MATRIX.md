---
type: Design Matrix
id: DESIGN-001
title: Portable OpenCode Configuration Matrix
description: Reduced personal-first Windows-native configuration contracts grounded in the canonical specification and current upstream documentation.
status: draft
created: 2026-08-04
modified: 2026-08-05
sources:
  - ../context/PROJECT.md
  - ../context/VISION.md
  - ../context/ARCHITECTURE.md
  - ../context/CONVENTIONS.md
  - ../context/OPERATIONS.md
  - ../context/DECISIONS.md
  - ../context/ROADMAP.md
  - ../SPECIFICATION.es.md
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
  - AGENT_AND_MODEL_ROLES.md
verified:
  - by: repository-owner
    status: pending
---

# Configuration matrix

## 1. Purpose

This matrix converts the complete personal-first scope into implementable contracts without duplicating configuration already owned by OpenCode, OpenRouter, Graphify, RTK or Phoenix.

It preserves installation, configuration, scripts, security, observability, project initialization, continuity, upgrades and verification while excluding speculative teams, profile catalogues, marketplaces, universal platform parity and the parked TUI.

## 2. Evidence codes

- **A** — accepted project policy;
- **D** — documented upstream surface;
- **S** — requires a runtime spike or implementation test;
- **P** — proposed personal default awaiting approval;
- **L** — intentionally later than the first complete CLI path.

Documentation establishes that a surface exists. It does not prove the Windows-native integration.

## 3. Governing boundaries

### Environment

```text
Windows native
+ PowerShell
+ Windows Terminal
- WSL
```

### OpenCode project layout

```text
<project>/
├── opencode.jsonc          # runtime configuration
├── AGENTS.md               # repository rules
└── .opencode/              # native assets only
    ├── agents/
    ├── commands/
    ├── skills/
    ├── plugins/
    ├── tools/
    └── themes/
```

`DEC-017` supersedes the unsupported `.opencode/opencode.jsonc` convention.

### Agent and model policy

```text
native primary: build, plan
native subagents: general, explore, scout
custom subagents: review, verify
semantic roles: main, reason, fast
```

`DEC-018` and `DESIGN-002` govern mappings and permissions. Exact OpenCode preset references remain spike evidence.

### Effective OpenCode provenance

```text
remote config
→ global config
→ OPENCODE_CONFIG
→ project root opencode.jsonc
→ .opencode native assets
→ OPENCODE_CONFIG_CONTENT
→ managed settings
```

`portable-opencode` manages selected canonical files and reports other active sources. It does not flatten all upstream options into a second configuration language.

---

## 4. Core configuration and lifecycle — 10

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CORE-01 | One canonical personal desired configuration; no profile catalogue | repository manifest + schemas | ownership conflicts block · A |
| CORE-02 | One optional private local override for demonstrated machine needs | private file outside Git | unsupported keys block · A |
| CORE-03 | Inspect installed versions, Windows paths, active overrides and health before mutation | filesystem, env and CLI adapters | missing required evidence blocks · A |
| CORE-04 | Produce deterministic inspectable plans before every mutation | typed plan | equivalent input produces equivalent plan · A |
| CORE-05 | Apply approved operations and back up managed files before replacement | managed-resource inventory | partial outcome recorded; ambiguity asks or blocks · A |
| CORE-06 | Second run is no-op or explained drift | current vs desired state | unexplained divergence blocks apply · A |
| CORE-07 | Environment states: absent, inspected, planned, installed, healthy, degraded, update-required, blocked | private environment state | predicates verified by doctor · A |
| CORE-08 | Project states: uninitialized, scaffolded, configuring, ready, dirty, degraded, blocked | `.portable-opencode/state.json` | ready requires gates · A |
| CORE-09 | Diagnostics expose stable code, severity, evidence, impact and remediation | diagnostic registry | JSON and human-output fixtures · A |
| CORE-10 | Version all managed config and state; migrate only known versions | JSON Schema + explicit migrations | backup first; unknown version blocks · P |

## 5. OpenCode — 15

| ID | Contract and personal default | Native/managed surface | Validation / evidence |
|---|---|---|---|
| OC-01 | Detect or install one supported Windows-native OpenCode version | official installer/package path | PowerShell smoke test · S |
| OC-02 | Manage global runtime configuration in the effective Windows home using JSONC | `~/.config/opencode/opencode.jsonc` | schema + load test · D/S |
| OC-03 | Manage project runtime configuration only at root `opencode.jsonc` | `<project>/opencode.jsonc` | root discovery and load test · A/D/S · DEC-017 |
| OC-04 | Explain native config merge and provenance instead of replacing it | remote/global/env/project/inline/managed layers | SPIKE-001 precedence fixture · D/S |
| OC-05 | Keep global rules small and project rules in root `AGENTS.md` | native rule discovery | precedence and contradiction test · D/S |
| OC-06 | Authenticate OpenRouter through `/connect` or supported private references; never write keys to Git | OpenCode auth store + provider config | credential and test-request check · D/S |
| OC-07 | Map agents to `main`, `reason` and `fast`; do not embed concrete models in prompts | root config + local preset manifest | preset representation and resolution in SPIKE-002 · A/S · DEC-018 |
| OC-08 | Preserve native `build`, `plan`, `general`, `explore`, `scout`; add only non-mutating `review` and `verify` | built-ins + `.opencode/agents/review.md` and `verify.md` | discovery, modes and permissions · A/D/S · DESIGN-002 |
| OC-09 | Create custom commands only for repeated workflows; initial `/review` and `/verify` invoke subagents as subtasks | `.opencode/commands/` | discovery and bounded execution · A/D/S |
| OC-10 | Keep a small on-demand skill set; no community catalogue | `.opencode/skills/<name>/SKILL.md` | discovery and permission test · D/S |
| OC-11 | Use plugins and tools only for RTK or verified gaps | `.opencode/plugins/`, `.opencode/tools/` | load, hook and failure tests · S |
| OC-12 | Risky operations ask or deny; `review` and `verify` deny edits; safe rules are narrow and ordered | native permissions + per-agent overrides | adversarial PowerShell and last-match fixtures · A/D/S |
| OC-13 | Enable only the selected stack's Windows-compatible LSP and formatter | native `lsp` and `formatter` config | availability and project smoke test · D/S |
| OC-14 | Use native compaction and watcher ignores; avoid self-trigger loops | native `compaction`, `watcher.ignore` | long-session and loop fixtures · D/S |
| OC-15 | Sharing disabled; project TUI settings only when needed and stored at root `tui.jsonc` | native `share` and TUI config | load and no-share check · D |

### OpenCode conflict policy

| Finding | Treatment |
|---|---|
| root `opencode.json` only | migration candidate to canonical JSONC |
| root `opencode.json` and `opencode.jsonc` | blocking ambiguity |
| `.opencode/opencode.json(c)` | misplaced unmanaged file; not runtime config |
| `OPENCODE_CONFIG` | explicit custom-file provenance |
| `OPENCODE_CONFIG_DIR` | explicit additional asset provenance |
| `OPENCODE_CONFIG_CONTENT` | explicit runtime override provenance |
| `%ProgramData%\opencode` managed settings | report highest-priority managed provenance |

## 6. OpenRouter — 8

| ID | Contract and personal default | Native/managed surface | Validation / evidence |
|---|---|---|---|
| OR-01 | One personal API key outside Git | OpenCode auth or private reference | authenticated request · D/S |
| OR-02 | Exactly three semantic roles map to presets: `main`, `reason`, `fast` with slugs `portable-main`, `portable-reason`, `portable-fast` | DESIGN-002 + local intent manifest + OpenRouter presets | exact OpenCode syntax in SPIKE-002 · A/D/S |
| OR-03 | CLI verifies and may reconcile known presets only after showing a remote diff | preset list/get/create/version APIs | ambiguity blocks mutation · D/S |
| OR-04 | Provider order/sort, fallbacks and required parameters remain OpenRouter policy | preset or request `provider` object | resolved provider fixture · D/S |
| OR-05 | Model fallback is allowed only when task semantics tolerate substitution | model arrays/preset config | tool and parameter compatibility test · D/S |
| OR-06 | Prefer ZDR and deny data collection where required; prompt/response logging off | provider and account privacy settings | doctor verifies what APIs expose · D/S |
| OR-07 | Consume usage, cost, cache and resolved-model data already returned | response fields | streaming and non-streaming fixtures · D/S |
| OR-08 | Personal spending cap is optional until actual usage establishes a useful threshold | account/key guardrail | absence does not block initial setup · P |

## 7. Local observability — 7

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| OBS-01 | OpenCode sends OpenRouter-compatible traffic through a Windows localhost proxy | provider `baseURL` + native process | transparent inference test · S |
| OBS-02 | Preserve SSE, tool calls, structured output, headers and errors unchanged | proxy contract | protocol fixture suite · S |
| OBS-03 | Record project, session, agent, command, requested/resolved model, provider, usage, cost, latency, cache, fallback and error where available | OTel/OpenInference spans | field coverage; optional gaps degrade · P/S |
| OBS-04 | Content capture off; redact keys, auth headers and secret-like values before export | proxy redaction layer | secret persistence fixtures · A/S |
| OBS-05 | Phoenix is proposed as local OTLP collector and UI, not proxy | native process or Windows-compatible container | health and ingestion test · D/S |
| OBS-06 | Correlate inference with OpenCode context when runtime metadata permits | plugin/events + span attributes | session fixture; partial correlation degrades · S |
| OBS-07 | Explicit start, stop, status, retention and bypass; bypass is degraded | CLI + local state | process, port, locked-file and cleanup tests · P/S |

## 8. Graphify — 8

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| GR-01 | Use Graphify's native Windows package and OpenCode installer | `graphifyy` + documented commands | PowerShell install/version check · D/S |
| GR-02 | Generate first graph during semantic initialization after a useful source baseline | Graphify extraction/update | source coverage and useful graph · A/S |
| GR-03 | Generate `.graphifyignore` from stack, tree and owner decisions; never copy blindly | template fragments + project file | graph quality comparison · A/S |
| GR-04 | Respect `.gitignore` merge semantics; use `--no-gitignore` only explicitly | native ignore engine | Windows path and negation fixture · D/S |
| GR-05 | Version only graph artefacts that improve continuity; keep cost/cache private | explicit output inventory | clone/rebuild and repo-noise review · P/S |
| GR-06 | Use explicit graph updates before automatic hooks | native update exposed through command/CLI | dirty-to-fresh fixture · A/S |
| GR-07 | Defer hooks until explicit updates are reliable and observable | native hook installer | loop, latency and recovery test · P/S |
| GR-08 | Record freshness and quality findings in project state | portable state + diagnostics | stale/noisy graph visible at ready gate · A/S |

## 9. RTK — 5

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| RTK-01 | Install supported native Windows binary and verify identity | official install + `rtk --version` | PowerShell executable discovery · D/S |
| RTK-02 | Use RTK's native OpenCode integration | `rtk init -g --opencode` | representative rewrite test · D/S |
| RTK-03 | Minimal private TOML with exclusions where filtering harms work | RTK config | exclusions remain untouched · D/S |
| RTK-04 | Preserve full raw output locally on failures only | failure tee | private Windows path fixture · D/S |
| RTK-05 | Doctor reports integration and `rtk gain`; savings do not gate readiness | RTK CLI queries | failure degrades optimization only · P/S |

## 10. Context and continuity — 7

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CTX-01 | Global rules stay small; project root `AGENTS.md` points to canonical context | native OpenCode rules | load and contradiction review · A/D |
| CTX-02 | Canonical context may include project, vision, architecture, conventions, operations, decisions, roadmap and concise log as needed | `docs/context/` templates | required-file and link checks · A |
| CTX-03 | Use a small repository-owned metadata schema compatible with useful OKF concepts | YAML frontmatter + schema | remove fields without operational value · P |
| CTX-04 | Create DEC, FEAT, DESIGN and SPIKE records only for durable or independently reviewable behaviour | docs conventions | link/status consistency · A |
| CTX-05 | Log meaningful transitions and next action, never full session transcripts | `docs/context/log.md` | required only for material state change · A |
| CTX-06 | `/init-project` is an agent-led OpenCode workflow completing semantic and technical baseline | native command/agent assets | fixture reaches ready only after gates · A/S |
| CTX-07 | Accepted decisions and active context override older specification or chat history | AGENTS hierarchy + state | new session recovers truth and next action · A |

## 11. Security and privacy — 6

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| SEC-01 | Credentials remain in auth stores, environment or explicit private files | native private surfaces | repository secret scan · A/D |
| SEC-02 | OpenCode permissions follow least privilege | native patterns | adversarial fixtures · A/S |
| SEC-03 | Deletion, replacement, push, external paths and remote mutation require explicit plan/approval | core plan + permissions | unapproved action cannot execute · A |
| SEC-04 | Proxy and Phoenix bind loopback unless explicitly changed | Windows process/service config | socket check; unsafe exposure blocks healthy · A/S |
| SEC-05 | Session sharing disabled and prompt/response logging off by default | OpenCode/OpenRouter/observability settings | doctor and persistence fixtures · A/S |
| SEC-06 | Back up managed files before replacement or migration and document recovery | resource inventory | restore, locked-file and path fixtures · A |

## 12. CLI, scripts and installation — 9

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| CLI-01 | Choose language and packaging after spikes; optimize native Windows install, updates and process control | decision + prototypes | clean-machine comparison · S |
| CLI-02 | Core commands are `status`, `inspect`, `plan`, `apply`, `doctor` | CLI contracts | unit/integration fixtures · A |
| CLI-03 | `install` converges the Windows machine to desired global state | adapters + plans | clean and existing-config fixtures · A |
| CLI-04 | `init-project <path>` generates root `opencode.jsonc`, root `AGENTS.md`, required `.opencode/` assets including `review` and `verify`, context and state | templates + Windows filesystem | paths-with-spaces and rerun fixtures · A · DEC-017/018 |
| CLI-05 | Add explicit observability and graph lifecycle commands only where native commands are insufficient | narrow subprocess adapters | interruption and failure tests · P |
| CLI-06 | Updates compare versions, plan migrations, back up and apply | version manifest + migrations | upgrade and rollback fixtures · P |
| CLI-07 | Use small `.ps1` scripts only for bootstrap/recovery that cannot belong to the CLI | PowerShell scripts | clean session, quoting and exit tests · A/S |
| CLI-08 | JSON output for status, plans, diagnostics and outcomes; stable failure classes | serialization contract | schema and exit-code tests · A |
| CLI-09 | Uninstall/detach remain later until managed ownership is proven | resource inventory | dry-run and preserve-user-data tests · L |

## 13. Verification and readiness — 6

| ID | Contract and personal default | Surface | Validation / evidence |
|---|---|---|---|
| VER-01 | Validate links, frontmatter, JSON/JSONC and schemas | verification scripts | active docs-only profile · A |
| VER-02 | Load root `opencode.jsonc`, discover `.opencode/` assets and exercise permissions on Windows | OpenCode fixture | invalid config blocks healthy/ready · S |
| VER-03 | Resolve `main`, `reason` and `fast` presets and returned policy metadata through OpenCode | authenticated inference | missing required role blocks healthy · S |
| VER-04 | Build a useful Graphify graph and verify RTK rewriting without losing failure detail | fixture project | Graphify blocks ready; RTK degrades · S |
| VER-05 | Ready requires context, application baseline, valid root OpenCode config, no blocking conflict, agent/role resolution, LSP/formatter, graph and verification manifest | `project doctor` | critical unresolved decision blocks · A |
| VER-06 | E2E: clean Windows → healthy environment → ready project → recoverable later session | disposable Windows environment | no WSL or hidden chat context · A/S |

## 14. Matrix result

The matrix contains **81 capabilities**, reduced from 177 without reducing canonical scope.

Resolved defaults:

```text
Windows native
root opencode.jsonc + .opencode assets
native OpenCode agents + review/verify
main/reason/fast semantic roles
```

## 15. Remaining personal defaults

1. implementation language and packaging after spikes;
2. Graphify output versioning policy;
3. minimal context metadata schema;
4. Phoenix lifecycle and retention on Windows;
5. OpenRouter preset reconciliation behaviour in the first CLI.

## 16. Approval gate

Move this document to `active` when:

- the five defaults are accepted or delegated to named evidence;
- every `S` contract maps to SPIKE-001 through SPIKE-004 or an implementation test;
- canonical global/project file trees and CLI contracts are documented;
- the repository owner confirms this is the actual personal workflow.
