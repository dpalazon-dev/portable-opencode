---
type: Spike
id: SPIKE-004
title: Graphify and RTK Windows Integration Contract
description: Bounded experiment for native installation, OpenCode integration, graph portability, output policy, command rewriting and recovery.
status: active
sources:
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
  - resource: ../research/CONFIGURATION_SURFACE_RESEARCH.md
    title: Configuration Surface Research
  - resource: ../design/GRAPHIFY_OUTPUT_POLICY.md
    title: Graphify Output Ownership Policy
  - resource: ../design/CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: ../design/CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
---

# SPIKE-004 — Graphify and RTK Windows integration contract

## 1. Decision question

Can Graphify and RTK be installed and integrated natively on Windows so Graphify provides portable structural memory and RTK reduces agent terminal noise without hidden state, unsafe hooks or unrecoverable changes?

## 2. Decisions and contracts informed

This spike provides evidence for:

- `DEC-004` Graphify as a core subsystem;
- `DEC-019` Graphify versioned output allowlist;
- `DESIGN-003` graph output ownership and portability;
- `DESIGN-007` upstream-owned integration/resource handling;
- `DESIGN-008` project/environment resource paths;
- `DESIGN-009` inspection, doctor and explicit lifecycle behaviour;
- matrix contracts `GR-01` through `GR-08`, `RTK-01` through `RTK-05`, plus relevant `CLI`, `CTX`, `SEC` and `VER` contracts.

## 3. Hypotheses

Test, do not assume:

1. Graphify installs and runs natively from PowerShell without WSL;
2. its OpenCode integration can be installed/verified through supported native commands;
3. `.graphifyignore` behaves predictably with `.gitignore` on Windows paths;
4. the first graph can be generated from a deliberately scoped fixture without including generated/private content;
5. `graph.json` and `GRAPH_REPORT.md` are stable enough to version;
6. `manifest.json` is portable and contains no private absolute paths;
7. clone plus incremental update works as intended;
8. explicit graph updates are reliable enough before hooks are considered;
9. hook installation/recovery can be understood without enabling hooks by default;
10. RTK installs as a native Windows binary and its identity/version can be inspected;
11. `rtk init -g --opencode` or the current supported equivalent produces a verifiable OpenCode integration;
12. RTK rewrites supported commands while respecting exclusions;
13. full raw output can be preserved privately for failures without defeating context reduction;
14. RTK failure can degrade optimization without blocking core project readiness.

## 4. Scope

### In scope

Graphify:

- native install/version;
- OpenCode integration/install command;
- `.gitignore` interaction;
- `.graphifyignore` semantics;
- explicit extraction/update;
- output set;
- deterministic/stable regeneration;
- graph quality evidence;
- manifest portability/private-path checks;
- clone/incremental update;
- generated-output self-exclusion;
- optional hook mechanics and recovery, without making hooks canonical.

RTK:

- native install/version;
- native OpenCode integration;
- representative command rewriting;
- exclusions;
- failure/raw-output tee behaviour;
- gain/statistics;
- disable/remove/recovery behaviour where upstream supports it.

### Out of scope

- automatic idle graph updates in production;
- Graphify MCP as a required core component;
- committing graph HTML/cache/cost/query logs;
- alternate graph engines;
- rewriting RTK command filtering ourselves;
- treating RTK savings as a readiness gate;
- WSL/Linux/macOS parity.

## 5. Safety and isolation

Use disposable fixture repositories and temporary global integration backups.

Before an upstream installer mutates OpenCode global assets:

1. inspect exact target files;
2. create private backups;
3. record hashes;
4. restore at spike completion unless the owner explicitly keeps the tested integration.

Do not:

- graph repositories containing real secrets;
- commit Graphify cost/query logs;
- expose raw RTK failure output containing private machine data;
- enable automatic hooks in the owner's real repositories;
- overwrite unrelated OpenCode plugins/config;
- use `--no-gitignore` except in a deliberate isolated fixture test.

## 6. Required environment record

Record:

```text
Windows edition/build
PowerShell version
Python/uv or package mechanism used by Graphify
Graphify exact version
RTK exact version and executable path
OpenCode exact version
Git exact version
fixture paths sanitized in committed evidence
```

## 7. Fixture repository

Create a synthetic repository containing:

```text
fixture-graph/
├── .gitignore
├── .graphifyignore
├── src/
│   ├── small connected modules
│   └── deliberately repeated/cross-linked symbols
├── generated/
├── fixtures/
├── examples/
├── vendor/
├── data/
├── docs/generated/
├── graphify-out/
└── package/build/cache directories appropriate to the fixture stack
```

The ambiguous directories intentionally exercise the future `.graphifyignore` decision model.

Include enough source structure to evaluate nodes, edges, communities and god-node reporting without creating a huge graph.

## 8. Graphify procedure

### Test group A — Native installation and identity

1. install the current tested Graphify package/mechanism natively from PowerShell;
2. prove command discovery from a fresh shell;
3. record exact version and executable/module location;
4. record upgrade/uninstall primitives without removing unrelated Python tooling;
5. test the documented OpenCode-specific installer/integration if separate;
6. inspect every global/project file it changes.

The result must determine what portable-opencode can safely treat as upstream-owned queried integration.

### Test group B — Baseline extraction

1. initialize the fixture Git repository;
2. run Graphify using normal `.gitignore` behaviour;
3. record exact standard output set;
4. parse `graph.json` and report node/edge counts;
5. inspect `GRAPH_REPORT.md` usefulness;
6. confirm generated Graphify output does not feed back into source extraction after `.graphifyignore` includes `graphify-out/`.

### Test group C — `.gitignore` and `.graphifyignore`

Exercise:

- file ignored only by `.gitignore`;
- file ignored only by `.graphifyignore`;
- nested Windows path;
- wildcard;
- negation where upstream supports it;
- directory names with spaces;
- intentionally ambiguous directories such as `generated/`, `fixtures/`, `examples/`, `migrations/`, `schemas/`, `vendor/`, `legacy/`, `notebooks/`, `scripts/`, `data/`, `docs/generated/` as applicable to the fixture.

For one isolated control, test `--no-gitignore` only to prove that `.gitignore` exclusions are otherwise respected. Do not make that flag part of the canonical workflow.

The result must produce concrete Windows path/ignore semantics for the generator.

### Test group D — Graph quality

Evaluate at minimum:

```text
source coverage
unclassified files
unexpected generated/vendor nodes
god nodes
community usefulness
obvious missing relationships
obvious false/noisy relationships
```

Change `.graphifyignore` deliberately and compare before/after graph quality. Evidence should show why ignore refinement matters rather than treating a successful command exit as sufficient.

### Test group E — Output determinism and Git suitability

With identical source and configuration:

1. generate graph/output twice from clean equivalent fixture state;
2. normalize only documented nondeterministic metadata if necessary;
3. compare `graph.json`;
4. compare `GRAPH_REPORT.md`;
5. compare `manifest.json` if produced;
6. identify ordering/timestamp/noise fields;
7. estimate diff churn for a small real structural change.

Acceptance does not require byte-identical output if differences can be safely normalized or explained, but unexplained structural churn blocks automatic versioning claims.

### Test group F — Manifest portability and privacy

If `manifest.json` exists:

- inspect every path/reference;
- search for absolute user/profile paths;
- search for machine-specific identifiers;
- clone/copy fixture to a different absolute Windows path;
- attempt the supported incremental/update flow from the cloned location;
- determine whether manifest re-anchoring works as documented.

If portability fails, `manifest.json` must be removed from the versioned allowlist rather than patched heuristically.

### Test group G — Explicit update lifecycle

1. create baseline graph;
2. modify one structural relationship;
3. mark conceptual graph state dirty;
4. run the explicit native update path;
5. prove expected structural change appears;
6. delete/rename a source file and update again;
7. record corruption/interruption behaviour;
8. determine when a full rebuild is required.

This must justify `GR-06` before hook automation is considered.

### Test group H — Clone and recovery

1. clone the fixture repository including only the accepted versioned Graphify outputs;
2. verify graph/report/manifest parse before update;
3. query/use existing graph where supported;
4. perform incremental update;
5. simulate missing manifest;
6. simulate corrupt graph;
7. record degraded versus blocked outcomes according to `DESIGN-003`.

### Test group I — Hook mechanics

In the disposable fixture only:

- inspect available Graphify hook installer(s);
- record files/hooks modified;
- test install and clean removal/restore;
- trigger one relevant hook and measure latency/side effects;
- test failure behaviour;
- look for self-trigger loops or repeated updates.

Do not recommend enabling hooks by default unless explicit update workflow has already passed and hooks show a concrete repeated benefit with low risk.

## 9. RTK procedure

### Test group J — Native installation and identity

1. install the current supported RTK Windows binary through the tested upstream mechanism;
2. prove command discovery in a fresh PowerShell session;
3. record exact version and executable path;
4. inspect upgrade/remove primitives;
5. verify installation does not require WSL.

### Test group K — OpenCode integration

1. back up any affected global OpenCode integration file;
2. run `rtk init -g --opencode` or the current documented equivalent;
3. inspect the exact file(s)/plugin(s) created or changed;
4. restart OpenCode/fresh shell as required;
5. prove the integration is active through a representative supported command;
6. run integration a second time and test idempotence;
7. restore/remove in the fixture path and prove recovery.

The result must establish whether portable-opencode should invoke RTK natively and record the integration as upstream-owned.

### Test group L — Rewrite behaviour

Choose representative commands from categories RTK claims to support, using synthetic fixture output.

For each:

```text
raw command
RTK-rewritten/effective command
raw output size
reduced output size
exit code preservation
stderr/error preservation
```

Verify unsupported commands pass through unchanged.

### Test group M — Exclusions

Configure a minimal private RTK TOML with at least one explicit exclusion.

Prove:

- excluded command is untouched;
- allowed supported command is rewritten;
- invalid config produces an understandable failure/degraded state;
- project secrets are not required in config.

### Test group N — Failure raw-output preservation

Using a synthetic command that fails with verbose output:

1. enable the tested raw-output tee mechanism;
2. ensure agent-visible output remains compact enough;
3. prove full failure output is preserved privately;
4. inspect the file for absolute paths/private data and define redaction/privacy implications;
5. verify the tee path stays outside Git;
6. verify success output does not create unnecessary raw logs if the intended policy is failures-only.

If upstream cannot support failures-only directly, record the smallest safe configuration or adaptation required without implementing a competing filter layer.

### Test group O — Gain and degradation

1. query `rtk gain` or the current equivalent after representative commands;
2. record whether statistics are useful and stable enough for `doctor`;
3. disable/break RTK integration deliberately in the fixture;
4. prove OpenCode still executes commands normally or identify the exact failure mode;
5. determine the diagnostic that should mark optimization degraded rather than project blocked.

## 10. Required evidence tables

The result must include:

### Graphify

One row for each `GR-01` through `GR-08`:

```text
contract
claim tested
version/environment
evidence
result: pass | fail | partial | unverified
impact
```

### RTK

One row for each `RTK-01` through `RTK-05` with the same fields.

## 11. Acceptance criteria

### Graphify acceptance

Graphify remains a core subsystem only if:

- Windows-native install/identity is reliable;
- explicit extraction/update works;
- `.gitignore`/`.graphifyignore` semantics are predictable enough to generate a useful policy;
- source scope can exclude generated/private output;
- `graph.json` and `GRAPH_REPORT.md` are useful and sufficiently stable to version;
- severe graph shrink/noise can be detected;
- clone/recovery behaviour is understood;
- manifest portability is either proven or the manifest is removed from the allowlist;
- explicit updates are reliable before hooks;
- no secrets/private machine state appear in accepted versioned outputs.

### RTK acceptance

RTK remains canonical optimization if:

- native Windows install works;
- native OpenCode integration works and is inspectable;
- representative supported commands are reduced without changing semantics/exit codes;
- exclusions work;
- failure evidence can be preserved privately enough for debugging;
- missing/broken RTK can be reported as degraded optimization rather than corrupting command execution.

## 12. Decision impact

The result must end with:

```text
Graphify exact version: value | blocked
Graphify install mechanism: value
Graphify versioned outputs: final allowlist
manifest.json: accept | reject | inconclusive
explicit update workflow: accepted | blocked
hooks for MVP: remain deferred | evidence supports reconsideration
RTK exact version: value | blocked
RTK install mechanism: value
RTK OpenCode integration path: exact evidence
RTK failure policy: degraded | blocking with reason
DESIGN-003 corrections: none | list
DESIGN-008 corrections: none | list
component manifest updates: exact values
new blocker: yes | no
```

Do not activate hooks or add Graphify MCP to core merely because the spike proves they can run.

## 13. Deliverables

Required:

```text
docs/spikes/results/SPIKE-004.md
```

Optional safe reusable evidence:

```text
spikes/SPIKE-004/fixtures/
spikes/SPIKE-004/scripts/
```

Do not commit cache, cost data, query logs, raw failure logs or machine-private Graphify output.

## 14. Codex assignment contract

Execute on a dedicated branch conceptually named:

```text
spike/004-graphify-rtk
```

Rules for Codex:

- read `DESIGN-003`, `DESIGN-007`, `DESIGN-008`, `DESIGN-009` and this spike first;
- use native Windows/PowerShell only;
- use synthetic disposable repositories;
- use upstream installers/integrations before custom code;
- back up global OpenCode files before RTK/Graphify integration changes;
- do not enable hooks in real repositories;
- do not commit private/generated noise;
- measure graph quality, not only command success;
- prove clone/portability rather than assuming it;
- treat RTK as an optimization whose failure should remain narrow where possible;
- finish with exact component-manifest values and contract corrections.

## 15. Discard boundary

Temporary integrations, caches, hook installations, fixture graphs and raw RTK logs are disposable. Preserve only sanitized result evidence, small regression fixtures and separately approved changes to canonical policy.
