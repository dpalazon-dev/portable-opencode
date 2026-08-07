---
type: Design
id: DESIGN-009
title: CLI Operation Contracts
description: Exact command semantics, outcomes, diagnostics, exit classes and bootstrap boundary for the mandatory headless CLI.
status: active
sources:
  - resource: ../context/ARCHITECTURE.md
    title: Portable OpenCode Architecture
  - resource: CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: CONFIGURATION_MATRIX.md
    title: Portable OpenCode Configuration Matrix
---

# CLI operation contracts

## 1. Objective

Define the command surface before implementation so Codex can implement behaviour rather than decide behaviour.

The CLI is the only mandatory configuration control interface. It exposes current state, deterministic plans, explicit mutation, diagnostics and lifecycle operations. It must remain usable without a TUI.

## 2. Common rules

All commands follow these rules:

- `--json` changes presentation only, never behaviour;
- commands that inspect or diagnose never mutate;
- mutation is based on a concrete plan and current evidence;
- `--yes` approves only the exact current plan, identified by its plan hash;
- a stale plan is never applied silently;
- non-interactive execution that needs approval and lacks `--yes` is blocked;
- secrets are never emitted in human or JSON output;
- commands run against native Windows paths and PowerShell-compatible processes;
- equivalent desired and observed state produces a no-op;
- interruption records a partial outcome when mutation already occurred;
- all results conform to `schemas/operation-result.schema.json`.

## 3. Command surface

### Environment control

```text
portable-opencode status [--json]
portable-opencode inspect [--json]
portable-opencode plan [--json] [--out <file>]
portable-opencode apply [--json] [--plan <file>] [--yes]
portable-opencode doctor [--json]
portable-opencode install [--json] [--yes]
```

### Project control

```text
portable-opencode init-project <path> [--json] [--yes]
portable-opencode project status [<path>] [--json]
portable-opencode project doctor [<path>] [--json]
```

If `<path>` is omitted for a project command, the current working directory is used.

### Observability lifecycle

```text
portable-opencode observability start [--json]
portable-opencode observability stop [--json]
portable-opencode observability status [--json]
portable-opencode observability open
portable-opencode observability purge [--json] [--yes]
```

Additional component commands are not part of the initial surface unless an upstream lifecycle gap is proven.

## 4. `status`

Purpose: provide a fast current-state summary suitable for repeated use.

Reads:

- private environment state;
- managed-resource inventory;
- lightweight component/version/process checks;
- relevant project state only when invoked through `project status`.

Does not:

- perform a full configuration precedence analysis;
- contact every remote service unless needed to determine a previously recorded state is stale;
- mutate or repair anything.

Final outcomes:

```text
healthy
update-required
degraded
blocked
```

`status` may say that a deeper `inspect` or `doctor` is required when evidence is stale.

## 5. `inspect`

Purpose: obtain the complete observed evidence required to calculate desired-state differences safely.

It inspects:

- supported OS and PowerShell evidence;
- installed component versions and installation sources where knowable;
- OpenCode global config, project-independent asset state and active provenance layers;
- OpenRouter credentials presence without exposing secrets;
- managed OpenRouter preset state;
- RTK and Graphify installation/integration;
- observability process/storage/health evidence;
- private local override existence and schema validity;
- managed resource ownership, targets and content identities.

Output contains facts and diagnostics only. It does not propose mutations beyond remediation hints.

## 6. `plan`

Purpose: compare canonical desired state with a fresh inspection and serialize the exact operations required to converge.

Pipeline:

```text
inspect
→ resolve desired state
→ validate ownership and preconditions
→ calculate normalized diff
→ order operations and dependencies
→ calculate plan hash
→ emit plan
```

A plan records at minimum:

```text
plan_schema_version
plan_id
plan_hash
created_from_observed_state_hash
desired_state_hash
operations[]
diagnostics[]
requires_approval
```

Operation entries record:

```text
operation_id
resource_id
action
current_identity
desired_identity
backup_required
reversible
consequences
verification
```

Allowed initial actions:

```text
create
render
copy
adopt
install
invoke-upstream
create-remote-version
start
stop
retire
```

`delete-unknown` is not a valid action.

If `--out <file>` is provided, the serialized plan is written there after all validations succeed. The plan file contains no credentials.

## 7. `apply`

Purpose: execute an approved deterministic plan.

Behaviour:

1. load a supplied plan or recompute a fresh plan;
2. re-inspect evidence needed to detect staleness;
3. verify plan and observed-state hashes;
4. require approval if any mutation exists;
5. execute operations in dependency order;
6. create required backups before replacement/adoption;
7. verify each operation;
8. stop broad mutation after a blocking failure;
9. record partial results and resulting state;
10. run final health verification for affected components.

A plan is stale when a relevant target, ownership record, desired input or upstream state changed after planning. Stale plans are blocked and must be regenerated.

`--yes` is invalid as a general future approval. It applies only to the current plan hash printed or supplied during the same execution.

## 8. `doctor`

Purpose: perform deeper verification and return actionable findings without mutation.

It may run synthetic, non-secret checks including:

- OpenCode config/schema/load checks;
- required agent/command discovery;
- permission fixtures;
- OpenRouter authenticated smoke tests through required roles;
- proxy/Phoenix health and trace-ingestion checks;
- RTK rewrite verification;
- Graphify parse/freshness/quality checks;
- schema and link validation for project context;
- canonical verification manifest commands for `project doctor`.

`doctor` never repairs. Remediation points to an explicit `plan`, `apply`, component lifecycle command or manual action.

## 9. `install`

Purpose: convenience orchestration for first-time personal environment convergence.

Equivalent semantic flow:

```text
inspect
→ plan
→ show plan
→ approve
→ apply
→ doctor
```

`install` does not bypass the normal plan/apply contract and does not have a separate mutation engine.

Second execution on an in-sync environment is a no-op plus verification.

## 10. `init-project`

Purpose: create the deterministic portable scaffold for a new or freshly initialized repository.

Preconditions:

- target path exists or can be created;
- target is empty, or contains only an accepted fresh-Git baseline;
- no conflicting portable state already exists;
- no dual OpenCode root configuration ambiguity exists.

Flow:

```text
inspect target
→ calculate scaffold plan
→ show created/rendered files
→ approve
→ initialize Git when absent and safe
→ materialize canonical project scaffold
→ write initial project state
→ verify native OpenCode discovery
→ report next action: enter OpenCode and run /init-project
```

The CLI does not answer semantic project questions. `/init-project` inside OpenCode owns purpose, stack, architecture, LSP/formatter, verification commands, final Graphify ignore decisions and first useful graph.

Arbitrary legacy-repository adoption remains out of scope.

## 11. `project status` and `project doctor`

`project status` reports:

- lifecycle state;
- context completeness;
- OpenCode config/assets state;
- verification summary;
- Graphify freshness and quality state;
- unresolved durable decisions;
- last known readiness result.

`project doctor` performs the canonical readiness checks and never mutates.

A project is `ready` only when the predicates defined by `VER-05` pass.

## 12. Observability commands

### `start`

Starts only the accepted managed observability components, in dependency order, after port/process identity checks.

### `stop`

Stops only processes proven to be managed by portable-opencode.

### `status`

Reports proxy and backend health separately, including loopback, storage, retention and last successful ingestion evidence.

### `open`

Opens the local observability UI only after health verification. It has no JSON mode because its sole purpose is an explicit UI side effect.

### `purge`

Produces the irreversible deletion plan, requires explicit approval, and never deletes unrelated directories. Full database reset requires observability to be stopped.

## 13. Operation outcomes

Every command reports exactly one final outcome:

| Outcome | Meaning |
|---|---|
| `no-op` | command completed and no mutation was needed |
| `planned` | a valid unapplied change plan exists |
| `applied` | all approved mutations and required verification completed |
| `healthy` | inspection/diagnosis found required capabilities healthy |
| `update-required` | supported but drifted/version-mismatched state requires a plan |
| `degraded` | core workflow can continue with an explicitly reduced capability |
| `blocked` | required precondition, ownership or safety condition prevents progress |
| `partial` | some approved mutations succeeded before execution stopped |
| `failed` | an external operation failed without a valid degraded continuation |
| `cancelled` | user declined or interrupted before any irreversible mutation |

`partial` is never presented as success.

## 14. Exit classes

Stable process exit classes:

| Code | Class | Typical outcomes |
|---:|---|---|
| `0` | success | `no-op`, `applied`, `healthy` |
| `2` | invalid usage/input | malformed CLI arguments or invalid supplied document |
| `10` | changes available | `planned`, `update-required` when no mutation was requested |
| `20` | degraded | `degraded` |
| `30` | blocked | missing approval, unsafe ownership, unsupported prerequisite, blocking validation |
| `40` | partial mutation | `partial` |
| `50` | external failure | package manager, upstream API, process or filesystem operation failed |
| `60` | internal invariant failure | unexpected portable-opencode bug or impossible state |

A diagnostic code carries the specific reason; exit classes remain coarse and stable for scripting.

## 15. Diagnostic model

Every finding contains:

```text
code
severity
summary
evidence
impact
remediation
resource_id when applicable
```

Severities:

```text
info
warning
error
blocker
```

Initial stable diagnostic registry:

| Code | Meaning |
|---|---|
| `POC-CORE-001` | desired state or manifest invalid |
| `POC-CORE-002` | resource ownership ambiguous |
| `POC-CORE-003` | managed resource drift detected |
| `POC-CORE-004` | supplied plan is stale |
| `POC-CORE-005` | required backup could not be created or verified |
| `POC-WIN-001` | Windows environment unsupported or unverifiable |
| `POC-WIN-002` | PowerShell prerequisite unsupported or unverifiable |
| `POC-OC-001` | OpenCode missing or not executable |
| `POC-OC-002` | OpenCode version unsupported |
| `POC-OC-003` | conflicting OpenCode configuration sources create ambiguity |
| `POC-OC-004` | active unmanaged OpenCode override affects provenance |
| `POC-OR-001` | OpenRouter authentication missing or invalid |
| `POC-OR-002` | required managed preset missing |
| `POC-OR-003` | managed OpenRouter preset drift detected |
| `POC-OBS-001` | observability component unavailable |
| `POC-OBS-002` | observability service is not loopback-only |
| `POC-OBS-003` | proxy-to-backend trace ingestion failed |
| `POC-GR-001` | Graphify missing or unsupported |
| `POC-GR-002` | project graph stale |
| `POC-GR-003` | project graph invalid or quality gate failed |
| `POC-RTK-001` | RTK missing or unsupported |
| `POC-RTK-002` | RTK OpenCode integration not effective |
| `POC-PRJ-001` | path is not a valid portable project |
| `POC-PRJ-002` | init target contains unsupported pre-existing content |
| `POC-PRJ-003` | curated context or metadata invalid |
| `POC-PRJ-004` | canonical verification failed |
| `POC-SEC-001` | secret/private data would cross a versioned or observable boundary |

New codes require a stable semantic distinction; do not create a new code for prose-only wording changes.

## 16. JSON result envelope

Human output may be concise, but `--json` emits one machine-readable result shaped conceptually as:

```json
{
  "schema_version": "0.1.0",
  "command": "plan",
  "outcome": "planned",
  "exit_class": 10,
  "changed": false,
  "plan": {},
  "diagnostics": [],
  "state": {},
  "summary": "..."
}
```

The formal envelope is `schemas/operation-result.schema.json`.

## 17. Bootstrap contract

Canonical repository entrypoint:

```text
scripts/bootstrap.ps1
```

Its only responsibility is to make the pinned portable CLI runnable from a freshly cloned repository.

It may:

- confirm the host is Windows;
- detect available PowerShell/runtime/package primitives;
- read `config/components.jsonc`;
- establish the accepted CLI package/binary in a private managed location;
- verify the CLI starts and reports its version;
- print the next command.

It must not:

- materialize OpenCode configuration;
- modify OpenRouter presets;
- install Graphify, RTK or Phoenix directly outside the CLI operation model;
- create project files;
- mutate managed resources;
- implement backups, drift resolution or state reconciliation.

The exact lowest-level PowerShell/runtime bootstrap mechanism remains evidence-gated by `SPIKE-001`, `DEC-009` and `DEC-012`. Codex may measure alternatives but may not select a new product policy inside the spike.

## 18. Implementation gate

The CLI core may be implemented after:

- `DESIGN-008` resource paths are accepted;
- state/resource/result/component schemas parse and validate fixtures;
- SPIKE-001 through SPIKE-004 return evidence for all upstream-dependent assumptions;
- `DEC-009`, `DEC-010` and `DEC-012` are resolved from that evidence.
