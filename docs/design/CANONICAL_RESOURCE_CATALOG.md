---
type: Design
id: DESIGN-008
title: Canonical Resource Catalog and File Trees
description: Exact ownership boundaries, canonical paths and materialization targets for environment and project resources.
status: active
decision: DEC-021
sources:
  - resource: MANAGED_CONFIGURATION_MATERIALIZATION.md
    title: Managed Configuration Materialization
  - resource: ../context/ARCHITECTURE.md
    title: Portable OpenCode Architecture
  - resource: CONFIGURATION_MATRIX.md
    title: Portable OpenCode Configuration Matrix
  - resource: GUIDED_INSTALLATION_AND_ONBOARDING.md
    title: Guided Installation and Onboarding
---

# Canonical resource catalog and file trees

## 1. Objective

Translate the ownership model in `DESIGN-007` into concrete paths and resource identities so implementation does not invent where configuration lives, which source owns it or whether it is copied, rendered, queried or private.

This design defines the target structure. A path marked evidence-gated is still canonical intent, but the relevant spike must prove that the upstream tool actually consumes it on supported Windows before the environment can be reported `healthy`.

## 2. Ownership layers

The system keeps four distinct layers:

```text
A. canonical repository sources
B. managed personal environment
C. project-versioned generated configuration
D. private local runtime and evidence
```

A resource has one primary owner. `portable-opencode` may coordinate an upstream-owned resource without claiming ownership of the upstream implementation.

## 3. Canonical repository source tree

The implementation-facing source tree is:

```text
portable-opencode/
├── config/
│   ├── components.jsonc
│   ├── resources/
│   │   ├── environment.jsonc
│   │   └── project.jsonc
│   ├── global/
│   │   ├── opencode.jsonc
│   │   └── AGENTS.md
│   └── openrouter/
│       └── presets.jsonc
├── templates/
│   └── project/
│       ├── opencode.jsonc
│       ├── AGENTS.md
│       ├── .gitignore
│       ├── .graphifyignore
│       ├── .opencode/
│       │   ├── agents/
│       │   │   ├── review.md
│       │   │   └── verify.md
│       │   └── commands/
│       │       ├── init-project.md
│       │       ├── review.md
│       │       ├── verify.md
│       │       └── graph-update.md
│       ├── docs/context/
│       │   ├── index.md
│       │   ├── log.md
│       │   ├── PROJECT.md
│       │   ├── VISION.md
│       │   ├── ARCHITECTURE.md
│       │   ├── CONVENTIONS.md
│       │   ├── OPERATIONS.md
│       │   ├── DECISIONS.md
│       │   └── ROADMAP.md
│       └── .portable-opencode/
│           ├── state.json
│           └── verification.json
├── schemas/
│   ├── context-document.schema.json
│   ├── environment-state.schema.json
│   ├── managed-resource.schema.json
│   ├── managed-resource-inventory.schema.json
│   ├── resource-catalog.schema.json
│   ├── openrouter-presets.schema.json
│   ├── operation-result.schema.json
│   ├── supported-components.schema.json
│   └── verification-manifest.schema.json
├── scripts/
│   └── bootstrap.ps1
└── docs/
```

`DESIGN-011` owns the complete script inventory. `bootstrap.ps1` is the only mandatory product bootstrap wrapper; repository verification and break-glass recovery remain separate concerns.

Rules:

- this is the target source tree, not a requirement to create unused directories before implementation needs them;
- native filenames are retained inside `templates/` so generation does not introduce a second project configuration format;
- concrete template contents are added only after their upstream representation is validated;
- `config/components.jsonc` exists during contract definition even while supported versions remain evidence-gated;
- `config/resources/environment.jsonc` and `config/resources/project.jsonc` are canonical desired-resource catalogs, not observed machine state;
- the project template contains only repeated canonical assets; stack-specific LSP, formatter and verification content is completed by `/init-project`.

## 4. Managed personal environment tree

### 4.1 OpenCode native configuration

Target intent:

```text
%USERPROFILE%\.config\opencode\
├── opencode.jsonc
└── AGENTS.md
```

`SPIKE-001` proved the effective Windows path and global rule discovery for the tested OpenCode version. The evidence remains version-scoped and does not replace the implementation validation required before support is promoted.

The spike observed `%USERPROFILE%\\.config\\opencode` as the global configuration path in an isolated Windows fixture. It also observed, only in `opencode-ai@1.18.30`, that root `opencode.json` and `opencode.jsonc` can merge and that `.opencode\\opencode.jsonc` can load after the root project configuration. The canonical target remains one root `opencode.jsonc`; duplicate roots and `.opencode\\opencode.json(c)` remain noncanonical policy findings and must not be generalized as universal upstream behavior.

### SPIKE-001 precedence reconciliation

| Layer or surface | Classification | Reconciled interpretation |
|---|---|---|
| Global config | `PASS` | Marker and permission defaults loaded from the observed global path. |
| `OPENCODE_CONFIG` | `PASS` | Custom marker appeared between global and project markers. |
| Root project config and Git-root traversal | `PASS` | Root marker loaded from a nested directory; the tested version merged root JSON and JSONC rather than rejecting both. |
| `OPENCODE_CONFIG_DIR` | `PASS` for asset discovery | Custom agents/commands were discovered; complete precedence semantics were not independently generalized. |
| `.opencode\\opencode.jsonc` | `PASS`, version-scoped | Marker loaded after root config in `1.18.30`; this remains noncanonical for portable-opencode. |
| `OPENCODE_CONFIG_CONTENT` | `PASS` | Inline marker and conflicting rule won last in the exercised process. |
| Remote organization config | `NOT TESTED` | No authenticated organization surface was exercised. |
| `%ProgramData%\\opencode` managed config | `NOT TESTED` | No system directory was modified or proven as an active layer. |

This table records observed evidence, not a universal OpenCode precedence contract. The implementation must report active provenance and keep the repository's canonical conflict policy explicit.

No global copies of `review`, `verify` or project lifecycle commands are required. They remain project-versioned so a repository carries the behaviour needed to understand and verify itself.

### 4.2 Portable private root

Canonical private root:

```text
%LOCALAPPDATA%\portable-opencode\
├── environment-state.json
├── managed-resources.json
├── override.jsonc              # optional; absent by default
├── backups\
├── logs\
├── bin\
├── phoenix\
└── runtime\
```

Responsibilities:

- `environment-state.json`: current personal-environment lifecycle, last operation outcome, resumable installation checkpoint and last verified component state, validated by `schemas/environment-state.schema.json` version `0.2.0` and governed by `DESIGN-013`;
- `managed-resources.json`: ownership evidence and observed identities, validated by `schemas/managed-resource-inventory.schema.json`;
- `override.jsonc`: optional private desired-state inputs accepted only when an explicit key contract exists; no arbitrary passthrough configuration;
- `backups\`: pre-mutation backups keyed by resource and operation;
- `logs\`: private operational diagnostics and failure evidence;
- `bin\`: managed portable executables when the accepted packaging mechanism needs it;
- `phoenix\`: Phoenix SQLite and private backend state if `DEC-010` is accepted;
- `runtime\`: PIDs, ports and ephemeral process evidence.

Nothing under this root is committed to a project repository.

## 5. Canonical new-project tree

After `portable-opencode init-project <path>` and successful `/init-project`, the canonical project shape is:

```text
<project>/
├── .git/
├── opencode.jsonc
├── AGENTS.md
├── .gitignore
├── .graphifyignore
├── .opencode/
│   ├── agents/
│   │   ├── review.md
│   │   └── verify.md
│   └── commands/
│       ├── init-project.md
│       ├── review.md
│       ├── verify.md
│       └── graph-update.md
├── docs/context/
│   ├── index.md
│   ├── log.md
│   ├── PROJECT.md
│   ├── VISION.md
│   ├── ARCHITECTURE.md
│   ├── CONVENTIONS.md
│   ├── OPERATIONS.md
│   ├── DECISIONS.md
│   └── ROADMAP.md
├── .portable-opencode/
│   ├── state.json
│   └── verification.json
└── graphify-out/
    ├── graph.json
    ├── GRAPH_REPORT.md
    └── manifest.json
```

Only native asset directories with actual files are created. Additional `.opencode/skills/`, `plugins/`, `tools/` or `themes/` directories appear only when a real project need or accepted integration requires them.

`graphify-out/manifest.json` is accepted conditionally for the validated Graphify `0.9.56` contract. SPIKE-004 proved relative source keys, absence of absolute/private paths and clone/incremental re-anchoring on Windows; freshness fields remain expected diff churn.

## 6. Environment resource catalog

Machine-readable source:

```text
config/resources/environment.jsonc
```

| Resource ID | Canonical source | Managed target | Mode | Primary owner | Mutation rule |
|---|---|---|---|---|---|
| `env.opencode.config` | `config/global/opencode.jsonc` + resolved inputs | effective global `opencode.jsonc` | `rendered` | portable-opencode | replace only with proven ownership/backup |
| `env.opencode.rules` | `config/global/AGENTS.md` | effective global `AGENTS.md` | `copied` | portable-opencode | replace only with proven ownership/backup |
| `env.opencode.auth` | none | OpenCode private auth store | `private` | OpenCode/user | inspect availability; never copy credentials |
| `env.openrouter.presets` | `config/openrouter/presets.jsonc` | OpenRouter preset API | `queried` | OpenRouter | reconcile only through DEC-020 |
| `env.rtk.integration` | upstream RTK command | native RTK/OpenCode integration | `queried` | RTK | invoke `rtk init -g --opencode`; verify `%USERPROFILE%\\.config\\opencode\\plugins\\rtk.ts`; missing binary is degraded |
| `env.graphify.installation` | supported component manifest | private Python 3.12 venv containing `graphifyy==0.9.56` | `queried` | Graphify/package mechanism | install/verify supported version only; no project-global Python mutation |
| `env.observability.proxy` | portable implementation + component manifest | managed local executable/process | `private` | portable-opencode | managed process and private runtime state |
| `env.observability.phoenix` | component manifest | isolated Python environment + private SQLite | `private` | Phoenix/portable-opencode lifecycle | native lifecycle only if SPIKE-003 accepts Phoenix |
| `env.portable.state` | environment-state schema | `%LOCALAPPDATA%\portable-opencode\environment-state.json` | `private` | portable-opencode | machine-edited; schema validated |
| `env.portable.resources` | managed-resource inventory schema | `%LOCALAPPDATA%\portable-opencode\managed-resources.json` | `private` | portable-opencode | mutation evidence only; never source of desired state |
| `env.portable.override` | optional user input | `%LOCALAPPDATA%\portable-opencode\override.jsonc` | `private` | user | read-only to CLI except explicit initialization/repair |

Installed binaries are not treated as owned merely because their versions match. Ownership of an installation requires the selected package mechanism and recorded managed-resource evidence.

## 7. Project resource catalog

Machine-readable source:

```text
config/resources/project.jsonc
```

| Resource ID | Canonical source | Project target | Mode | Primary owner | Mutation rule |
|---|---|---|---|---|---|
| `project.opencode.config` | project template + semantic inputs | `opencode.jsonc` | `rendered` | portable-opencode/project | scaffold then update only through explicit project workflow |
| `project.rules` | project template + semantic context | `AGENTS.md` | `rendered` | project | curated; semantic edits allowed, generator must preserve user-owned sections |
| `project.agent.review` | canonical template | `.opencode/agents/review.md` | `copied` | portable-opencode | generated asset; no manual patching of canonical copy |
| `project.agent.verify` | canonical template | `.opencode/agents/verify.md` | `copied` | portable-opencode | generated asset; no manual patching of canonical copy |
| `project.command.init` | canonical template | `.opencode/commands/init-project.md` | `copied` | portable-opencode | explicit lifecycle command |
| `project.command.review` | canonical template | `.opencode/commands/review.md` | `copied` | portable-opencode | explicit repeated command |
| `project.command.verify` | canonical template | `.opencode/commands/verify.md` | `copied` | portable-opencode | explicit repeated command |
| `project.command.graph-update` | canonical template | `.opencode/commands/graph-update.md` | `copied` | portable-opencode | invokes explicit Graphify workflow |
| `project.context` | project templates + semantic session | `docs/context/` | `rendered` then curated | project | project owns meaning after initialization |
| `project.state` | project state schema | `.portable-opencode/state.json` | `rendered`/machine-edited | portable-opencode | portable facts only; no credentials or absolute private paths |
| `project.verification` | verification-manifest schema + stack-derived initialization | `.portable-opencode/verification.json` | `rendered` | project/portable-opencode | canonical commands and readiness checks only |
| `project.graphifyignore` | base + stack + repository decisions | `.graphifyignore` | `rendered` then curated | project | explicit ambiguous-path decisions preserved |
| `project.gitignore` | base + stack | `.gitignore` | `rendered` then curated | project | never erase unrelated user rules |
| `project.graph.outputs` | Graphify | `graphify-out/` allowlist | `queried` | Graphify/project | update through Graphify with `PYTHONHASHSEED=0`; verify before commit |

The initial target is a new or freshly initialized repository. Adoption semantics for arbitrary existing project files remain outside the MVP.

## 8. Desired-state precedence

Portable desired state is resolved as:

```text
canonical repository defaults
→ project-specific semantic inputs when applicable
→ approved private local override keys
= portable desired state
```

This does not replace OpenCode's native configuration precedence. After materialization, `inspect` must still report active remote, environment, inline or managed OpenCode layers that alter the effective runtime result.

Unknown keys in `override.jsonc` block desired-state resolution. The file is absent by default and is never a general escape hatch for arbitrary upstream configuration.

No override keys are canonical merely because the file exists. The first actual machine-specific override requires an explicit accepted key/schema change.

## 9. State split

### Environment state

Private and machine-specific:

```text
%LOCALAPPDATA%\portable-opencode\environment-state.json
```

May contain installed versions, absolute paths, process identifiers, ports, backup references and local health evidence.

### Project state

Versioned and portable:

```text
<project>\.portable-opencode\state.json
```

Contains project lifecycle, schema versions, graph freshness, verification summary and non-secret resource facts. It must not contain credentials, local absolute paths, PIDs or private trace identifiers.

## 10. Supported component manifest

Canonical source:

```text
config/components.jsonc
```

It is validated by `schemas/supported-components.schema.json` and records the evidence state for each required component. A component may remain `pending` until its spike proves an exact supported version and installation mechanism.

A pending entry is honest contract state, not permission for an implementation agent to choose a version.

## 11. Schema ownership

| Artifact | Schema |
|---|---|
| project state | `.portable-opencode/state.schema.json` |
| private environment state | `schemas/environment-state.schema.json` |
| one resource contract | `schemas/managed-resource.schema.json` |
| private observed resource inventory | `schemas/managed-resource-inventory.schema.json` |
| canonical desired resource catalogs | `schemas/resource-catalog.schema.json` |
| supported components | `schemas/supported-components.schema.json` |
| CLI result envelope | `schemas/operation-result.schema.json` |
| project verification manifest | `schemas/verification-manifest.schema.json` |
| OpenRouter preset intent | `schemas/openrouter-presets.schema.json` |

## 12. Validation gates

Before production implementation begins:

- every canonical path in this design has one owner;
- machine-private and project-versioned state are disjoint;
- environment/project desired catalogs parse and validate;
- all destructive mutation requires proven ownership;
- global OpenCode paths are validated by `SPIKE-001`;
- OpenRouter remote resources are validated by `SPIKE-002`;
- observability private paths and processes are validated by `SPIKE-003`;
- Graphify/RTK output and integration paths are validated by `SPIKE-004`;
- bootstrap-byte authentication before execution, public release digest/signature verification and independently provisioned trust anchors are validated by `DEC-012` evidence;
- the supported component manifest contains no guessed supported version.
