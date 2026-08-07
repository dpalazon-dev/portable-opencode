---
type: Design
id: DESIGN-010
title: Evidence and Spike Mapping
description: Explicit mapping from every runtime-evidence contract to a bounded spike or post-spike implementation test.
status: active
sources:
  - resource: CONFIGURATION_MATRIX.md
    title: Portable OpenCode Configuration Matrix
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
  - resource: ../spikes/SPIKE-001_OPENCODE_LIFECYCLE.md
    title: OpenCode Windows Lifecycle and Runtime Contract
  - resource: ../spikes/SPIKE-002_OPENROUTER_POLICY.md
    title: OpenRouter Preset and Policy Contract
  - resource: ../spikes/SPIKE-003_OBSERVABILITY.md
    title: Windows-Native Observability Contract
  - resource: ../spikes/SPIKE-004_GRAPHIFY_RTK.md
    title: Graphify and RTK Windows Integration Contract
---

# Evidence and spike mapping

## 1. Objective

Ensure no `S` or `P/S` contract in `DESIGN-001` reaches implementation without an explicit evidence owner.

A spike validates upstream/runtime mechanisms. A post-spike implementation test validates portable-opencode's own code. The same contract may require both.

## 2. Evidence classes

```text
SPIKE-001  OpenCode + Windows lifecycle/bootstrap/session mechanics
SPIKE-002  OpenRouter presets/policy/OpenCode preset integration
SPIKE-003  localhost proxy + Phoenix/privacy/lifecycle
SPIKE-004  Graphify + RTK Windows integration
IMPL-*     portable-opencode implementation fixture after spikes
E2E-001    clean-Windows canonical journey after implementation
```

## 3. OpenCode contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `OC-01` | SPIKE-001 install/version detection | `IMPL-ENV-01` install adapter/idempotence |
| `OC-02` | SPIKE-001 global config path/load | `IMPL-OC-01` render/copy/load fixture |
| `OC-03` | SPIKE-001 root config discovery | `IMPL-PRJ-01` generated project load fixture |
| `OC-04` | SPIKE-001 precedence/provenance | `IMPL-OC-02` inspect provenance fixture |
| `OC-05` | SPIKE-001 rules discovery/precedence | `IMPL-PRJ-02` rules contradiction fixture |
| `OC-06` | SPIKE-001 auth-store mechanics + SPIKE-002 authenticated request | `IMPL-SEC-01` no-secret persistence fixture |
| `OC-07` | SPIKE-002 exact role/preset representation | `IMPL-OC-03` generated mapping fixture |
| `OC-08` | SPIKE-001 agent discovery/modes/permissions | `IMPL-AGENT-01` scaffold agent fixture |
| `OC-09` | SPIKE-001 command/subtask invocation | `IMPL-AGENT-02` `/review`/`/verify` fixture |
| `OC-10` | SPIKE-001 skill discovery/permission | `IMPL-AGENT-03` on-demand skill fixture |
| `OC-11` | SPIKE-001 plugin mechanics; SPIKE-003/004 for accepted integrations | `IMPL-OC-04` plugin failure/isolation fixture |
| `OC-12` | SPIKE-001 permissions/last-match behaviour | `IMPL-SEC-02` adversarial permission fixture |
| `OC-13` | SPIKE-001 LSP/formatter mechanics | `IMPL-PRJ-03` stack-derived config fixture |
| `OC-14` | SPIKE-001 compaction/watcher behaviour | `IMPL-OC-05` long-session/watcher fixture |

`OC-15` is documentation-backed and does not carry `S` in the current matrix.

## 4. OpenRouter contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `OR-01` | SPIKE-002 private authentication | `IMPL-SEC-01` no-secret persistence fixture |
| `OR-02` | SPIKE-002 three role/preset mappings | `IMPL-OR-01` generated role mapping fixture |
| `OR-03` | SPIKE-002 API semantics/normalization/idempotence | `IMPL-OR-02` reconciler contract suite |
| `OR-04` | SPIKE-002 provider routing | `IMPL-OR-03` policy smoke test |
| `OR-05` | SPIKE-002 fallback/tool compatibility | `IMPL-OR-04` incompatible-fallback rejection fixture |
| `OR-06` | SPIKE-002 privacy enforcement/visibility | `IMPL-SEC-03` privacy doctor fixture |
| `OR-07` | SPIKE-002 usage/cost/resolution fields | `IMPL-OBS-01` usage ingestion fixture |

`OR-08` is owner policy and does not require runtime evidence before initial activation.

## 5. Observability contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `OBS-01` | SPIKE-003 transparent localhost proxy | `IMPL-OBS-02` OpenCode-through-proxy E2E |
| `OBS-02` | SPIKE-003 SSE/tools/structured/error protocol | `IMPL-OBS-03` protocol regression suite |
| `OBS-03` | SPIKE-003 metadata extraction; SPIKE-002 source fields | `IMPL-OBS-04` span schema fixture |
| `OBS-04` | SPIKE-003 content-off/redaction | `IMPL-SEC-04` persistence secret scan |
| `OBS-05` | SPIKE-003 Phoenix acceptance | `IMPL-OBS-05` managed lifecycle fixture |
| `OBS-06` | SPIKE-001 session/event metadata + SPIKE-003 correlation | `IMPL-OBS-06` correlation fixture |
| `OBS-07` | SPIKE-003 PIDs/ports/retention/recovery | `IMPL-OBS-07` lifecycle/recovery suite |

## 6. Graphify contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `GR-01` | SPIKE-004 native install/integration | `IMPL-GR-01` install/doctor fixture |
| `GR-02` | SPIKE-004 first useful graph | `IMPL-GR-02` initialized-project graph fixture |
| `GR-03` | SPIKE-004 ignore quality comparison | `IMPL-GR-03` generated-ignore fixture |
| `GR-04` | SPIKE-004 `.gitignore`/path/negation semantics | `IMPL-GR-04` ignore regression fixture |
| `GR-05` | SPIKE-004 determinism/manifest/privacy | `IMPL-GR-05` versioned-output fixture |
| `GR-06` | SPIKE-004 explicit update lifecycle | `IMPL-GR-06` dirty-to-fresh fixture |
| `GR-07` | SPIKE-004 hook mechanics/recovery | no MVP implementation unless policy is reconsidered |
| `GR-08` | SPIKE-004 freshness/quality signals | `IMPL-GR-07` state/diagnostic fixture |

## 7. RTK contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `RTK-01` | SPIKE-004 native binary identity | `IMPL-RTK-01` install/doctor fixture |
| `RTK-02` | SPIKE-004 native OpenCode integration | `IMPL-RTK-02` representative rewrite fixture |
| `RTK-03` | SPIKE-004 exclusions/config | `IMPL-RTK-03` exclusion fixture |
| `RTK-04` | SPIKE-004 private failure tee | `IMPL-RTK-04` failure-output privacy fixture |
| `RTK-05` | SPIKE-004 gain/degradation behaviour | `IMPL-RTK-05` doctor/degraded fixture |

## 8. Cross-cutting `S` contracts

| Contract | Evidence owner | Post-spike test |
|---|---|---|
| `CTX-06` | SPIKE-001 command/agent mechanics | `IMPL-PRJ-04` complete `/init-project` fixture |
| `SEC-02` | SPIKE-001 permission semantics | `IMPL-SEC-02` adversarial permission suite |
| `SEC-04` | SPIKE-003 loopback verification | `IMPL-SEC-05` socket fixture |
| `SEC-05` | SPIKE-002 privacy + SPIKE-003 content logging | `IMPL-SEC-03/04` privacy persistence suite |
| `CLI-01` | SPIKE-001 through SPIKE-004 + first CLI prototype | `IMPL-PKG-01` clean-machine packaging comparison |
| `CLI-03` | all four spikes | `E2E-001` canonical environment install |
| `CLI-05` | SPIKE-003 and SPIKE-004 native lifecycle gaps | component-specific implementation tests only where needed |
| `CLI-06` | exact versions from all spikes | `IMPL-UPD-01` upgrade/backup/rollback fixture |
| `CLI-07` | SPIKE-001 bootstrap constraints | `IMPL-PKG-02` clean PowerShell bootstrap fixture |
| `VER-02` | SPIKE-001 config/assets/permissions | `IMPL-VER-01` generated OpenCode load fixture |
| `VER-03` | SPIKE-002 preset integration | `IMPL-VER-02` three-role authenticated fixture |
| `VER-04` | SPIKE-004 Graphify/RTK | `IMPL-VER-03` graph + RTK fixture |
| `VER-06` | all spikes provide mechanisms | `E2E-001` clean Windows to recoverable ready project |

## 9. Post-spike implementation test catalogue

These identifiers are planning contracts, not a requirement to create one test file per ID. Related cases may share fixtures while preserving traceability.

### Environment and packaging

```text
IMPL-ENV-01
IMPL-PKG-01
IMPL-PKG-02
IMPL-UPD-01
```

### OpenCode/project/agents

```text
IMPL-OC-01..05
IMPL-PRJ-01..04
IMPL-AGENT-01..03
```

### OpenRouter

```text
IMPL-OR-01..04
```

### Observability

```text
IMPL-OBS-01..07
```

### Graphify and RTK

```text
IMPL-GR-01..07
IMPL-RTK-01..05
```

### Security and verification

```text
IMPL-SEC-01..05
IMPL-VER-01..03
```

### End to end

```text
E2E-001
clean supported Windows
→ bootstrap CLI
→ inspect
→ plan
→ install/apply
→ doctor healthy
→ init new project
→ /init-project
→ graph + verification
→ project ready
→ rerun no-op
→ later session recovers context/state
```

## 10. Execution order

Recommended order:

```text
SPIKE-001
→ SPIKE-002
→ SPIKE-004
→ SPIKE-003
```

Rationale:

- SPIKE-001 fixes OpenCode paths, provider/session/plugin mechanics and bootstrap constraints used by later spikes;
- SPIKE-002 fixes the actual OpenRouter request/preset representation needed by the proxy path;
- SPIKE-004 is mostly independent once OpenCode integration paths are known and can run before the heavier observability prototype;
- SPIKE-003 then tests the final known OpenCode/OpenRouter path rather than a guessed one.

SPIKE-002 and SPIKE-004 may run in parallel after SPIKE-001 if separate branches/machines preserve global-config isolation.

## 11. Completion gate

Phase 1 evidence is complete when:

- every `S` contract above has a result;
- failed assumptions produce explicit contract corrections rather than workarounds hidden in code;
- component versions/mechanisms are written to `config/components.jsonc` only from passed evidence;
- `DEC-009`, `DEC-010` and `DEC-012` have enough evidence to resolve;
- all remaining uncertainty is an implementation test, not an upstream product question;
- `E2E-001` can be specified without guessing external behaviour.
