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
verified:
  - by: repository-owner
    status: pending
---

# Configuration matrix

## 1. Purpose

This matrix converts the complete personal-first scope into implementable configuration contracts.

It deliberately removes:

- duplicate rows that described the same lifecycle concept at several layers;
- team, organization and marketplace concerns;
- a generic profile system;
- the parked Ratatui interface;
- speculative adapters for alternatives not used by the canonical path;
- configuration options already owned natively by an upstream tool.

It preserves the full canonical scope: installation, OpenCode, OpenRouter, observability, Graphify, RTK, project initialization, security, continuity, scripts, upgrades and verification.

## 2. Reading the matrix

### Scope

- **versioned** — maintained in this repository or a generated project;
- **private** — local data that must not enter Git;
- **remote** — OpenRouter account or preset state;
- **generated** — derived environment or project state;
- **external** — behaviour owned by an upstream tool.

### Evidence codes

- **A** — accepted repository policy;
- **D** — documented upstream surface;
- **S** — runtime behaviour still requires a spike or implementation test;
- **P** — proposed personal default awaiting owner approval;
- **L** — intentionally later than the first complete CLI path.

A row may contain multiple codes. Documentation proves that a surface exists; it does not prove integration behaviour on the supported environment.

## 3. Configuration precedence

`portable-opencode` does not replace upstream precedence. It coordinates four boundaries:

```text
versioned canonical configuration
→ generated global or project files
→ documented upstream merge and runtime behaviour
→ optional private local override
```

The CLI must explain effective ownership without flattening every OpenCode or OpenRouter option into a new portable abstraction.

### Primary environment

`DEC-015` fixes the first supported environment as **Windows native**, using PowerShell and Windows Terminal without WSL.

Consequences for every matrix row:

- a required dependency must have a native Windows installation and runtime path;
- PowerShell is the only required bootstrap and recovery shell;
- Windows filesystem paths, quoting, subprocesses, ports, process cleanup and locked files are first-class validation concerns;
- successful Linux, macOS or WSL behaviour does not validate the MVP path;
- unsupported Unix-only assumptions block the affected capability until resolved.

### Canonical OpenCode project configuration

`DEC-016` fixes the project-level OpenCode configuration at:

```text
<project>/.opencode/opencode.jsonc
```

The canonical workflow does not generate or manage root-level `opencode.json` or `opencode.jsonc` files. Their presence is treated as a conflict or migration finding because portable-opencode must not depend on an accidental merge between two project configuration forms.

The root `AGENTS.md` remains outside `.opencode/` as the repository-level operating entry point.

## Core configuration and lifecycle

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| CORE-01 | Canonical desired configuration | portable core / versioned | one personal configuration; no profile catalogue | repository-owned manifest and schemas | schema-valid; conflicting ownership blocks | Phase 0-2 · A |
| CORE-02 | Local override | portable core / private | single optional local override for real machine-specific needs | private file outside Git | must not contain unsupported keys; invalid override blocks | Phase 0-2 · A |
| CORE-03 | Environment inspection | portable core / generated | detect installed versions, Windows paths and health before change | external CLI and filesystem adapters | missing evidence becomes finding; required prerequisite blocks | Phase 2 · A |
| CORE-04 | Deterministic plan and explain | portable core / generated | all mutation is preceded by an inspectable plan | typed plan derived from desired and current state | same inputs produce equivalent plan; unresolved decision blocks | Phase 2 · A |
| CORE-05 | Apply and managed backups | portable core / local | apply approved operations and back up replaced managed files | managed-resource inventory + Windows filesystem adapters | partial outcome recorded; irreversible ambiguity asks or blocks | Phase 2 · A |
| CORE-06 | Idempotence and drift | portable core / generated | second run is no-op or reports explainable drift | plan comparison against current state | unexpected divergence blocks apply | Phase 2 · A |
| CORE-07 | Environment lifecycle state | portable core / local | absent, inspected, planned, installed, healthy, degraded, update-required, blocked | private machine state | state predicates verified by doctor | Phase 2-3 · A |
| CORE-08 | Project lifecycle state | portable core / project | uninitialized, scaffolded, configuring, ready, dirty, degraded, blocked | project `.portable-opencode/state.json` | ready cannot be set without gates | Phase 2-4 · A |
| CORE-09 | Structured diagnostics | portable core / generated | stable code, severity, evidence, impact and remediation | diagnostic registry | doctor output test; unsafe state blocks | Phase 2 · A |
| CORE-10 | Schema version and migration | portable core / versioned + local | version all managed config/state; migrate only known versions | JSON Schema and explicit migration functions | backup before migration; unknown version blocks | Phase 2,5 · P |

## OpenCode

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| OC-01 | Installation and supported version | OpenCode / external | detect or install one supported Windows-native version | documented native Windows installer/package methods | version and executable smoke check from PowerShell; unsupported or WSL-only path blocks | Phase 1,3 · S |
| OC-02 | Global runtime configuration | OpenCode / global | manage `~/.config/opencode/opencode.jsonc` using the effective Windows home | native JSONC config + schema | schema and OpenCode load test | Phase 0,3 · D/S |
| OC-03 | Project runtime configuration | OpenCode / project | manage only `<project>/.opencode/opencode.jsonc` | native `.opencode/opencode.jsonc` project config | SPIKE-001 validates discovery and merge on Windows; root config presence becomes conflict or migration finding | Phase 1,4 · A/S · DEC-016 |
| OC-04 | Configuration precedence | OpenCode / native | reuse documented merge order while preventing dual managed project forms | global config, `.opencode/opencode.jsonc` and runtime override surfaces | SPIKE-001 confirms effective behaviour on the supported Windows version | Phase 1 · D/S |
| OC-05 | Global and project rules | OpenCode / global + project | small global `AGENTS.md`; project-specific root `AGENTS.md` | native rule discovery and precedence | load and contradiction check | Phase 1,3-4 · D/S |
| OC-06 | OpenRouter provider and credentials | OpenCode / local + global | authenticate through `/connect`; never write key to repo | OpenCode auth store and `provider.openrouter` config | credential-presence and test-request check | Phase 1,3 · D/S |
| OC-07 | Model and preset references | OpenCode / global | agents reference stable OpenRouter preset/model identifiers | native provider model definitions and model options | all configured references resolve | Phase 1,3 · D/S |
| OC-08 | Primary agents | OpenCode / global + project | minimal set justified by real workflow: build, explore, review, verify; retain native plan | native JSON or Markdown agents | discovery, permissions and invocation smoke tests | Phase 0-4 · P/S |
| OC-09 | Custom commands | OpenCode / global + project | only repeated workflows with explicit contracts | native command Markdown or config | discovery and bounded fixture execution | Phase 0,3-5 · D/S |
| OC-10 | Skills | OpenCode / global + project | small on-demand set; no community catalogue | native `skills/<name>/SKILL.md` discovery | discovery and permission test | Phase 0,3-4 · D/S |
| OC-11 | Plugins and custom tools | OpenCode / global + project | only RTK and proven portable gaps; V2-dependent behaviour remains spiked | native plugin/tool directories or packages | load, hook and failure tests; beta API cannot be assumed | Phase 1,3-5 · S |
| OC-12 | Permission policy | OpenCode / global + agent | default ask/deny for risky operations; narrow allow rules; per-agent tightening | native `permission` rules and pattern order | adversarial PowerShell and command fixtures; weakening canonical deny blocks | Phase 0-4 · D/S |
| OC-13 | LSP and formatter | OpenCode / project | enable only the selected stack's existing canonical Windows-compatible tools | native `lsp` and `formatter` config | server/formatter availability and project smoke check | Phase 1,4 · D/S |
| OC-14 | Compaction and watcher | OpenCode / global + project | automatic compaction with explicit reserve; ignore generated and noisy paths | native `compaction` and `watcher.ignore` | long-session and self-trigger-loop fixtures | Phase 1,3-5 · D/S |
| OC-15 | Sharing and OpenCode TUI preferences | OpenCode / global local | session sharing disabled; minimal owner TUI preferences only | native `share` and `tui.jsonc` | config load; no remote share by default | Phase 3 · D |

## OpenRouter

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| OR-01 | Authentication | OpenRouter / private | one personal API key managed outside Git | OpenCode auth flow or environment/file reference | authenticated metadata or inference request; missing key blocks | Phase 1,3 · D/S |
| OR-02 | Semantic roles through presets | OpenRouter / remote + versioned manifest | small role set backed by named presets | `@preset/<slug>` and preset API | preset exists and active version matches expected policy | Phase 0-3 · D/S |
| OR-03 | Preset reconciliation | portable OpenRouter adapter | verify and optionally create/update known presets from local manifest | OpenRouter preset list/get/create/version APIs | diff shown before remote mutation; ambiguity blocks | Phase 1-3 · D/S |
| OR-04 | Provider routing and fallback | OpenRouter / remote request policy | explicit personal defaults for order/sort, fallbacks and required parameters | request/provider object or preset config | test request records resolved provider and fallback behaviour | Phase 1,3 · D/S |
| OR-05 | Model fallbacks and compatibility | OpenRouter / preset | fallback only where task semantics tolerate substitution | model arrays/fallbacks + `require_parameters` | tool-calling and parameter fixture tests | Phase 1,3 · D/S |
| OR-06 | Privacy policy | OpenRouter / preset + account | deny data collection where required; prefer ZDR; prompt/response logging off | provider `data_collection`, `zdr`, account privacy settings | doctor verifies request policy where API permits; unverifiable account state warns | Phase 1,3 · D/S |
| OR-07 | Usage, cost and resolved model | OpenRouter / response | consume usage already returned in every response | response `usage` and resolved `model` fields | streaming and non-streaming capture fixtures | Phase 1,3-5 · D/S |
| OR-08 | Personal budget guardrail | OpenRouter / remote | optional personal spending cap after actual usage baseline | account/key guardrail where available | doctor reports configured limit; absence does not block first setup | Phase 3-5 · P |

## Local observability

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| OBS-01 | Transparent proxy boundary | portable observability / local | OpenCode sends OpenRouter-compatible traffic through a Windows localhost proxy | OpenCode provider `baseURL` + native local process | SPIKE-003 proves request/response transparency | Phase 1,3 · S |
| OBS-02 | Streaming, tools and errors | portable observability / local | preserve SSE, tool calls, structured outputs, headers and errors unchanged | proxy pass-through contract | protocol fixture suite; corruption blocks proxy use | Phase 1,3 · S |
| OBS-03 | Metadata event schema | portable observability / local | project, session, agent, command, requested/resolved model, provider, usage, cost, latency, cache, fallback and error | OpenInference/OTel spans + OpenRouter response data | required-field coverage; missing optional fields degrade | Phase 0-3 · P/S |
| OBS-04 | Privacy and redaction | portable observability / local | content capture off; redact keys, auth headers and secret-like values before export | proxy redaction layer and Phoenix/OpenInference attributes | secret fixtures must never persist | Phase 1,3 · A/S |
| OBS-05 | Phoenix local backend | Phoenix / local | run collector and UI on Windows without WSL; native process or Windows-compatible container choice remains open | Phoenix lifecycle + OTLP/OpenInference exporter | health, process cleanup and trace-ingestion check | Phase 1,3 · D/S |
| OBS-06 | Trace correlation | portable observability + OpenCode | correlate inference with project, session, agent and command when available | OpenCode metadata/plugin events + propagated attributes | single-session trace fixture; partial correlation degrades | Phase 1,3 · S |
| OBS-07 | Lifecycle, retention and bypass | portable CLI / local | explicit start, stop, status and bounded retention; direct OpenRouter bypass is degraded | CLI commands, Windows local config and state | health, cleanup, locked-file and bypass-state tests | Phase 1,3-5 · P/S |

## Graphify

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| GR-01 | Installation and OpenCode integration | Graphify / external + global | use Graphify's native Windows package and documented OpenCode installer | `graphifyy`, `graphify install --platform opencode`, `graphify opencode install` | PowerShell installation, version, executable discovery and guidance check | Phase 1,3 · D/S |
| GR-02 | First project graph | Graphify / project | generate during semantic project initialization after source baseline exists | Graphify extraction/update command | graph exists and covers intended source set | Phase 1,4 · A/S |
| GR-03 | Generated `.graphifyignore` | portable Graphify adapter / project | derive from stack, repo tree and owner decisions; never copy blindly | versioned template fragments + generated project file | ignore audit and graph-size/quality comparison | Phase 0,4 · A/S |
| GR-04 | `.gitignore` interaction | Graphify / native | respect documented merge semantics; use `--no-gitignore` only explicitly | Graphify ignore engine | fixture confirms exclusions, negation and Windows path behaviour | Phase 1,4 · D/S |
| GR-05 | Graph output ownership | project policy | version only graph artefacts that improve personal continuity; keep cost/cache private | explicit output inventory | clone/rebuild comparison and repository-noise review | Phase 0-1 · P/S |
| GR-06 | Explicit update workflow | Graphify / project | manual/command update before automatic hooks | Graphify update command exposed through OpenCode/CLI | source change marks dirty; update returns fresh | Phase 1,4-5 · A/S |
| GR-07 | Hook automation | Graphify / project | deferred until explicit updates are stable and observable | `graphify hook install` | no loops, acceptable latency and reliable recovery on Windows | Phase 5 · P/S |
| GR-08 | Freshness and quality audit | portable state + Graphify | record last graph update, dirty state and quality findings | project state + Graphify diagnostics | stale graph visible; noisy graph cannot silently pass ready gate | Phase 4-5 · A/S |

## RTK

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| RTK-01 | Installation and identity verification | RTK / external local | install the supported native Windows binary and verify it is `rtk-ai/rtk` | official Windows install path, `rtk --version`, `rtk gain` | PowerShell installation and executable discovery; wrong package or missing command blocks activation | Phase 1,3 · D/S |
| RTK-02 | OpenCode integration | RTK / global | use RTK's native OpenCode integration | `rtk init -g --opencode` TypeScript plugin | plugin installed and representative commands rewritten on Windows | Phase 1,3 · D/S |
| RTK-03 | Local configuration and exclusions | RTK / private | minimal TOML config; exclude commands where filtered output harms task | RTK config file and rewrite registry | excluded commands remain untouched | Phase 1,3 · D/S |
| RTK-04 | Failure tee output | RTK / private local | retain full raw output on failures only | RTK tee configuration | failing test exposes private Windows full-output path | Phase 1,3 · D/S |
| RTK-05 | Health and savings | portable doctor + RTK | report plugin status, rewrite health and `rtk gain` without making savings a readiness gate | RTK CLI queries | doctor fixture; failure degrades terminal optimization only | Phase 3-5 · P/S |

## Context and continuity

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| CTX-01 | Repository and project `AGENTS.md` | OpenCode rules / versioned | global rules remain small; project rules point to canonical context | native `AGENTS.md` files | load and contradiction review | Phase 0,3-4 · A |
| CTX-02 | Canonical context set | project / versioned | PROJECT, VISION, ARCHITECTURE, CONVENTIONS, OPERATIONS, DECISIONS, ROADMAP and concise log as needed | Markdown templates under `docs/context/` | required-file and link validation | Phase 0,4 · A |
| CTX-03 | Minimal metadata schema | project docs / versioned | small repository-owned subset compatible with useful OKF concepts | YAML frontmatter + schema | schema validation; unsupported bureaucracy removed | Phase 0,4 · P |
| CTX-04 | Decision, feature and design records | project / versioned | create only for durable choices or independently reviewable behaviour | `DEC-*`, `FEAT-*`, `DESIGN-*` conventions | cross-link and status consistency | Phase 0-5 · A |
| CTX-05 | Concise log and handoff | project / versioned | record meaningful transitions and next action, not session transcripts | `docs/context/log.md` and handoff workflow | entry required only when state materially changes | Phase 0,5 · A |
| CTX-06 | Semantic `/init-project` workflow | OpenCode / project | agent-led interview completes context and technical baseline | native OpenCode command/agent assets | fixture reaches ready only after gates | Phase 4 · A/S |
| CTX-07 | Source hierarchy and recovery | project / versioned + state | accepted decisions and current context override older specification or history | AGENTS hierarchy + machine state | new session can identify current truth and next action | Phase 0,4-5 · A |

## Security and privacy

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| SEC-01 | Secret ownership | all components / private | credentials remain in OpenCode auth store, env or explicit private files | native auth stores and secret references | secret scan; repository value blocks verification | Phase 0-6 · A/D |
| SEC-02 | Least-privilege OpenCode permissions | OpenCode / global + agent | risky actions ask or deny; narrow safe reads and commands allowed | native permission patterns | adversarial PowerShell and executable fixture suite | Phase 0-4 · A/S |
| SEC-03 | Destructive and external operations | portable core + OpenCode | explicit plan and approval for deletion, replacement, push, external directories and remote mutation | plan approval + OpenCode permissions | unapproved action must not execute | Phase 2-6 · A |
| SEC-04 | Local service exposure | observability / local | proxy and Phoenix bind loopback unless explicitly changed | Windows service/process configuration | socket/bind check; unsafe exposure blocks healthy | Phase 1,3 · A/S |
| SEC-05 | Sharing and trace content | OpenCode/OpenRouter/observability | OpenCode sharing disabled; remote and local prompt/response logging off | native share/privacy settings + redaction | doctor and persistence fixtures | Phase 1,3 · A/S |
| SEC-06 | Backup and recovery | portable core / private | backup managed files before replacement or migration; document recovery | managed-resource inventory | restore fixture including locked-file and path cases | Phase 2-6 · A |

## CLI, scripts and installation

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| CLI-01 | Implementation language and packaging | repository | choose after spikes; optimize for Windows-native installation, updates and process control | decision + prototype evidence | Windows build, startup, packaging and clean-machine comparison | Phase 1-2 · S |
| CLI-02 | Core control commands | portable CLI | `status`, `inspect`, `plan`, `apply`, `doctor` | CLI command contracts and structured output | unit/integration command fixtures | Phase 0-2 · A |
| CLI-03 | Global installation | portable CLI | `install` converges the personal Windows machine to canonical desired state | core plans + OpenCode/OpenRouter/Graphify/RTK/observability adapters | clean and existing-config Windows fixtures | Phase 3 · A |
| CLI-04 | Project bootstrap | portable CLI | `init-project <path>` creates `.opencode/opencode.jsonc`, deterministic assets and project state | templates, stack detection and Windows filesystem adapters | empty-project fixture, spaces-in-path fixture, root-config conflict fixture and rerun | Phase 4 · A · DEC-016 |
| CLI-05 | Component lifecycle | portable CLI | explicit observability and graph lifecycle commands where native tools are insufficient | narrow Windows subprocess adapters | health, interruption and failure tests | Phase 3-5 · P |
| CLI-06 | Update and migration | portable CLI | compare installed and target versions, plan migration, back up and apply | version manifest + migration functions | upgrade, locked-file and rollback fixtures | Phase 5-6 · P |
| CLI-07 | Primary-platform scripts | scripts / local | small PowerShell scripts only where bootstrap or recovery cannot be handled by the main CLI; no Bash or WSL requirement | versioned `.ps1` scripts with strict error handling | clean PowerShell session, path-with-spaces and non-zero exit smoke tests | Phase 0-3 · A/S · DEC-015 |
| CLI-08 | Machine-readable output and exit codes | portable CLI | JSON for status, plans, diagnostics and outcomes; stable non-zero failure classes | CLI serialization contract | schema and PowerShell exit-code tests | Phase 0-2 · A |
| CLI-09 | Uninstall and detach | portable CLI | defer until ownership inventory and install path are stable | managed-resource inventory | dry-run and preserve-user-data tests | Later · L |

## Verification and readiness

| ID | Capability | Owner / scope | Canonical personal default | Native or managed surface | Validation and failure | Delivery / evidence |
|---|---|---|---|---|---|---|
| VER-01 | Documentation and schema checks | repository/project | links, frontmatter, JSON/JSONC and state schemas | verification scripts | current docs-only profile must pass | Phase 0-6 · A |
| VER-02 | OpenCode configuration smoke test | OpenCode | load global configuration plus `.opencode/opencode.jsonc`, discover assets and exercise permission fixtures on Windows | OpenCode CLI/TUI test project | invalid load or unresolved root-config conflict blocks healthy/ready | Phase 1,3-4 · S · DEC-016 |
| VER-03 | OpenRouter policy smoke test | OpenRouter | resolve required presets, routing, privacy and usage fields from Windows OpenCode | authenticated test inference | missing required policy blocks global healthy | Phase 1,3 · S |
| VER-04 | Graphify and RTK smoke test | Graphify/RTK | build useful graph and verify command rewriting without losing failure detail on Windows | fixture project and representative PowerShell-invoked commands | Graphify failure blocks project ready; RTK failure degrades | Phase 1,3-4 · S |
| VER-05 | Project ready gate | portable project state | context, app baseline, canonical OpenCode config, LSP/formatter, graph and verification manifest pass | `project doctor` and canonical checks | critical unresolved decision or conflicting root OpenCode config blocks ready | Phase 4 · A |
| VER-06 | Canonical end-to-end path | repository | clean supported Windows machine to healthy environment to ready project to recoverable later session, without WSL | disposable Windows environment and fixture repo | must be reproducible without hidden conversation context | Phase 6 · A/S · DEC-015 |

## 4. Matrix result

The reduced matrix contains **81 capabilities**, down from 177.

The reduction does not remove canonical scope. It removes duplicate concepts and speculative productization, while binding each remaining capability to:

- one owner;
- one real configuration or lifecycle surface;
- one personal default;
- one validation rule;
- one roadmap position.

Two personal defaults are now accepted:

- Windows native, PowerShell and Windows Terminal, without WSL;
- `<project>/.opencode/opencode.jsonc` as the only managed project OpenCode configuration.

## 5. Decisions required before approval

Owner review should resolve these remaining product defaults:

1. implementation language and packaging approach after the spikes;
2. initial semantic roles and required agents;
3. which Graphify outputs are versioned;
4. minimal metadata schema for context documents;
5. Phoenix retention and native Windows process/container choice;
6. whether OpenRouter presets are created automatically or only verified in the first CLI release.

Everything else is either accepted policy, documented upstream surface or bounded spike work.

## 6. Approval gate

Move this document from `draft` to `active` when:

- the six defaults above are accepted or delegated to a named spike;
- every `S` row is linked to SPIKE-001 through SPIKE-004 or an implementation test;
- the canonical file tree and CLI contract are documented;
- the repository owner confirms that the matrix represents the actual personal workflow.
