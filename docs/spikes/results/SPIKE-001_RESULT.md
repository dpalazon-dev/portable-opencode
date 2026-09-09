---
type: Spike Result
title: OpenCode Windows Lifecycle and Runtime Contract — Result
description: Sanitized evidence from a bounded native-Windows OpenCode lifecycle experiment.
status: active
sources:
  - resource: ../SPIKE-001_OPENCODE_LIFECYCLE.md
    title: OpenCode Windows Lifecycle and Runtime Contract
  - resource: ../../design/EVIDENCE_AND_SPIKE_MAPPING.md
    title: Evidence and Spike Mapping
  - resource: ../../context/ROADMAP.md
    title: Portable OpenCode Roadmap
---

# SPIKE-001 — OpenCode Windows lifecycle and runtime contract

## 1. Outcome

The tested Windows-native path is technically viable for configuration discovery, asset loading, permissions, local server startup and session metadata. The spike is `INCONCLUSIVE`, not a production acceptance: authenticated model execution, auth-store behavior, real command/subtask execution, watcher events, formatter execution, long-session compaction and organization-managed configuration were not proven without using credentials or inventing metrics.

The tested package was `opencode-ai@1.18.30`, installed with npm under a disposable prefix outside the repository. No supported version was added to `config/components.jsonc`.

## 2. Repository and CI preconditions

- `601d068d6232e02e01a64d9ed15d6ac5de65f752` is an ancestor of `origin/main`.
- The direct CI run for `601d068` failed at repository validation: [run 34339181175](https://github.com/dpalazon-dev/portable-opencode/actions/runs/34339181175).
- That failure was followed by `1c90a518` (green, [run 34339325620](https://github.com/dpalazon-dev/portable-opencode/actions/runs/34339325620)) and `fde157d` on `origin/main` (green, [run 34339478515](https://github.com/dpalazon-dev/portable-opencode/actions/runs/34339478515)).
- The current `origin/main` CI gate was therefore green when the spike started; the historical failure remains recorded rather than hidden.

## 3. Environment and procedure

Environment:

| Item | Observed value |
|---|---|
| OS | Microsoft Windows 11 Pro, version `10.0.26200`, build `26200` |
| Architecture | x64-based PC |
| Windows PowerShell | `5.1.26100.8457` |
| PowerShell 7 | `7.6.5` (`pwsh` available) |
| Node.js | `v24.14.1` |
| npm | `11.11.0` |
| Git | `2.43.0.windows.1` |
| OpenCode | `1.18.30` from `opencode-ai@1.18.30` |
| Terminal | Windows PowerShell invoked from the Codex desktop terminal |
| Installation | `npm install --prefix <SPIKE_ROOT> opencode-ai@1.18.30 --no-audit --no-fund`; executed through `npm exec --prefix <SPIKE_ROOT>` |

The fixture used an isolated `HOME`, `USERPROFILE`, `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_CACHE_HOME`, `TEMP` and `TMP`, with synthetic `AGENTS.md`, `opencode.jsonc`, agents, commands, skills, plugins and a TypeScript file. The fixture and package prefix were outside the repository and were removed after evidence capture.

The tested CLI surfaces included `debug paths`, `debug config`, `debug agent`, `debug lsp`, `debug skill`, `agent list`, `session list`, `serve`, `upgrade --help`, `uninstall --help` and `export --help`.

## 4. Observed paths and precedence

`opencode debug paths` resolved the isolated Windows paths as:

| Surface | Observed path pattern |
|---|---|
| Global config | `%USERPROFILE%\.config\opencode` |
| Data | `%USERPROFILE%\.local\share\opencode` |
| State | `%USERPROFILE%\.local\state\opencode` |
| Cache/bin | `%USERPROFILE%\.cache\opencode` and `%USERPROFILE%\.cache\opencode\bin` |
| Temp | `%TEMP%\opencode` |

The following harmless markers were observed in resolved configuration:

| Layer | Evidence | Result |
|---|---|---|
| Global config | `GLOBAL_MARKER.md` and global permission defaults appeared | PASS |
| `OPENCODE_CONFIG` | `CUSTOM_MARKER.md` appeared between global and project markers | PASS |
| Root project config | `PROJECT_MARKER.md` appeared and overrode the conflicting bash rule | PASS |
| Nested working directory | Running from `nested\src` still found the Git-root project config | PASS |
| `OPENCODE_CONFIG_DIR` | Agents and commands from a custom directory were discovered | PASS |
| `OPENCODE_CONFIG_CONTENT` | `INLINE_MARKER.md` appeared last and its conflicting bash rule won | PASS |
| Remote organizational config | No authenticated organization surface was exercised | NOT TESTED |
| Managed Windows config | `%ProgramData%\opencode` was absent; no system directory was modified | NOT TESTED |

Additional version-specific observations:

- A root `opencode.json` alone was discovered and merged.
- A root `opencode.json` and `opencode.jsonc` together did not produce an ambiguity error in `1.18.30`; their non-conflicting `instructions` entries were both present. The repository's blocking-ambiguity policy is therefore not demonstrated for this version.
- `.opencode\opencode.jsonc` was loaded after the root config and its marker was present. It is a valid observed configuration layer in this version, even though the canonical repository layout keeps the project runtime config at the root.
- Configuration is loaded at process startup; no hot-reload behavior was claimed from these one-shot CLI processes.

These observations are evidence for a review of `DESIGN-008` and the `opencode` policy fields in project state. They do not by themselves change the canonical product layout.

## 5. Assets, agents, commands and permissions

`debug config` and `agent list` discovered built-in agents (`build`, `plan`, `general`, `explore`) plus fixture `review` and `verify`, fixture `review` and `verify` commands, and the on-demand `spike-fixture` skill.

The fixture agents were loaded as `subagent` after writing Markdown without a Windows PowerShell 5.1 UTF-8 BOM. With the BOM-producing encoding, the frontmatter was retained in the prompt and the mode fell back to `all`. This is a Windows fixture-encoding hazard that requires a dedicated implementation test; it is not silently treated as an OpenCode product defect.

For the corrected fixture, `debug agent` showed:

- `review` and `verify`: `edit=* deny`, `bash=* deny`, and their safe specific command allowed after the wildcard;
- `review`: `bash=git diff allow` as the last matching rule;
- `verify`: `bash=git status allow` as the last matching rule;
- both custom agents had `tools.edit=false`;
- built-in agent permissions were merged with project/global permissions.

This proves configuration-level non-mutating restrictions and last-match ordering. It does not prove an LLM will always choose the intended agent or complete a command without a provider.

## 6. Shell, LSP, formatter, watcher and compaction

- `pwsh` was available at `7.6.5`, and the resolved project config accepted `shell: "pwsh"`.
- `lsp: true` resolved successfully; `debug lsp diagnostics` on the synthetic TypeScript file returned `{}`. No diagnostic was generated, but no independent proof of a useful language-server process was captured. Classification: `INCONCLUSIVE`.
- `formatter: true` resolved successfully. No authenticated agent edit or direct formatter invocation was performed. Classification: `NOT TESTED`.
- Watcher ignores for `.portable-opencode/**` and `graphify-out/**` resolved in the config. No event stream or file-change notification was captured. Classification: `INCONCLUSIVE`.
- Compaction options (`auto`, `prune`, `reserved`) resolved in the config. Empty synthetic sessions exposed token counters but no context limit, utilization, compaction count or compaction event. Classification: `INCONCLUSIVE`.

No context-pressure percentage was calculated. For two empty synthetic sessions, the observed session metadata contained `tokens.input=0`, `tokens.output=0`, `tokens.reasoning=0` and `tokens.cache.read/write=0`; these values are not evidence of a context limit.

## 7. Plugins, server and sessions

A disposable `.opencode/plugins/spike-plugin.js` was auto-discovered. Its `config` hook set a synthetic marker visible in `debug config`, proving plugin loading and config-hook execution. Adding a syntactically broken disposable plugin did not prevent `debug config` from exiting successfully; the broken plugin was listed in the discovered plugin surface while the valid plugin marker remained active. No event payload catalogue or throwing event hook was tested.

`opencode serve --port 4097 --hostname 127.0.0.1 --pure` started successfully and exposed `/global/health` with `healthy=true` and version `1.18.30`. The server warned that `OPENCODE_SERVER_PASSWORD` was unset; it was used only on loopback in the isolated fixture and was stopped after the test.

Two synthetic sessions were created through the local server. Both exposed an ID, title, directory, project ID, timestamps, version and token counters. They remained listable after server stop/restart through the isolated state, and `opencode session list` recovered both titles. This demonstrates native session records and basic parallel session coexistence, not full parallel TUI or conversational recovery.

Unverified session fields include history continuity after a real model turn, agent identity after recovery, context summaries and compaction correlation. No multiplexer was introduced.

## 8. Materialization modes on Windows

All operations targeted the disposable `<SPIKE_ROOT>\materialization` tree:

| Mode | Observation | Result |
|---|---|---|
| `copied` | Source changed from `SOURCE_V1` to `SOURCE_V2`; copied target remained `SOURCE_V1` until explicitly recopied | PASS |
| `rendered` | `Hello {{NAME}}` rendered to `Hello SPIKE` | PASS |
| Symbolic link | `New-Item -ItemType SymbolicLink` failed with `UnauthorizedAccessException` under the current Windows privilege/developer-mode state | FAIL |
| Junction alternative | `New-Item -ItemType Junction` succeeded and writes through the junction reached the source | PASS |

The evidence supports copied/rendered defaults and keeps linked materialization exceptional. It does not justify silently substituting junctions for symbolic links; the future CLI must identify the link type and privilege requirement explicitly.

## 9. Contract classification

| Contract | Claim tested | Classification | Impact |
|---|---|---|---|
| OC-01 | Native installation and version detection | PASS | npm prefix installation and fresh child PowerShell detection are reproducible |
| OC-02 | Global config path and load | PASS | `%USERPROFILE%\.config\opencode` equivalent observed in isolation |
| OC-03 | Root project config discovery | PASS | JSON/JSONC root and Git-root traversal observed |
| OC-04 | Config precedence and provenance | PASS | Global, custom path, project, custom dir assets and inline markers observed; remote/managed excluded |
| OC-05 | Rules discovery and precedence | INCONCLUSIVE | Paths are documented and fixture files exist, but model system-prompt loading was not exposed without a provider |
| OC-06 | Auth-store mechanics | NOT TESTED | No credentials or provider auth were read or created |
| OC-07 | Exact role/preset representation | NOT TESTED | Assigned to SPIKE-002 |
| OC-08 | Agent discovery, modes and permissions | PASS | Built-ins/custom agents, subagent mode, edit denial and bash rules observed |
| OC-09 | Command and subtask invocation | INCONCLUSIVE | Command discovery passed; real invocation/subtask execution needs a provider-backed turn |
| OC-10 | Skill discovery and permission | INCONCLUSIVE | Skill discovery passed; a provider-backed invocation was not run |
| OC-11 | Plugin mechanics and failure isolation | PASS | Auto-discovery, config hook and non-blocking broken plugin observation passed; events remain untested |
| OC-12 | Permission and last-match behavior | PASS | Effective duplicate rules show the final specific match wins |
| OC-13 | LSP and formatter mechanics | INCONCLUSIVE | LSP diagnostics returned empty; formatter execution was not run |
| OC-14 | Compaction and watcher behavior | INCONCLUSIVE | Config surfaces resolve; runtime events/compaction were not observable in empty sessions |
| OC-15 | Documentation-backed OpenCode contract | NOT TESTED | No new documentation-only guarantee was promoted to runtime evidence |

Relevant cross-cutting classifications:

| Contract | Classification | Evidence |
|---|---|---|
| CTX-06 | INCONCLUSIVE | Agents/commands load, but `/init-project` was not executed |
| SEC-02 | INCONCLUSIVE | Edit/bash restrictions pass; task invocation and adversarial model behavior were not run |
| CLI-01 | INCONCLUSIVE | Bootstrap prerequisites are identified, but all-spike CLI behavior is out of scope |
| CLI-07 | PASS | Windows PowerShell 5.1/7, Node/npm and Git prerequisites and package-based invocation are concrete |
| OBS-06 | INCONCLUSIVE | Session IDs/timestamps/token counters exist; compaction correlation is unavailable |
| VER-02 | INCONCLUSIVE | Config/assets/permissions are inspectable; generated-project verification is not implemented |

## 10. Decision and design impact

- `DESIGN-008` path findings: global config resolves under `%USERPROFILE%\.config\opencode`; `.opencode\opencode.jsonc` is loaded in `1.18.30`; simultaneous root JSON and JSONC merge instead of failing. Review is required before treating the existing dual-root and misplaced-file policies as universal.
- `DESIGN-002` agent policy: no permanent change. The accepted `review`/`verify` shape is technically expressible with `edit` denial and ordered bash rules.
- Component manifest: no update; the complete support matrix is not proven.
- `DEC-009` implementation language: neutral. Node/npm are available and can run the tested package, but this is not sufficient evidence to select the portable-opencode implementation language.
- `DEC-012` bootstrap/distribution: weakly supports a minimal PowerShell bootstrap that detects Node/npm and invokes a pinned package; clean-machine installation and rollback remain unverified.
- New blocker: no product blocker for configuration-only work; evidence blockers remain for provider-backed execution, auth, runtime events, context pressure/compaction and managed policy.

## 11. Safety and cleanup

The spike never read or printed credentials, tokens, `.env` files, private keys or real session content. One fixture-preparation command initially used the reserved PowerShell variable name `$HOME`; it created a synthetic `opencode.jsonc` under the user's config directory, which was identified by creation metadata, removed by exact path and verified absent before testing continued. No pre-existing file content was read, and no repository file was affected.

All disposable package, fixture, session, server-output and materialization paths were removed after evidence capture. No commit or push was performed. No SPIKE-002, SPIKE-003 or SPIKE-004 work was started.

## 12. Reproducibility limits and next step

Reproduction requires the exact tested Windows environment, npm access to `opencode-ai@1.18.30`, and no provider credentials. Repeat the provider-backed portions only in a separately authorized fixture with content capture disabled and no real auth material in the fixture.

The next safe action is review and contract reconciliation of this result—especially `.opencode/opencode.jsonc`, dual root config behavior, Markdown encoding, symbolic-link prerequisites and the unverified provider/session fields—before SPIKE-002.
