---
type: Design Matrix
id: DESIGN-001
title: Portable OpenCode Configuration Matrix
description: Implementable ownership, defaults, overrides, validation and failure policies for the portable-opencode MVP.
status: draft
created: 2026-08-04
modified: 2026-08-04
sources:
  - ../context/PROJECT.md
  - ../context/VISION.md
  - ../context/ARCHITECTURE.md
  - ../context/CONVENTIONS.md
  - ../context/OPERATIONS.md
  - ../context/DECISIONS.md
  - ../context/ROADMAP.md
  - ../SPECIFICATION.es.md
  - ../features/CONFIGURATION_TUI.md
verified:
  - by: repository-owner
    status: pending
---

# Configuration matrix

## 1. Purpose

This document translates the product specification into implementable configuration contracts.

It answers, for every relevant capability:

- which component owns the behaviour;
- where its source of truth lives;
- whether it is global, project-specific, private or remote;
- which default the canonical profile proposes;
- how the user may override it;
- whether the value is copied, generated, linked, queried or derived;
- how the system validates it;
- whether failure blocks the workflow or produces a degraded state;
- how the capability is exposed through the CLI and future TUI;
- whether it belongs to the MVP;
- which decision or technical spike must validate it.

This is a **design matrix**, not proof that a capability is already implemented or supported by an upstream product.

## 2. Status vocabulary

| Code | Meaning |
|---|---|
| `A` | Accepted project decision or policy. |
| `P` | Proposed default requiring owner review or technical evidence. |
| `V` | Validated by a reproducible spike or implementation test. |
| `U` | Unknown; implementation must not assume the answer. |
| `D` | Deferred beyond the first MVP. |
| `X` | Explicitly excluded from the first MVP. |

A capability may be `A` at product-policy level while still requiring a spike to validate its technical mechanism.

## 3. Scope vocabulary

| Code | Meaning |
|---|---|
| `G` | Global versioned configuration distributed by this repository. |
| `P` | Project-versioned configuration generated into a target repository. |
| `L` | Private local configuration or state that must not enter Git. |
| `R` | Remote state controlled through OpenRouter or another service. |
| `S` | Generated lifecycle state derived from the environment or project. |
| `E` | External dependency or upstream capability. |

Multiple codes may apply, for example `G+P` or `L+R`.

## 4. Materialization vocabulary

| Value | Meaning |
|---|---|
| `static` | Maintained directly in this repository. |
| `template` | Rendered into a target location from a versioned template. |
| `generated` | Produced from detected state, profile and user decisions. |
| `linked` | Linked to a versioned source when the platform supports it safely. |
| `queried` | Read from an external API, CLI or runtime. |
| `derived` | Calculated from other sources and stored as state. |
| `private` | Created locally and deliberately excluded from version control. |

## 5. Failure vocabulary

| Value | Meaning |
|---|---|
| `block` | The operation cannot safely continue. |
| `degrade` | Continue with an explicit degraded state and remediation. |
| `warn` | Continue while reporting a non-critical inconsistency. |
| `ask` | Require an explicit semantic or risky user decision. |
| `skip` | Omit an optional capability without changing core readiness. |

## 6. Canonical configuration precedence

The proposed precedence model is:

```text
accepted repository policy
    ↓
selected portable profile
    ↓
global generated configuration
    ↓
project generated configuration
    ↓
private local override
    ↓
explicit current-operation input
```

Upstream OpenCode and OpenRouter precedence must be verified by `SPIKE-001` and `SPIKE-002`. The portable engine must explain the effective provenance of a value rather than silently flattening all layers.

---

# 7. Core lifecycle and configuration engine

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| CORE-001 | Configuration layer model | portable core / `G+P+L+R` | this matrix + schemas | explicit global, project, private and remote layers | profile and local override | static + derived | schema and provenance check; `block` on ambiguous ownership | `doctor`, `explain`; TUI provenance view | MVP · `A` · DEC-006 |
| CORE-002 | Named profiles | portable core / `G` | versioned profile manifests | `canonical` profile plus privacy variants | `--profile`, TUI selector | static | profile schema; `block` if missing or incompatible | install/init CLI; TUI profile selector | MVP · `P` · Phase 1 |
| CORE-003 | Effective configuration plan | application engine / `S` | resolved inputs and adapters | produce a complete plan before mutation | flags and explicit approvals | derived | plan must be deterministic; `block` on unresolved required input | `plan`, `--dry-run`; TUI review | MVP · `A` · FEAT-001 |
| CORE-004 | Dry-run / explain mode | application engine / `S` | operation plan | available for every mutating lifecycle operation | `--dry-run`, `--explain` | derived | no filesystem or remote mutation; `block` if operation cannot plan safely | all mutating CLI commands; TUI preview | MVP · `A` · architecture |
| CORE-005 | Apply engine | application engine / `S` | approved plan | apply only validated plan operations | confirmation policy | derived | operation-level result and rollback boundary; `block` on unsafe drift | CLI apply; TUI progress | MVP · `P` · Phase 3 |
| CORE-006 | Lifecycle state machine | portable core / `S+P` | state schema + environment evidence | `uninstalled → installed → scaffolded → configuring → ready` | no arbitrary manual ready flag | derived | transitions have predicates; `block` invalid transitions | `status`, `doctor`; TUI status | MVP · `A` · architecture |
| CORE-007 | Machine-readable state | portable core / `P+L` | `.portable-opencode/state.json` and local machine state | store non-secret project lifecycle facts | generated migration-safe updates | generated | JSON schema; `block` invalid state | `status --json`; TUI model | MVP · `A` · DEC-007 |
| CORE-008 | Configuration provenance | portable core / `S` | resolved layer graph | every effective setting reports source | none; inspection only | derived | provenance coverage; `warn` on opaque upstream values | `explain <key>`; TUI detail panel | MVP · `P` |
| CORE-009 | Idempotency | application engine / `S` | current environment + desired plan | rerun converges or safely reports no-op | `--force` only for supported cases | derived | repeated fixture run; `block` destructive divergence | install/init/upgrade | MVP · `A` · architecture |
| CORE-010 | Backups before replacement | application engine / `L` | backup policy | timestamped local backup of managed existing files | configurable retention; opt-out only when safe | private | restore test; `block` if replacement is irreversible | install/upgrade; TUI plan | MVP · `P` |
| CORE-011 | Structured diagnostics | portable core / `S` | diagnostic registry | stable codes, severity, evidence and remediation | output format only | derived | schema and fixture tests | `doctor`, `--json`; TUI doctor | MVP · `A` · FEAT-001 |
| CORE-012 | Structured progress events | application engine / `S` | operation event contract | start/progress/success/failure/cancel events | presentation only | derived | CLI/TUI equivalence tests | CLI stream; TUI progress | MVP · `P` · SPIKE-005 |
| CORE-013 | Safe cancellation | application engine / `S` | operation boundaries | cancel only at declared safe boundaries | Ctrl+C / TUI cancel | derived | cancellation fixture; `degrade` if partial but recoverable | CLI and TUI | MVP · `P` · SPIKE-005 |
| CORE-014 | Non-interactive execution | portable core / `G+S` | CLI contract | supported for deterministic workflows | flags or input manifest | generated | missing decisions `block` with actionable list | `--non-interactive`, CI | MVP · `A` |
| CORE-015 | Migration framework | portable core / `G+P+L` | versioned state/config schemas | forward migrations with backup | target version and explicit downgrade policy | generated | migration fixtures; `block` unknown state version | `upgrade`, `doctor` | MVP foundation · `P` |
| CORE-016 | Uninstall / detach | portable core / `G+L` | managed-resource inventory | remove only managed assets; preserve user data | component selection | derived | dry-run and ownership proof; `ask` ambiguous files | `uninstall`, `detach-project` | Post-MVP · `D` |

---

# 8. OpenCode configuration

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| OC-001 | OpenCode installation | installer / `E+L` | supported-version manifest | install or detect a supported version | version channel/profile | queried + generated | version check; `block` unsupported major | `install`, `doctor` | MVP · `P` · SPIKE-001 |
| OC-002 | Global OpenCode config | OpenCode adapter / `G+L` | versioned global template + profile | canonical safe configuration | private local override | template or linked | parse + OpenCode load test; `block` invalid config | install, explain | MVP · `A` |
| OC-003 | Project OpenCode config | OpenCode adapter / `P` | project template + detected stack | minimal project-specific additions | project profile and interview decisions | generated | parse + precedence test; `block` conflict | init-project, context review | MVP · `A` |
| OC-004 | Global agent instructions | OpenCode adapter / `G+L` | global `AGENTS.md` template | concise transversal behaviour and safety principles | local user fragment | template or linked | file presence and load behaviour; `warn` unverified merge | install | MVP · `P` · SPIKE-001 |
| OC-005 | Project `AGENTS.md` | project scaffold / `P` | context + project template + native `/init` output | project-specific operating rules and reading order | user-approved edits | generated | consistency with context; `block` missing after ready | init-project, context-review | MVP · `A` |
| OC-006 | Base agents | OpenCode adapter / `G+P` | versioned agent manifests | `build`, `explore`, `architect`, `review`, `verify`, `docs`; preserve native `plan` unless evidence says otherwise | profile and project additions | template + generated | manifest parse, permissions and invocation smoke test | install/init; TUI component list | MVP · `P` · SPIKE-001 |
| OC-007 | Base commands | OpenCode adapter / `G+P` | versioned command Markdown | only commands with defined contracts | profile and project additions | template | command discovery and fixture execution | install/init | MVP subset · `P` · SPIKE-001 |
| OC-008 | Base skills | OpenCode adapter / `G+P` | versioned skill directories | small transversal set loaded on demand | user/project additions | template | discovery test; `warn` optional skill failure | install/init | MVP subset · `P` |
| OC-009 | Core plugins | OpenCode adapter / `G+P` | versioned plugin packages | security, compaction, session, Graphify and observability only when contracts exist | profile/component opt-out where safe | template/package | load and event tests; `block` security plugin failure | install/init/doctor | MVP staged · `P` · SPIKE-001 |
| OC-010 | Custom tools | OpenCode adapter / `G+P` | typed tool packages | status, graph, verification and observability operations | project additions | template/package | schema and invocation test | OpenCode tools | MVP subset · `P` · SPIKE-001 |
| OC-011 | Global permission baseline | OpenCode adapter / `G` | security policy manifest | safe reads allowed; secrets denied; unknown bash asks | stricter profile/local override | generated | policy parse and adversarial fixtures; `block` weakening canonical denies | install, doctor, explain | MVP · `A` |
| OC-012 | Per-agent permissions | OpenCode adapter / `G+P` | agent manifests + project verification profile | least privilege by role | project may tighten; broadening requires explicit approval | generated | permission fixtures; `block` invalid escalation | agents, doctor | MVP · `A` |
| OC-013 | LSP enablement | OpenCode/project adapter / `P+E` | stack profile + repository detection | enable only relevant supported LSPs | user selection when ambiguous | generated | server availability and diagnostic smoke test; `degrade` if optional | `/init-project`, doctor | MVP · `P` · SPIKE-001 |
| OC-014 | Experimental LSP tool | OpenCode adapter / `G+P` | profile flag | disabled until stability is validated | explicit experimental profile | generated | operation smoke tests; `skip` by default | profile | Post-MVP/experimental · `D` |
| OC-015 | Formatter integration | project adapter / `P+E` | stack profile + repository config | use one existing canonical formatter; do not impose competing formatters | ask when multiple detected | generated | format check on fixture; `ask` ambiguity | `/init-project`, verify | MVP · `P` |
| OC-016 | Watcher ignore | OpenCode/project adapter / `G+P` | base ignore + generated project paths | ignore Git, dependencies, builds, caches, graph/state outputs | project additions | generated | loop and change-detection tests; `block` self-trigger loop | init, doctor | MVP · `A` |
| OC-017 | Compaction policy | OpenCode adapter / `G+P` | global policy + session plugin | auto/prune enabled with reserved margin; preserve operational state | profile tuning | generated | long-session fixture; `degrade` if hook unavailable | install, session status | MVP · `P` · SPIKE-001 |
| OC-018 | Native `/init` integration | OpenCode workflow / `P` | native command + portable orchestration | retain `/init`; invoke after project baseline and reconcile `AGENTS.md` | none except explicit skip for debugging | generated workflow | fixture comparison; `block` unresolved contradiction | `/init-project` | MVP · `A` |
| OC-019 | TUI/keybindings configuration | OpenCode adapter / `G+L` | versioned `tui.json` profile | minimal portable bindings for agents, models, variants and navigation | private user override | template | parse and manual smoke test; `warn` conflicts | install | MVP optional · `P` |
| OC-020 | Session identifier and metadata export | OpenCode adapter / `S` | runtime events/API | propagate stable session, agent, command and project identifiers | none; privacy controls metadata fields | queried + derived | trace correlation test; `degrade` if partial | observability/status | MVP · `U` · SPIKE-001/003 |
| OC-021 | OpenCode server / attach mode | OpenCode adapter / `E+L` | explicit profile | disabled and loopback-only by default | advanced profile + password | generated | bind/auth test; `block` unsafe network exposure | advanced CLI | Post-MVP · `D` |
| OC-022 | External references | project adapter / `P+L` | explicit project context decision | none by default | user-approved paths only | generated | path and permission checks; `ask` | `/init-project` | Post-MVP · `D` |

---

# 9. OpenRouter policy

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| OR-001 | API key presence | OpenRouter adapter / `L` | environment or OpenCode auth store | require a user-specific key or supported authenticated path | user authenticates locally | private + queried | authenticated metadata request; `block` paid routing setup | install, doctor | MVP · `A` |
| OR-002 | One key per user | OpenRouter policy / `L+R` | team policy | individual keys; never shared in repository | workspace-specific administration | private + remote | key identity/limits when API permits; `warn` if unverifiable | doctor | MVP policy · `A` |
| OR-003 | Semantic model roles | portable policy / `G+P` | `openrouter/roles` manifest | `main`, `build`, `explore`, `review`, `verify` | profile/project role remapping | static + generated | all referenced roles resolve; `block` missing required role | explain, cost, TUI profile | MVP · `A` · DEC-001 |
| OR-004 | Remote preset or alias synchronization | OpenRouter adapter / `G+R` | versioned expected manifest | verify remote policy matches expected state | explicit sync/repair | queried + generated | diff remote vs expected; `degrade` if read-only, `block` invalid role | doctor, sync | MVP · `U` · SPIKE-002 |
| OR-005 | `main` routing policy | OpenRouter policy / `G+R` | role manifest | general dynamic routing with tool compatibility and fallbacks | profile override | static/remote | tool-calling fixture and metadata; `block` incompatible endpoint | OpenCode agent role | MVP · `P` · SPIKE-002 |
| OR-006 | `build` routing policy | OpenRouter policy / `G+R` | role manifest | coding-optimized router or validated strong coding model | profile override | static/remote | coding/tool fixture and cost capture | build agent | MVP · `P` · SPIKE-002 |
| OR-007 | `explore` routing policy | OpenRouter policy / `G+R` | role manifest | fast, lower-cost model prioritizing throughput | profile override | static/remote | repository exploration fixture | explore agent | MVP · `P` · SPIKE-002 |
| OR-008 | `review` routing policy | OpenRouter policy / `G+R` | role manifest | strong coding/reasoning role with deterministic parameters | profile override | static/remote | seeded review fixture | review agent | MVP · `P` · SPIKE-002 |
| OR-009 | `verify` routing policy | OpenRouter policy / `G+R` | role manifest | reliable low-cost model; tools only as required | profile override | static/remote | structured verification-summary fixture | verify agent | MVP · `P` · SPIKE-002 |
| OR-010 | Provider parameter compatibility | OpenRouter policy / `G+R` | provider policy manifest | require support for requested parameters/tooling | advanced override only | static/remote | route metadata and tool fixture; `block` incompatible | doctor | MVP · `P` · SPIKE-002 |
| OR-011 | Fallback policy | OpenRouter policy / `G+R` | role manifest | enabled for required roles; constrained by privacy and compatibility | profile/role override | static/remote | forced-failure fixture; `degrade` if fallback exhausted | traces, doctor | MVP · `P` · SPIKE-002 |
| OR-012 | Provider pinning | OpenRouter policy / `G+R` | role manifest | no manual pinning by default | explicit troubleshooting profile | static/remote | provider availability; `warn` reduced resilience | advanced profile | MVP capability · `P` |
| OR-013 | Data collection policy | OpenRouter policy / `G+R` | privacy profile | deny data collection where supported | stricter profile only; weakening requires explicit approval | static/remote | inspect effective provider policy; `block` canonical privacy violation | doctor, explain | MVP · `A` · DEC-005 |
| OR-014 | Zero Data Retention profile | OpenRouter policy / `G+R` | `strict-zdr` profile | optional, not global canonical default | profile selection | static/remote | eligible endpoints and role resolution; `block` if selected but unavailable | install/profile | MVP optional · `P` |
| OR-015 | Prompt/input-output logging | OpenRouter account policy / `R` | remote settings + local expectation | disabled | explicit user opt-in outside canonical profile | queried | verify when API permits; `warn` if unverifiable | doctor | MVP policy · `A` |
| OR-016 | Spending limits | OpenRouter key policy / `R` | remote key limits | configurable monthly cap and alerts; no hardcoded amount | user/team value | remote | query key limit when API permits; `warn` absent limit | install, doctor, TUI | MVP · `P` · SPIKE-002 |
| OR-017 | Usage accounting | OpenRouter adapter / `S+R` | response usage metadata | capture tokens, cached tokens, reasoning and cost | none except privacy-safe storage policy | queried + derived | compare response metadata and trace; `degrade` missing fields | `/cost`, traces | MVP · `P` · SPIKE-002/003 |
| OR-018 | Router metadata | OpenRouter adapter / `S+R` | response/header metadata | request metadata needed for model/provider/fallback attribution | diagnostic verbosity | queried | trace fixture; `degrade` if unavailable | traces, explain | MVP · `P` · SPIKE-002 |
| OR-019 | Session affinity | OpenRouter adapter / `S` | OpenCode session mapping | maintain model/provider continuity within a session where supported | new subagent/session creates new affinity key | generated | multi-turn route fixture; `degrade` if unsupported | observability | MVP · `U` · SPIKE-001/002 |
| OR-020 | Prompt caching posture | OpenRouter policy / `G+R` | role/provider policy | exploit provider caching naturally; keep stable prompt prefixes | role/profile tuning | static/remote | cached-token evidence; `warn` no cache | cost/trace | MVP optimization · `P` |
| OR-021 | Full response caching | OpenRouter policy / `G+R` | role policy | disabled globally | explicit stateless operation only | static/remote | stale-repository fixture; `block` accidental global enable | doctor | MVP policy · `A` |
| OR-022 | Context compression | OpenRouter policy / `G+R` | emergency profile | disabled by default; OpenCode compaction first | explicit emergency profile | static/remote | long-context controlled fixture; `warn` quality risk | advanced profile | Post-MVP · `D` |
| OR-023 | Structured outputs | OpenRouter role/tool policy / `G+P+R` | operation schema | use for classifiers, audits and machine state—not normal conversation | per operation | generated | schema conformance fixture; `block` invalid machine output | tools/plugins | MVP selective · `P` |
| OR-024 | Response healing | OpenRouter operation policy / `G+R` | structured-output profile | enabled only for machine-readable workflows after validation | per operation | static/remote | malformed-output fixture | tools/plugins | MVP selective · `P` · SPIKE-002 |
| OR-025 | OpenRouter plugins/server tools | OpenRouter policy / `G+R` | allowlist | none globally | explicit operation/profile | static/remote | effective plugin list; `block` invisible unapproved tool | doctor/explain | MVP policy · `A` |
| OR-026 | Workspace/team policy | OpenRouter policy / `R` | workspace configuration | single-user setup first; team workspace optional | team profile | remote | membership/policy checks | advanced install | Post-MVP · `D` |

---

# 10. Local observability

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| OBS-001 | Transparent local proxy | observability adapter / `L+E` | portable observability profile | route OpenCode requests through a local compatible proxy | bypass for diagnosis only | generated/private | streaming, tools and error parity; `block` if configured path corrupts requests | observe lifecycle, doctor | MVP · `A` policy / `U` mechanism · SPIKE-003 |
| OBS-002 | OpenCode provider base URL redirection | OpenCode adapter / `G+L` | generated provider config | local proxy endpoint | direct OpenRouter degraded profile | generated | end-to-end request test; `degrade` on explicit bypass | install, observe doctor | MVP · `P` · SPIKE-003 |
| OBS-003 | Reference backend | observability adapter / `L+E` | observability profile | Arize Phoenix local | replaceable backend adapter; `none` profile | generated/private | install, ingest and UI smoke tests | observe start/open | MVP · `P` · DEC-010/SPIKE-003 |
| OBS-004 | Metadata-only capture | observability policy / `G+L` | privacy profile | enabled | stricter minimization possible | static/generated | trace fields present without content; `block` content leakage | doctor, trace inspection | MVP · `A` · DEC-005 |
| OBS-005 | Prompt/response content capture | observability policy / `L` | explicit local consent | disabled | explicit opt-in per profile/session | private | verify consent and redaction; `block` silent enable | observe config | MVP capability, default off · `A` |
| OBS-006 | Secret redaction | observability adapter / `G+L` | redaction policy | redact known credential patterns before persistence | user additions; canonical rules cannot be disabled silently | generated | seeded-secret fixtures; `block` failure | doctor | MVP · `A` |
| OBS-007 | Local binding | observability adapter / `L` | runtime config | bind UI and proxy to loopback | explicit secure network profile later | private | socket binding inspection; `block` unsafe exposure | observe start/doctor | MVP · `A` |
| OBS-008 | Local storage | observability backend / `L` | backend config | private local data directory excluded from Git | configurable path | private | permissions and ignore checks; `block` repository path | observe doctor | MVP · `A` |
| OBS-009 | Retention policy | observability policy / `L` | local profile | bounded configurable retention; exact default pending measurement | user value | private | purge fixture and disk estimate; `warn` unbounded retention | observe config | MVP · `P` · SPIKE-003 |
| OBS-010 | Trace correlation | observability adapter / `S` | session/project/agent/command metadata | correlate all available stable identifiers | none; degrade fields when unavailable | derived | multi-agent trace fixture; `degrade` incomplete correlation | traces, cost | MVP · `U` · SPIKE-001/003 |
| OBS-011 | Model/provider attribution | observability adapter / `S` | OpenRouter metadata | record requested and resolved model/provider | none | queried + derived | compare API metadata; `degrade` missing provider | trace view, `/cost` | MVP · `P` |
| OBS-012 | Token and cost metrics | observability adapter / `S` | response usage metadata | record input/output/reasoning/cache tokens and actual cost | display aggregation only | queried + derived | reconciliation fixture | trace and cost commands | MVP · `P` |
| OBS-013 | Latency metrics | observability adapter / `S` | proxy timings | total latency and time-to-first-token where streaming allows | none | derived | timing fixture | traces | MVP · `P` |
| OBS-014 | Errors, retries and fallbacks | observability adapter / `S` | proxy/OpenRouter metadata | persist structured failure chain | none | derived | forced-failure fixture | traces, doctor | MVP · `P` |
| OBS-015 | Operational OpenCode events | OpenCode plugin + observability / `S` | plugin event contract | tool duration, compaction, verification and Graphify lifecycle events | event allowlist | derived | event fixture; `degrade` if upstream event missing | trace correlation | MVP staged · `U` · SPIKE-001/003 |
| OBS-016 | Degraded direct mode | portable core / `S` | runtime state | explicit direct OpenRouter bypass marks observability degraded | user chooses for remediation | derived | state and UI banner; `warn/degrade` | CLI/TUI status | MVP · `A` |
| OBS-017 | Observability lifecycle | portable CLI / `L` | backend adapter | `start`, `stop`, `status`, `open`, `doctor` | backend profile | generated | process/health checks | CLI; TUI actions | MVP · `A` |
| OBS-018 | Embedded observability dashboard in portable TUI | TUI / `L` | none | do not duplicate Phoenix UI | none in MVP | none | n/a | external UI only | Excluded · `X` · FEAT-001 |

---

# 11. Graphify

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| GR-001 | Graphify installation | installer / `E+L` | supported-version manifest | installed in canonical profile | explicit non-canonical profile only | queried + generated | version/command check; `block` canonical install readiness | install, doctor | MVP · `A` · DEC-004 |
| GR-002 | Initial project graph | Graphify adapter / `P+S` | project source + ignore policy | generate before project becomes ready | none except troubleshooting skip that blocks ready | derived | graph command, stats and audit; `block` ready | `/init-project`, graph status | MVP · `A` |
| GR-003 | `.graphifyignore` composition | Graphify adapter / `P` | base + stack fragments + detected paths + decisions | generated, reviewed and versioned | manual project rules and persisted decisions | generated | explain included fragments; `block` invalid file | init, graph-review | MVP · `A` |
| GR-004 | `.gitignore` interaction | Graphify adapter / `P` | actual Graphify semantics + project ignores | never promise recovery of Git-ignored paths | user changes `.gitignore` deliberately | queried + derived | fixture semantics; `warn` unexpected source loss | graph audit | MVP · `P` · SPIKE-004 |
| GR-005 | Graph output location | Graphify adapter / `P+L` | project state | `graphify-out/` outside watched source paths | configurable local path only if tools follow it | generated | path and watcher check | graph status | MVP · `P` |
| GR-006 | Graph output versioning | project policy / `P+L` | decision pending | do not decide until size, stability and collaboration value are measured | project profile | generated/private | repository fixture and diff-noise analysis | init/doctor | MVP decision · `U` · SPIKE-004 |
| GR-007 | Dirty state | Graphify plugin / `S` | file-change events + last graph update | mark graph dirty after relevant source changes | ignore rules | derived | edit/update fixture | status, TUI | MVP · `A` |
| GR-008 | Incremental update strategy | Graphify adapter / `S` | supported Graphify operations | prefer incremental update if reliable; otherwise explicit bounded rebuild | profile based on spike evidence | derived | correctness/performance fixture; `degrade` on rebuild fallback | graph-update | MVP · `U` · SPIKE-004 |
| GR-009 | Automatic update timing | Graphify plugin / `S` | event policy | debounce and update at safe idle/work boundaries, not mid-edit | project timing profile | derived | concurrency fixture; `degrade` to explicit update | session plugin | MVP · `P` · SPIKE-004 |
| GR-010 | Git lifecycle integration | Graphify adapter / `P+S` | hook policy | synchronize on selected commit/checkout events without blocking unrelated Git work unnecessarily | profile and platform support | generated | hook fixtures across platforms | install hooks, doctor | MVP · `U` · SPIKE-004 |
| GR-011 | New path classification | Graphify plugin/tool / `S` | path classifier schema | auto-exclude deterministic noise; queue semantic ambiguity | project decision | derived | classifier fixtures and structured output | graph-review | MVP · `A` policy |
| GR-012 | Pending graph decisions | project state / `P+S` | `.portable-opencode` decision records | accumulate until safe review boundary | user resolves include/exclude/partial/later | generated | persistence and no-repeat test | graph-review; future TUI | MVP · `A` |
| GR-013 | Decision provenance | Graphify adapter / `P` | decision record | path, choice, reason, source and timestamp | user may revise | generated | schema and reconciliation | graph-decision | MVP · `A` |
| GR-014 | Graph audit | Graphify adapter / `S` | graph stats and repository evidence | inspect growth, unclassified files, god nodes and noise | thresholds by project profile | derived | fixture expected findings; `warn` quality issues, `block` severe init failure | graph-audit | MVP · `A` |
| GR-015 | Exploration order | agent policy / `G+P` | `AGENTS.md` and explore agent | context → Graphify → LSP → search → direct read | task may justify direct evidence | static/template | agent fixture/review | explore agent | MVP · `A` |
| GR-016 | Self-trigger loop prevention | OpenCode/Graphify adapter / `G+P` | watcher and ignore rules | ignore graph output, state, Git and caches | project additions | generated | loop fixture; `block` detected loop | doctor | MVP · `A` |
| GR-017 | Graph visualization in portable TUI | TUI | none | use Graphify's own suitable viewer or external artifact | none in MVP | none | n/a | external | Excluded · `X` · FEAT-001 |

---

# 12. RTK

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| RTK-001 | RTK installation | installer / `E+L` | supported-version manifest | installed in canonical profile | non-canonical opt-out | queried + generated | command/version check; `degrade` if absent | install, doctor | MVP · `A` |
| RTK-002 | Bash command rewriting/integration | OpenCode plugin / `G+L` | RTK policy | apply only to supported verbose commands without changing semantics | command allowlist/denylist | generated | output and exit-code parity fixtures; `degrade` unsupported command | agent bash | MVP · `P` |
| RTK-003 | Output reduction | RTK adapter / `S` | command-specific formatter | compact terminal context while preserving failures and actionable detail | verbosity profile | derived | golden-output fixtures | agent tool output | MVP · `P` |
| RTK-004 | Verification truth | verification subsystem | canonical commands and exit codes | RTK never changes pass/fail truth | none | derived | compare raw vs compact exit/result | verify | MVP policy · `A` |
| RTK-005 | Fallback mode | OpenCode plugin / `S` | RTK availability | execute original command and mark reduced-context mode unavailable | none | derived | missing-tool fixture; `degrade` | status/doctor | MVP · `A` |
| RTK-006 | Full raw log retention | operations policy / `L` | task-specific local logging | off by default unless required for debugging; never confuse with observability | explicit debug option | private | path/privacy check | debug mode | Post-MVP · `D` |

---

# 13. Project context and knowledge lifecycle

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| CTX-001 | Context directory scaffold | project scaffold / `P` | versioned templates | `docs/context/` with canonical documents | stack/project additions | template | file/link validation; `block` ready if required docs absent | init-project | MVP · `A` |
| CTX-002 | Context index | project scaffold / `P` | `docs/context/index.md` | reading order, document responsibilities and statuses | project-specific links | template/generated | link check | agents/context review | MVP · `A` |
| CTX-003 | Current project definition | project context / `P` | `PROJECT.md` | facts, users, scope, non-goals and current state | interactive user definition | generated + edited | required sections and contradiction check | `/init-project` | MVP · `A` |
| CTX-004 | Vision separation | project context / `P` | `VISION.md` | desired future separate from current capability | interactive user definition | generated + edited | no implemented-state claims from vision alone | `/init-project` | MVP · `A` |
| CTX-005 | Architecture context | project context / `P` | `ARCHITECTURE.md` | responsibilities, boundaries, flows and uncertainties | user/agent decisions | generated + edited | link to accepted decisions; `block` unresolved critical contradiction | init/context review | MVP · `A` |
| CTX-006 | Conventions | project context / `P` | `CONVENTIONS.md` | repository, code, config, security and testing conventions | stack/project choices | generated + edited | verify canonical commands/config | init/verify | MVP · `A` |
| CTX-007 | Operations | project context / `P` | `OPERATIONS.md` | session workflow, canonical commands, handoff and maintenance | environment-specific commands | generated + edited | commands executable when code exists | init/verify | MVP · `A` |
| CTX-008 | Durable decisions | project context / `P` | `DECISIONS.md` and later ADRs | accepted/proposed/deferred distinction | explicit owner/team decision | edited | decision IDs/status and references | `/decision`, context-review | MVP · `A` |
| CTX-009 | Roadmap | project context / `P` | `ROADMAP.md` | dependency-ordered phases and exit criteria | owner/team prioritization | edited | next milestone matches state | status/context-review | MVP · `A` |
| CTX-010 | Context log / handoff | project context / `P` | `log.md` | meaningful changes, validation and next action—not full chat history | agent/user entries | edited/generated | latest handoff consistent with state | `/handoff` | MVP · `A` |
| CTX-011 | OKF-compatible metadata subset | context schema / `P` | repository-owned schema informed by OKF | provenance, lifecycle, sources and verification fields | project extensions | template/generated | frontmatter schema | docs validation | MVP · `P` · DEC-011 |
| CTX-012 | Source-of-truth hierarchy | `AGENTS.md` / `P` | accepted project policy | explicit instruction → decisions → architecture/conventions → project/roadmap → specification → implementation/state → history | project-specific refinements | template | contradiction fixture/review | agents | MVP · `A` |
| CTX-013 | Native `/init` reconciliation | context/OpenCode workflow / `P` | portable docs + generated `AGENTS.md` | use native repository inspection without allowing it to overwrite product context blindly | user resolves contradiction | generated workflow | diff and consistency review; `ask` | `/init-project` | MVP · `A` |
| CTX-014 | Documentation validation | verification subsystem / `P` | docs schema/link rules | automated frontmatter, link, JSON and status checks | project document set | generated | canonical docs command | verify/CI | MVP · `P` |
| CTX-015 | Ready-state documentation predicate | lifecycle engine / `S` | required context and decisions | project cannot be ready with incomplete critical context | no manual bypass in canonical profile | derived | ready predicate | status/init | MVP · `A` |

---

# 14. Security and permissions

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| SEC-001 | Secret file read protection | OpenCode permission + security plugin / `G+P` | security policy | deny `.env` variants, keys, certificates and auth stores | only explicit one-off user-mediated access outside agent context | generated | adversarial path fixtures; `block` policy failure | doctor | MVP · `A` |
| SEC-002 | Secret persistence prevention | portable core / `G+P+L` | repository and observability policies | credentials and raw private state never versioned | none | static/generated | secret scan and path checks; `block` | verify/doctor | MVP · `A` |
| SEC-003 | Destructive shell commands | OpenCode permissions / `G+P` | command policy | deny destructive broad operations; ask narrowly reversible exceptions | explicit session approval where policy permits | generated | command-pattern fixtures | agent bash | MVP · `A` |
| SEC-004 | Git mutation boundaries | OpenCode permissions / `G+P` | Git policy | reads allowed; commit asks; push and force/destructive operations denied by canonical agent profile | explicit human-run or alternative profile | generated | permission fixture | build/verify | MVP · `A` |
| SEC-005 | Repository path boundary | security plugin / `G+P` | project root and approved references | writes inside project only; outside paths ask/deny | explicit approved reference | derived | traversal/symlink fixtures; `block` escape | doctor | MVP · `A` |
| SEC-006 | Per-agent least privilege | OpenCode agent manifests / `G+P` | role policy | architect/review read-only; verify command-limited; build scoped mutation | project may tighten | generated | agent capability fixtures | agent selector | MVP · `A` |
| SEC-007 | Verification command allowlist | project verification profile / `P` | generated stack profile | only canonical lint/typecheck/test/build/smoke commands automatically allowed | user approves additions | generated | command exists and is non-destructive; `ask` ambiguity | verify | MVP · `A` |
| SEC-008 | External network actions | OpenCode permissions / `G+P` | network/tool policy | ask or deny unless operation explicitly requires known endpoint | profile and current task approval | generated | endpoint/tool fixture | agent/tools | MVP · `P` |
| SEC-009 | Observability redaction | observability policy / `G+L` | redaction rules | redact before persistence | additive custom patterns | generated | seeded fixtures; `block` | observe doctor | MVP · `A` |
| SEC-010 | API-key validation without disclosure | OpenRouter adapter / `L` | auth check operation | report validity, identity/limit metadata, never value | none | queried | output snapshot contains no secret | doctor | MVP · `A` |
| SEC-011 | Managed-file ownership | application engine / `S` | inventory and file markers/hashes | modify only files the engine owns or explicitly adopts | user adoption decision | derived | drift fixture; `ask` conflict | plan/apply | MVP · `P` |
| SEC-012 | Supply-chain/version policy | installer / `G+E` | supported-version and source manifest | install from explicit upstream sources with version checks | channel/profile | static + queried | checksum/signature where available; `block` unknown source | install/upgrade | MVP · `P` |
| SEC-013 | Security doctor | diagnostic registry / `S` | combined policies and environment | check secrets, permissions, unsafe binds and policy drift | none | derived | seeded insecure fixture | doctor/TUI | MVP · `A` |
| SEC-014 | Prompt-injection/regex guardrails in OpenRouter | OpenRouter remote policy / `R` | optional guardrail profile | not relied upon as primary repository security | explicit team profile | remote | false-positive/negative spike | advanced | Post-MVP · `D` |

---

# 15. CLI and Ratatui interface

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| UX-001 | Headless CLI | presentation adapter / `G` | CLI contract | mandatory and complete for all core operations | output/input flags | static implementation | end-to-end fixtures | shell/CI | MVP · `A` |
| UX-002 | Ratatui frontend | presentation adapter / `G` | FEAT-001 | optional first-party frontend after engine contracts stabilize | launch command/profile | static implementation | SPIKE-005 and equivalence tests | terminal TUI | Post-core MVP phase · `P` · DEC-013 |
| UX-003 | Shared application engine | application core / `G` | architecture | CLI and TUI consume identical plans, diagnostics and operations | none | static implementation | identical-input plan tests; `block` duplicated mutation path | both | MVP foundation · `A` |
| UX-004 | Default command behaviour | CLI/TUI adapter / `G` | CLI UX decision pending | explicit subcommands initially; launching TUI with no args remains proposed | config/flag | static | usability spike | shell | `U` · SPIKE-005 |
| UX-005 | Non-TTY fallback | CLI adapter / `G` | terminal detection | never launch TUI without interactive terminal | `--tui` may error explicitly | derived | pipe/CI fixture | shell | MVP · `A` |
| UX-006 | Machine-readable output | CLI adapter / `G` | JSON schemas | available for status, doctor, plan and operation results | `--json` | derived | schema snapshots | shell/automation | MVP · `A` |
| UX-007 | Profile selection | application engine / `G+S` | profile registry | explicit canonical default and visible consequences | CLI flag/TUI selector | derived | same selected profile in plan | both | MVP CLI; TUI later · `P` |
| UX-008 | Plan review | application engine / `S` | operation plan | show creates/modifies/deletes/remote actions and secret boundaries | confirmation mode | derived | snapshot and no-hidden-action test | CLI/TUI | MVP · `A` |
| UX-009 | Doctor presentation | diagnostics / `S` | structured findings | severity, evidence and remediation | filter/format | derived | CLI/TUI parity | both | MVP CLI; TUI phase 4.5 · `A` |
| UX-010 | Progress presentation | operation events / `S` | shared event contract | concise CLI, richer TUI | verbosity | derived | parity and cancellation fixtures | both | MVP foundation · `P` |
| UX-011 | Error presentation | diagnostics / `S` | error contract | stable code, cause, impact, remediation and retryability | format only | derived | fixture snapshots | both | MVP · `A` |
| UX-012 | Secret display policy | security policy / `G` | redaction rules | never render secret values; show source and status only | none | derived | seeded UI/CLI fixtures; `block` leak | both | MVP · `A` |
| UX-013 | TUI doctor view | Ratatui adapter | FEAT-001 | first prototype view | none | static implementation | SPIKE-005 | TUI | Proposed · `P` |
| UX-014 | TUI install-plan review | Ratatui adapter | FEAT-001 | first prototype view | approve/cancel/inspect | static implementation | SPIKE-005 | TUI | Proposed · `P` |
| UX-015 | TUI profile selector | Ratatui adapter | FEAT-001 | first prototype view | keyboard selection | static implementation | SPIKE-005 | TUI | Proposed · `P` |
| UX-016 | TUI semantic project interview | OpenCode, not Ratatui | architecture/FEAT-001 | remain an agent workflow | n/a | n/a | boundary review | `/init-project` | Excluded from rigid TUI · `X` |
| UX-017 | TUI Graphify decision queue | Ratatui adapter | FEAT-001 + graph state | later projection over structured pending decisions | user decision | static implementation | after GR contracts validated | TUI | Post-MVP · `D` |

---

# 16. Installation, platform and distribution

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| INST-001 | Operating-system detection | installer / `L` | runtime platform adapter | explicit supported/unsupported result | none | queried | platform fixtures | install/doctor | MVP · `A` |
| INST-002 | Initial platform matrix | project decision | supported-platform manifest | Windows matters; exact native vs WSL and Unix matrix pending | profile/platform | static | clean-environment spikes; `block` unsupported path | install | `U` · Phase 1/spikes |
| INST-003 | Dependency discovery | installer / `L+E` | dependency manifest | inspect before install; report version/source | component selection | queried | fixture/path tests | doctor/install | MVP · `A` |
| INST-004 | Dependency installation | installer / `L+E` | component adapters | install only missing/incompatible managed components | profile and package-source policy | generated | command and version check; `block` core failure | install/TUI | MVP · `P` |
| INST-005 | Existing configuration backup | installer / `L` | backup policy | backup before managed replacement | retention/path | private | restore fixture | install/upgrade | MVP · `P` |
| INST-006 | Configuration deployment method | installer / `G+L` | platform/profile decision | prefer generated files; linking only where safe and understandable | deployment profile | generated/linked | edit/upgrade/drift fixture | install | `U` · Phase 1 |
| INST-007 | Project scaffold | project initializer / `P` | templates + selected profile | create context, OpenCode config, state and provisional Graphify policy | project path/profile | template/generated | fixture tree and idempotency | `init-project` | MVP · `A` |
| INST-008 | Git initialization | project initializer / `P` | project operation | initialize Git for new empty project | explicit reuse of existing fresh Git repo | generated | repository check; `ask` unexpected history | init-project | MVP · `A` |
| INST-009 | Empty/fresh directory guard | project initializer / `P` | filesystem evidence | canonical MVP refuses ambiguous existing repositories | explicit later adoption workflow | queried | fixture; `block` non-fresh path | init-project | MVP · `A` · DEC-003 |
| INST-010 | Version pinning | installer / `G+L` | supported-version manifest and lock metadata | pin/test compatible ranges rather than blindly latest | update channel | static + queried | compatibility matrix | install/doctor | MVP · `P` |
| INST-011 | Upgrade | installer / `G+L+P` | release and migration manifests | plan, backup, migrate, validate | target version/channel | generated | upgrade fixtures; `block` unknown migration | upgrade | MVP foundation · `P` |
| INST-012 | Packaging/runtime | distribution | DEC-009/012/013 | unresolved: TypeScript, Rust or bounded hybrid | none until evidence | static implementation | installation size, startup, cross-platform and maintenance spike | release | `U` · SPIKE-005 + Phase 2 |
| INST-013 | Shell bootstrap | distribution / `E` | release mechanism | minimal bootstrap only after packaging decision | PowerShell/shell entrypoint | static | clean-machine fixture | install | Deferred until packaging · `D` |
| INST-014 | Final doctor gate | lifecycle engine / `S` | readiness predicates | installation/project operation ends with diagnostics | explicit degraded profile only where allowed | derived | fixture expected state | install/init | MVP · `A` |
| INST-015 | Offline installation | distribution | package/cache policy | not guaranteed in first MVP | future bundle/profile | static/private | offline fixture | install | Post-MVP · `D` |
| INST-016 | Existing-repository adoption | initializer | separate future workflow | unsupported in first MVP | none | none | n/a | future command | Excluded MVP · `X` |

---

# 17. Verification and readiness

| ID | Capability | Owner / scope | Source of truth | Canonical default | Override or user input | Materialization | Validation and failure | Interfaces | MVP / status / evidence |
|---|---|---|---|---|---|---|---|---|---|
| VER-001 | Verification profile | project state / `P` | stack profile + context | canonical commands for docs, format, lint, typecheck, tests, build and smoke as applicable | project-approved commands | generated | commands exist and run | verify/status | MVP · `A` |
| VER-002 | Documentation-only profile | repository/project / `P` | operations policy | links, frontmatter, JSON, secrets and state consistency | none | generated | automated docs validator | verify | MVP current repo · `P` |
| VER-003 | Command result capture | verification adapter / `S` | process results | exit code, duration, concise output and timestamp | verbosity | derived | fixture | verify/observability | MVP · `A` |
| VER-004 | Ready predicate | lifecycle engine / `S` | required capability checks | all mandatory context, config, graph and verification criteria pass | no silent bypass | derived | ready-state fixtures; `block` | status/init | MVP · `A` |
| VER-005 | Degraded predicate | lifecycle engine / `S` | failure policy per matrix row | explicit list of unavailable non-blocking capabilities | profile may accept specific degradation | derived | state fixture | status/TUI | MVP · `A` |
| VER-006 | Configuration drift | doctor/application engine / `S` | managed expected vs actual config | detect and explain drift before repair | adopt/restore/ignore decision | derived | drift fixtures; `ask` ambiguous user edits | doctor/repair | MVP · `P` |
| VER-007 | CLI/TUI plan equivalence | test suite | shared engine | exact same domain plan for same inputs | none | derived | snapshot/property tests | CI | Required before TUI acceptance · `A` |
| VER-008 | Cross-platform fixtures | test suite | supported-platform manifest | test each claimed platform path | none | static/CI | clean environment workflows | CI | MVP · `P` |
| VER-009 | Security fixtures | test suite | security policies | seeded secrets, path escape, destructive commands and unsafe binds | none | static | must pass; `block` release | CI | MVP · `A` |
| VER-010 | Upstream compatibility fixtures | test suite | supported-version manifest | smoke tests against supported OpenCode/OpenRouter/Graphify versions | version matrix | static/CI | fail release/support claim | CI | MVP · `P` |

---

# 18. First-MVP capability set

The first MVP is complete only when the following capability groups are implemented and validated:

1. `CORE-001` through `CORE-015`, excluding full uninstall.
2. OpenCode global/project configuration, permissions, base roles, native `/init`, LSP/formatter/watcher/compaction paths required by the initial stack fixtures.
3. OpenRouter authentication, semantic roles, privacy, routing/fallback validation, usage and cost attribution.
4. Local metadata-first observability with an explicit degraded direct mode.
5. Graphify installation, initial graph, ignore composition, dirty/update lifecycle, pending decisions and audit.
6. RTK installation, safe output reduction and fallback.
7. Structured project context, state, decisions and ready predicates.
8. Headless CLI, JSON output, dry-run, plans, diagnostics and safe cancellation boundaries.
9. Installation and new-project initialization on the declared initial platform matrix.
10. Automated documentation, security, state and integration verification.

The Ratatui frontend is a planned first-party interface but does not block proof of the headless installation MVP. Its shared engine and contracts do belong to the MVP foundation.

---

# 19. Questions requiring owner review

The matrix intentionally leaves the following product choices unresolved:

1. Which named profiles ship in the first release beyond `canonical`, `standard-private` and `strict-zdr`?
2. Is Graphify output versioned, private local state, or profile-dependent?
3. Which OpenCode agents and commands are truly mandatory in the first usable release?
4. What exact monthly-spend guidance, if any, should the tool suggest without imposing a value?
5. Which initial platform path is authoritative: Windows native, WSL, Linux, macOS, or a smaller subset?
6. Are managed OpenCode files generated copies, links, or a platform-dependent mix?
7. Which context frontmatter fields are mandatory for the OKF-compatible subset?
8. Should the no-argument CLI launch the TUI once FEAT-001 is accepted?
9. What is the smallest useful observability retention default?
10. What exact conditions permit degraded readiness versus blocking readiness?

These choices should be reviewed before the matrix is marked `active`.

# 20. Technical evidence gates

| Gate | Required evidence | Affected areas |
|---|---|---|
| `SPIKE-001` | OpenCode precedence, extension lifecycle, permissions, events, session metadata and native `/init` behaviour | `OC-*`, `SEC-*`, `OBS-010/015` |
| `SPIKE-002` | OpenRouter role mechanism, routing, fallbacks, privacy, usage, session affinity and remote policy APIs | `OR-*` |
| `SPIKE-003` | transparent proxy, streaming/tools parity, Phoenix ingestion, redaction, correlation and local resource use | `OBS-*` |
| `SPIKE-004` | Graphify commands, ignore semantics, incremental updates, hooks, output quality and cross-platform behaviour | `GR-*` |
| `SPIKE-005` | Ratatui value, terminal behaviour, shared engine boundary, cancellation and packaging consequences | `UX-*`, `CORE-012/013`, `INST-012` |

A spike must update affected matrix rows from `P` or `U` to `V`, revise the proposed default, or explicitly reject the capability.

# 21. Phase 1 completion criteria

The configuration-matrix phase is complete when:

- every MVP capability has an owner and source of truth;
- every setting is assigned to global, project, private, remote or generated state;
- every proposed default is either owner-approved or linked to a spike;
- every mutating capability has validation and failure semantics;
- CLI and TUI exposure do not duplicate domain logic;
- open questions are converted into decisions or spike hypotheses;
- readiness can be expressed as testable predicates;
- the repository owner verifies this document;
- `.portable-opencode/state.json` advances the next milestone to `technical-spikes`.

Until then, the project remains in `definition/configuring`.
