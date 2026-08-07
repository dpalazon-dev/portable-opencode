---
type: Spike
id: SPIKE-001
title: OpenCode Windows Lifecycle and Runtime Contract
description: Bounded Windows-native experiment for OpenCode installation, configuration, assets, permissions, sessions and bootstrap evidence.
status: active
sources:
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
  - resource: ../research/CONFIGURATION_SURFACE_RESEARCH.md
    title: Configuration Surface Research
  - resource: ../design/CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: ../design/CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: ../design/AGENT_AND_MODEL_ROLES.md
    title: Agent and Model Role Policy
---

# SPIKE-001 — OpenCode Windows lifecycle and runtime contract

## 1. Decision question

Can the canonical OpenCode part of `portable-opencode` be installed, configured, inspected and recovered reproducibly on native Windows using the paths, agents, permissions and session assumptions already defined by the repository?

The spike must replace documentation-level assumptions with Windows-native evidence. It does not redesign the product.

## 2. Decisions and contracts informed

This spike provides evidence for:

- `DEC-009` implementation-language feasibility where OpenCode integration affects packaging;
- `DEC-012` bootstrap/distribution constraints;
- `DESIGN-002` native/custom agent policy;
- `DESIGN-007` copied/rendered/linked behaviour for OpenCode resources;
- `DESIGN-008` effective global paths and resource ownership;
- `DESIGN-009` `inspect`, `doctor`, `init-project` and bootstrap contracts;
- matrix contracts `OC-01` through `OC-15`, plus relevant `CORE`, `CLI`, `SEC` and `VER` contracts.

## 3. Hypotheses

Test, do not assume:

1. OpenCode can be installed and version-detected reliably from PowerShell without WSL.
2. The effective global runtime config on supported Windows is the repository's intended `~/.config/opencode/opencode.jsonc` equivalent.
3. Root project `opencode.jsonc` is discovered from a Git worktree as documented.
4. `.opencode/` native assets are discovered without requiring a parallel configuration format.
5. effective precedence and provenance can be observed well enough for `inspect` to explain active layers.
6. built-in agents plus project `review` and `verify` can express the intended behaviour and restrictions.
7. permission inheritance, last-match behaviour and task invocation can enforce non-mutating review/verification.
8. PowerShell, LSP, formatter, watcher and compaction behaviour are sufficiently controllable through native OpenCode surfaces.
9. session metadata is sufficient to distinguish concurrent sessions and recover useful continuity without a terminal multiplexer.
10. reliable context/compaction metadata is either available or can be marked explicitly unavailable without inference.
11. copied/rendered OpenCode configuration is safer than linked configuration for the canonical Windows setup.
12. the minimum bootstrap prerequisites can be identified without placing desired-state logic in PowerShell.

## 4. Scope

### In scope

- Windows-native install/update/version detection;
- global config discovery;
- project config discovery;
- `.opencode/` assets;
- root `AGENTS.md` and candidate global rules path;
- configuration precedence/provenance that can be exercised safely;
- built-in and custom agents;
- commands and skills required by the canonical project scaffold;
- permissions and subagent invocation;
- PowerShell shell execution;
- LSP/formatter discovery and failure behaviour;
- watcher and compaction behaviour;
- plugin loading and event stability only where needed for RTK/observability metadata;
- parallel sessions and session recovery;
- context-window/compaction metadata availability;
- Windows link behaviour for a disposable OpenCode configuration target;
- bootstrap prerequisites and packaging constraints.

### Out of scope

- choosing concrete OpenRouter models or presets;
- implementing the production CLI;
- implementing observability;
- adding new agents beyond accepted `review` and `verify`;
- adopting a terminal multiplexer;
- WSL/Linux/macOS support;
- changing product policy because an experiment is inconvenient.

## 5. Safety and isolation

Use a disposable fixture repository and isolate global state as far as OpenCode's documented mechanisms permit.

Before touching any real global OpenCode file:

1. identify the exact path and current content;
2. create a private backup outside the fixture repository;
3. record its hash and permissions;
4. restore and verify it at spike completion.

Do not:

- read or print API keys;
- push from the fixture repository;
- delete unmanaged OpenCode files;
- modify `%ProgramData%\opencode` unless a specific test requires it and a complete restore path exists;
- use the owner's real project repositories as fixtures.

If a documented precedence layer cannot be exercised safely, mark it `unverified` rather than simulating success.

## 6. Required environment record

The result must record:

```text
Windows edition/build
CPU architecture
PowerShell executable and version
OpenCode version
OpenCode installation source/mechanism
Git version
Node/runtime version only if relevant to OpenCode or plugins
terminal used
absolute fixture paths redacted to stable placeholders in committed evidence
```

No supported version is written to `config/components.jsonc` until the evidence is complete.

## 7. Fixture layout

Create a disposable Git repository equivalent to:

```text
fixture-opencode/
├── opencode.jsonc
├── AGENTS.md
├── .opencode/
│   ├── agents/
│   │   ├── review.md
│   │   └── verify.md
│   ├── commands/
│   │   ├── review.md
│   │   └── verify.md
│   └── skills/
│       └── spike-fixture/
│           └── SKILL.md
└── src/
    └── minimal source file for LSP/formatter tests
```

Keep fixture content synthetic.

## 8. Procedure

### Test group A — Installation and identity

1. determine current official Windows-native installation path/mechanism used by the tested version;
2. install in a disposable or reversible manner;
3. prove command discovery from a fresh PowerShell session;
4. record version output and executable location;
5. repeat detection after a new shell session;
6. establish whether exact pinning or a validated range is practical;
7. record upgrade/uninstall primitives without performing destructive cleanup of unrelated installations.

Evidence must distinguish documented behaviour from observed behaviour.

### Test group B — Global and project config discovery

1. establish the actual effective global config path on Windows;
2. load a harmless unique setting from global config and prove OpenCode sees it;
3. create the fixture root `opencode.jsonc` with a conflicting harmless value and prove project override/merge behaviour;
4. run from a nested directory and prove worktree discovery;
5. test root `opencode.json` alone as migration candidate;
6. test simultaneous root JSON and JSONC and confirm whether the ambiguity policy is necessary;
7. place `.opencode/opencode.jsonc` as an intentionally misplaced file and observe actual behaviour without treating it as canonical.

Record exact evidence for the path assumptions in `DESIGN-008`.

### Test group C — Precedence and provenance

Exercise, where safe and available:

```text
global config
OPENCODE_CONFIG
project root config
OPENCODE_CONFIG_DIR asset layer
.opencode assets
OPENCODE_CONFIG_CONTENT
managed settings
```

For each layer:

- set a unique harmless marker;
- observe the effective value;
- record whether the source can be detected independently;
- restore the environment after the test.

Remote organizational config may remain unverified if the account/environment does not expose it. Do not create organization policy for the spike.

The result must produce an observed precedence table, not merely restate documentation.

### Test group D — Rules, assets and agent discovery

1. prove root `AGENTS.md` is loaded;
2. prove or reject the intended global rules path;
3. prove `.opencode/agents/review.md` and `verify.md` discovery;
4. prove `.opencode/commands/review.md` and `verify.md` discovery;
5. prove on-demand skill discovery from `.opencode/skills/<name>/SKILL.md`;
6. record duplicate/conflicting asset behaviour where relevant;
7. record whether asset changes require restart or are picked up dynamically.

### Test group E — Agent and permission contract

Using synthetic files and commands:

1. invoke built-in `build`, `plan`, `general`, `explore` and `scout` where exposed by the tested version;
2. invoke project `review` and prove it cannot edit;
3. invoke project `verify` and prove it cannot edit;
4. test allowed and denied shell patterns;
5. test `permission.task` or the current equivalent for subagent invocation;
6. test last-match semantics with an intentionally conflicting harmless permission fixture;
7. prove that denied destructive/external operations remain denied even when requested in the prompt.

No destructive command should actually execute. Use commands whose denial can be observed safely.

### Test group F — PowerShell, LSP, formatter, watcher and compaction

1. configure shell execution explicitly for PowerShell if supported;
2. run a synthetic command and prove quoting/path behaviour with spaces;
3. configure one minimal stack-compatible LSP/formatter fixture;
4. record startup, missing-tool and invalid-config behaviour;
5. test watcher ignores against `.portable-opencode/` and `graphify-out/` candidates;
6. create a controlled long-session fixture sufficient to trigger or inspect compaction behaviour if practical;
7. record native compaction controls and observable events/metadata.

This group is about lifecycle mechanics, not choosing the project's eventual stack.

### Test group G — Plugin/event stability

Load the smallest disposable plugin needed to observe documented lifecycle/session events.

Record:

- discovery path;
- event names actually observed;
- event payload fields relevant to session/project/agent/tool/compaction correlation;
- failure behaviour when the plugin throws or is invalid;
- whether plugin failure blocks OpenCode or degrades narrowly.

Do not implement the production observability plugin in this spike.

### Test group H — Parallel sessions and recovery

Using Windows Terminal without Herder/tmux:

1. open at least two OpenCode sessions on the same fixture project;
2. run independent harmless tasks;
3. identify each session through available metadata/UI/state;
4. inspect changes from a separate terminal while another session remains active;
5. close one session cleanly;
6. reopen/recover it using only native OpenCode/session mechanisms where supported;
7. record what survives: history, agent identity, context summary, task state and project link;
8. repeat one abnormal close if safe and record recovery behaviour.

Acceptance does not require perfect multiplexing. It requires enough native behaviour to justify keeping multiplexers outside the MVP.

### Test group I — Context pressure and compaction metadata

For each reliably exposed field, record source and semantics:

```text
session_id
agent
requested model identity if available before SPIKE-002
input/context token count
context limit
context utilization
compaction start/end
pre/post compaction tokens
compaction count
```

Classify each field as:

```text
reliable
available-but-ambiguous
unavailable
```

Never derive a percentage from fields whose semantics are not proven.

### Test group J — Copied/rendered versus linked config

On a disposable target only:

1. materialize a copied config and prove load/update/restore behaviour;
2. materialize a Windows link using the available supported primitive;
3. observe whether OpenCode or normal configuration workflows can rewrite through the link;
4. test link detection, replacement, backup and detach;
5. record privilege/developer-mode requirements;
6. conclude whether `linked` can remain exceptional or should be rejected entirely for MVP.

This test must not link the real canonical repository into the user's active config.

### Test group K — Bootstrap evidence

Determine the minimum clean-machine primitives needed to make the future CLI runnable:

- Windows-provided shell availability;
- whether PowerShell 7 is required or Windows PowerShell can bootstrap it;
- runtime/package prerequisites implied by leading implementation-language candidates;
- path persistence behaviour across new shells;
- whether a single small `scripts/bootstrap.ps1` can establish the CLI without configuring OpenCode itself.

Do not choose `DEC-009` or `DEC-012` here unless the evidence is strong enough to compare actual prototype options. Record constraints for the later decision.

## 9. Required evidence table

The result must contain one row for every matrix contract `OC-01` through `OC-15`:

```text
contract
claim tested
version/environment
evidence
result: pass | fail | partial | unverified
impact
```

Also map relevant `CORE`, `SEC`, `CLI` and `VER` findings discovered by the experiment.

## 10. Acceptance criteria

SPIKE-001 passes only if:

- a supported OpenCode version can be installed/detected natively on Windows;
- global and project config discovery are proven;
- `.opencode/` asset discovery is proven;
- the canonical root/project conflict policy is justified or corrected from evidence;
- native/custom agents and required command invocation work;
- `review` and `verify` can be made non-mutating through technical permissions;
- PowerShell execution is reliable enough for the canonical workflow;
- active provenance layers can be reported with honest limits;
- plugin/session metadata limitations are explicitly known;
- parallel sessions are workable enough that no multiplexer is required for MVP, or a concrete blocker is recorded;
- context/compaction fields are classified without fabrication;
- copied/rendered global config is viable;
- link behaviour is explicitly accepted, rejected or left exceptional with evidence;
- clean bootstrap constraints are concrete enough to prevent an implementation agent from inventing them.

A partial result is allowed for inaccessible organization-managed surfaces, but the environment cannot claim those fields verified.

## 11. Decision impact

At completion, the result must state explicitly:

```text
DESIGN-008 path changes: none | list
DESIGN-002 changes: none | list
component manifest updates: exact values
DEC-009 evidence: supports | weakens | neutral
DEC-012 evidence: supports | weakens | neutral
new blocker: yes | no
```

Do not silently change accepted product defaults inside the spike branch.

## 12. Deliverables

Required:

```text
docs/spikes/results/SPIKE-001.md
```

Optional reusable evidence:

```text
spikes/SPIKE-001/fixtures/
spikes/SPIKE-001/scripts/
```

Do not commit raw logs containing usernames, absolute private paths, tokens or unrelated machine configuration. Sanitize evidence before commit.

## 13. Codex assignment contract

Execute this spike on a dedicated branch named conceptually:

```text
spike/001-opencode-lifecycle
```

Rules for Codex:

- read canonical context and this document first;
- do not redesign product policy;
- use native Windows and PowerShell only;
- prefer current primary upstream documentation when a command is uncertain;
- preserve exact tested versions and commands in the result;
- keep experiments reversible;
- never use real secrets in fixtures;
- never merge experimental implementation into production architecture automatically;
- stop a destructive path and report the blocker rather than broadening permissions;
- finish with the result document, reusable safe fixtures and exact recommended contract corrections.

## 14. Discard boundary

Experimental plugin code, temporary configs, linked files and installation experiments are disposable. Keep only sanitized evidence, minimal fixtures that improve future regression tests and contract changes separately approved from the evidence.
