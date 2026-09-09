---
type: Spike Result
title: Graphify and RTK Windows Integration Contract — Result
description: Sanitized Windows-native evidence for Graphify installation, graph portability, explicit updates, hooks, RTK rewriting and degraded operation.
status: active
sources:
  - resource: ../SPIKE-004_GRAPHIFY_RTK.md
    title: Graphify and RTK Windows Integration Contract
  - resource: ../../design/GRAPHIFY_OUTPUT_POLICY.md
    title: Graphify Output Ownership Policy
  - resource: ../../design/CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: ../../design/CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: SPIKE-001_RESULT.md
    title: OpenCode Windows Lifecycle and Runtime Contract — Result
  - resource: SPIKE-002.md
    title: OpenRouter preset and policy contract result
---

# SPIKE-004 — Graphify and RTK Windows integration contract

## 1. Classification

**Final classification: `PARTIAL`.**

The native Windows installation, extraction, ignore semantics, clone/update path, RTK rewrite path, private failure tee and safe degradation are evidenced in disposable fixtures. The result is not `PASS` because the Graphify report requires `PYTHONHASHSEED=0` for byte stability, corruption requires a full rebuild, the Graphify OpenCode hook and RTK OpenCode hook were loaded but not exercised by a provider-backed OpenCode turn, and Graphify hooks are asynchronous and write private logs by default. No credential or OpenRouter surface was used.

No production Graphify installation, RTK integration, hook or cache was left active. No Graphify MCP was added.

## 2. Environment and tested versions

| Item | Evidence |
|---|---|
| Windows | Windows 11 Pro `10.0.26200`, build `26200`, x64 |
| Windows PowerShell | `5.1.26100.8457` |
| PowerShell 7 | `7.6.5` |
| Python | `3.12.2`, used through `py -3.12` |
| Git | `2.43.0.windows.1` |
| Node.js / npm | `v24.14.1` / `11.11.0` |
| OpenCode | `opencode-ai@1.18.30`, disposable npm prefix |
| Graphify | `graphifyy==0.9.56`, `graphify 0.9.56` |
| Graphify executable | `%TEMP%\\SPIKE_ROOT\\graphify-venv\\Scripts\\graphify.exe` |
| Graphify installation | Python 3.12 venv followed by `python.exe -m pip install graphifyy==0.9.56` |
| RTK | `rtk 0.48.0` from the official Windows ZIP |
| RTK executable | `%TEMP%\\SPIKE_ROOT\\rtk-portable\\rtk.exe` |
| RTK installation | `winget download --id rtk-ai.rtk --exact --version v0.48.0`, verified ZIP, extracted without global installation; upstream asset `rtk-x86_64-pc-windows-msvc.zip` |
| RTK OpenCode target | `%USERPROFILE%\\.config\\opencode\\plugins\\rtk.ts` (upstream global path; fixture copy only after the accidental isolated-profile resolution was backed up and removed) |
| Fixture policy | Synthetic repositories only, outside this repository; paths sanitized here as `%TEMP%\\SPIKE_ROOT` |

The pre-existing `opencode-ai@1.18.30` evidence from SPIKE-001 remains version-scoped and `INCONCLUSIVE` for provider-backed execution. SPIKE-002 remained unauthenticated; no OpenRouter key or request was read or used.

## 3. Graphify evidence

The main Python fixture contained connected Python modules, repeated/cross-linked symbols, `generated/`, `fixtures/`, `examples/`, `vendor/`, `data/`, `docs/generated/`, `migrations/`, a directory with spaces, and files separated between `.gitignore` and `.graphifyignore`.

Baseline with the final ignore policy produced **6 code files, 17 nodes and 28 links**. `GRAPH_REPORT.md` reported 96% extracted, 4% inferred and 0% ambiguous relationships. `god-nodes --json` identified `CoreService` (6), `Item` (5), `format_item()` (4), `normalize()` (4), `handle()` (3) and `cross_call()` (3). `diagnose multigraph --json` reported zero dangling endpoints, zero duplicate edges and zero collapsed same-endpoint groups.

Changing only `.graphifyignore` demonstrated the quality effect:

| Fixture policy | Code files | Nodes | Links | Observation |
|---|---:|---:|---:|---|
| `.gitignore` plus final `.graphifyignore` | 6 | 17 | 28 | Useful connected graph; generated/vendor/data noise excluded |
| Only `graphify-out/` in `.graphifyignore` | 9 | 23 | 31 | `examples/`, `fixtures/` and `graphify-only/` enter the graph |
| Same policy with `--no-gitignore` | 14 | 32 | 35 | `generated/`, `vendor/`, `data/` and `git-only/` enter the graph; noncanonical control only |

### GR-01 through GR-08

| Contract | Claim tested | Version/environment | Evidence | Result | Impact |
|---|---|---|---|---|---|
| `GR-01` | Native install/version and OpenCode integration | Windows 11; Python 3.12; Graphify `0.9.56`; OpenCode `1.18.30` | Venv/pip install and `graphify --version` passed. `graphify opencode install` wrote only disposable `AGENTS.md`, `.opencode/plugins/graphify.js` and `.opencode/opencode.json`; OpenCode `debug config` exited 0 and discovered the plugin. Second install was unchanged; uninstall removed the plugin and deregistered it. | `pass` | Installation is upstream-owned and queried. The generated `.opencode/opencode.json` is not the canonical root `opencode.jsonc` policy. |
| `GR-02` | First useful graph after a source baseline | Graphify `0.9.56`, `--code-only --no-cluster` | Extraction exited 0 with 17 nodes/28 links; `cluster-only --no-label --no-viz` generated `GRAPH_REPORT.md`; query/path, god-node and multigraph diagnostics were usable. | `pass` | The portable workflow can use explicit code-only extraction without credentials; semantic LLM enrichment remains optional/unproven. |
| `GR-03` | Ignore policy improves graph quality | Same fixture, Windows paths | Final policy excluded output, generated, vendor, data, fixtures, examples and selected docs; controlled comparisons changed 17→23→32 nodes. Wildcards, negation, nested paths and names with spaces were observed. | `pass` | `/init-project` must preserve explicit ambiguous-directory decisions in `.graphifyignore`. |
| `GR-04` | `.gitignore` is respected; `--no-gitignore` is explicit only | Graphify `0.9.56` | A git-only file was excluded under normal extraction and included only in the isolated `--no-gitignore` control. `.graphifyignore` remained an additional layer and did not reintroduce git-ignored files. | `pass` | Never make `--no-gitignore` canonical. |
| `GR-05` | Version only useful, private-free and stable outputs | Same source/config; `PYTHONHASHSEED=0` for cluster/report | `graph.json` and `manifest.json` were byte-identical on repeated identical runs. `GRAPH_REPORT.md` changed only in the tied god-node order without the seed; two runs with `PYTHONHASHSEED=0` were byte-identical. Graph/manifest contained relative paths and no absolute user paths. Clone retained all three accepted outputs and parsed them. | `partial` | Accept the allowlist with the deterministic seed as an explicit update precondition. Do not version `.graphify_root`, `.graphify_analysis.json`, cache, HTML, cost or query logs. |
| `GR-06` | Explicit update and clone/incremental lifecycle | Graphify `0.9.56`, cloned fixture | Clone plus `check-update` passed. Adding a function and running `graphify update . --no-cluster` changed the graph 17→20 nodes. Deleting a source file updated the manifest and graph. Corrupt `graph.json` exited 1 and required a full rebuild; missing `manifest.json` rebuilt successfully but caused structural churn. | `partial` | Explicit update is accepted with quality/repair gates; corruption is `blocked` until rebuild, while missing manifest is `degraded` and rebuildable. |
| `GR-07` | Hooks are inspectable and recoverable without becoming canonical | Disposable fixture only | `graphify hook install` created `post-commit`, `post-checkout` and a `graphify` merge driver. Commit hook latency was about 495 ms and the hook launched a background rebuild with a private cache log. `hook uninstall` removed hooks and `.gitattributes`; no real repository was touched. | `partial` | Hooks remain deferred for MVP: asynchronous side effects, private logs and no demonstrated repeated benefit outweigh automatic freshness. |
| `GR-08` | Freshness and quality signals are visible | Graphify `0.9.56`; report/diagnose/check-update | Report exposed freshness commit, extraction ratio, communities, god nodes and gaps; `check-update` and diagnostics were usable. Portable project state is not yet implemented, so no runtime state transition was claimed. | `partial` | Implement `POC-GR-002`/`POC-GR-003` around these upstream signals; do not infer readiness from process exit alone. |

## 4. RTK evidence

Representative rewriting used the official `rtk rewrite` registry. `git push origin main` rewrote to `rtk git push origin main`; a configured `git status` exclusion returned no rewrite; unsupported commands returned no rewrite. Exit status of the wrapped failing pytest command remained non-zero.

### RTK-01 through RTK-05

| Contract | Claim tested | Version/environment | Evidence | Result | Impact |
|---|---|---|---|---|---|
| `RTK-01` | Native Windows binary installation and identity | Windows 11; RTK `0.48.0` | `winget` found `rtk-ai.rtk` v0.48.0 and downloaded the verified official Windows ZIP; extracted `rtk.exe` ran from PowerShell and reported `rtk 0.48.0`. No global package installation was needed. | `pass` | Pin the tested release and verify `rtk gain`, not only the executable name, to avoid the unrelated Rust Type Kit collision. |
| `RTK-02` | Native OpenCode integration and rewrite path | RTK `0.48.0`; OpenCode `1.18.30` | `rtk init -g --opencode` reported the exact upstream plugin path and wrote a TypeScript plugin using `tool.execute.before` and `rtk rewrite`. OpenCode loaded a disposable copy with exit 0. The plugin disabled itself cleanly when `rtk` was absent from `PATH`. A provider-backed tool turn was not available. | `partial` | Invoke the upstream lifecycle and verify plugin discovery; mark the integration degraded if the binary is absent. Do not implement a competing rewrite layer. |
| `RTK-03` | Minimal config and exclusions | RTK `0.48.0`, temporary global config backed up/restored | `hooks.exclude_commands = ["git status"]` prevented that rewrite while the allowed `git push` rewrite remained active. Config contained no secrets and was removed/restored after the test. | `pass` | Keep exclusions narrow and private/config-driven; expose invalid config as a doctor finding. |
| `RTK-04` | Full raw failure output is private and failures-only | RTK `0.48.0`, synthetic pytest fixture | `rtk pytest -q -s` reduced a 200-line synthetic failure to 652 visible characters/15 lines and created one `%TEMP%` tee file of 5,426 bytes containing the full synthetic output, assertion and no absolute user path. A successful test kept the tee count unchanged. | `pass` | Configure `RTK_TEE_DIR`/private recall storage outside Git; never expose or version the tee file. |
| `RTK-05` | Gain is useful and failure degrades optimization only | RTK `0.48.0`, project-scoped synthetic stats | `rtk gain --project --format json` exited 0 and reported 3 commands, 2,596 estimated saved bytes and 94.78% average savings. Missing RTK caused only a plugin-disabled warning; OpenCode `debug config` and raw `git status` still exited 0. | `pass` | RTK health is diagnostic/degraded, never a project-readiness blocker. |

## 5. Decisions and contract impact

```text
Graphify exact version: 0.9.56
Graphify install mechanism: Python 3.12 isolated venv + pip install graphifyy==0.9.56
Graphify versioned outputs: graphify-out/graph.json, graphify-out/GRAPH_REPORT.md, graphify-out/manifest.json
manifest.json: accept conditionally for pinned Graphify 0.9.56; relative paths/private-path check required
explicit update workflow: accepted with quality gate; corrupt graph requires full rebuild
hooks for MVP: remain deferred
RTK exact version: 0.48.0
RTK install mechanism: winget official release ZIP download/extraction; place rtk.exe on PATH
RTK OpenCode integration path: rtk init -g --opencode → %USERPROFILE%\.config\opencode\plugins\rtk.ts; plugin delegates to rtk rewrite through tool.execute.before
RTK failure policy: degraded
DESIGN-003 corrections: deterministic seed precondition; accepted manifest is conditional; ignore auxiliary Graphify outputs
DESIGN-008 corrections: Graphify package is private queried installation; RTK/OpenCode plugin is upstream-owned queried integration; manifest is no longer pending portability evidence
component manifest updates: validate graphify 0.9.56 and rtk 0.48.0 with pinned mechanisms; retain OpenCode/OpenRouter/Phoenix pending states
new blocker: no product blocker; provider-backed OpenCode hook invocation and implementation-level state/doctor tests remain follow-up evidence
```

### Final Graphify allowlist

Version only:

```text
graphify-out/graph.json
graphify-out/GRAPH_REPORT.md
graphify-out/manifest.json
```

Ignore `graphify-out/graph.html`, `graphify-out/cache/`, `graphify-out/cost.json`, query logs, `.graphify_root`, `.graphify_analysis.json`, memory/reflection directories and optional HTML/SVG/GraphML/Cypher/wiki exports. `.graphifyignore` must contain `graphify-out/`.

`manifest.json` is accepted because the tested schema used relative source keys, had no absolute user/profile path or machine identifier, survived a clone to another Windows path and supported incremental update. Its `mtime`/`seen` freshness fields are expected churn and must not be treated as a stable content hash.

### Failure policy

The project core remains usable when Graphify or RTK optimization is unavailable, but the diagnostics differ:

- missing/unsupported Graphify: `POC-GR-001`; missing graph blocks initial `ready`, stale graph is `POC-GR-002`, corruption or unexplained severe shrink is `POC-GR-003`/`blocked` until rebuilt;
- missing/broken RTK or ineffective OpenCode plugin: `POC-RTK-001`/`POC-RTK-002`, outcome `degraded`, exit class `20`; command execution must pass through unchanged;
- RTK savings and `gain` never gate project readiness.

## 6. Cleanup and discard boundary

The Graphify venv, RTK ZIP/extraction, npm prefix, OpenCode profiles, fixture repositories, hook files, tee files, temporary configs, private global-backup copies and disposable processes are cleanup-only artefacts and must not be committed. The accidental global RTK OpenCode plugin write was backed up privately, removed with the upstream uninstall command and verified absent. No OpenRouter credential, preset, real repository hook or real project graph was read or changed. No commit or push was performed.

## 7. Follow-up

Implement only the adapters and diagnostics justified here: private Graphify installation/version inspection, explicit update with `PYTHONHASHSEED=0`, allowlist/private-output validation, rebuild recovery and upstream RTK lifecycle/doctor checks. Do not add Graphify MCP, automatic hooks or an alternative RTK filter layer. Provider-backed OpenCode integration remains a later authorized test, without OpenRouter credentials in this spike.
