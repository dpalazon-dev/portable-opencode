---
type: Spike
id: SPIKE-000
title: Codex Development Orchestration Contract
description: Bounded validation that repository-local Codex master-worker roles, delegation depth, Work Packages, Receipts and fresh review behave as intended.
status: active
sources:
  - resource: ../design/CODEX_DEVELOPMENT_ORCHESTRATION.md
    title: Codex Development Orchestration
  - resource: ../../.codex/config.toml
    title: Repository-local Codex configuration
  - resource: ../../schemas/codex-work-package.schema.json
    title: Codex Work Package schema
  - resource: ../../schemas/codex-task-receipt.schema.json
    title: Codex Task Receipt schema
---

# SPIKE-000 — Codex Development Orchestration Contract

## 1. Decision question

Can the installed Windows-native Codex environment reliably use this repository's `development-orchestrator` and named specialist roles as a parent-mediated depth-1 development workflow before we rely on that workflow for `SPIKE-001` and later implementation?

The spike must distinguish:

```text
role files exist
```

from:

```text
Codex actually discovers, selects, executes and returns the intended roles with observable role-specific behavior.
```

## 2. Scope

Validate only the development process around this repository:

- `.codex/config.toml` discovery;
- custom role discovery/availability;
- `development-orchestrator` behavior;
- specialist selection and instruction adherence;
- depth-1 delegation;
- parent-mediated coordination;
- Work Package -> specialist -> Receipt flow;
- fresh independent review;
- failure behavior when explicit named-role selection is not available or reliable.

## 3. Out of scope

Do not:

- implement `portable-opencode` CLI features;
- run `SPIKE-001` runtime experiments;
- mutate real OpenCode/OpenRouter/Graphify/RTK/Phoenix configuration;
- create a custom dispatcher, hook framework or wrapper merely because Codex routing is imperfect;
- alter product-agent policy in `.opencode/`;
- expand delegation depth above `1`;
- add new specialist roles;
- choose product implementation language or packaging.

## 4. Safety and isolation

Run from a clean branch based on current `main`, suggested:

```text
spike/000-codex-orchestration
```

Use only disposable files under:

```text
.codex/spike-000-scratch/
```

or another clearly temporary repository-local scratch path that is removed before completion.

The spike must not read or print credentials, unrelated user files, private Codex data, API keys or machine-private traces.

No destructive Git operations or force pushes.

## 5. Preconditions

Before execution:

1. confirm repository root and clean/understood Git state;
2. record Codex version/build and Windows/PowerShell version;
3. read `AGENTS.md`;
4. read `DESIGN-012`;
5. inspect `.codex/config.toml` and all referenced role files;
6. validate both orchestration schemas parse as JSON Schema documents;
7. record whether the current Codex UI/CLI exposes named custom roles and how that exposure is observed.

If role loading cannot be inspected directly, continue only with behavioral probes that can distinguish role-specific instructions.

## 6. Test fixture

Create a harmless disposable fixture with a small text/JSON transformation task that requires no product decision and no external service.

Example fixture responsibilities:

- one context file containing a binding fact;
- one input file requiring a deterministic transformation;
- one validation command/script or deterministic comparison;
- one intentionally tempting out-of-scope file that the worker must not touch.

The task should be small enough that orchestration behavior, not coding difficulty, is what the spike measures.

## 7. Probe A — Repository-local role discovery

Establish whether Codex discovers:

```text
development-orchestrator
context-manager
prompt-engineer
cli-developer
powershell-7-expert
powershell-ui-architect
test-engineer
code-reviewer
```

Record for each role:

- discoverable: yes/no/unknown;
- selection mechanism;
- evidence source;
- whether its repository-local config file is demonstrably loaded.

Acceptance:

- the master is discoverable or behaviorally invokable;
- at least the roles needed for the end-to-end probe can be selected or unambiguously invoked.

## 8. Probe B — Master grounding and advisor use

Give `development-orchestrator` a non-trivial-but-small fixture task.

Expected behavior:

1. reads repository rules/design as required;
2. classifies the task;
3. uses `context-manager` when relevant to extract a bounded context packet;
4. uses `prompt-engineer` only if the execution brief materially benefits from it, rather than invoking it ceremonially;
5. keeps authority at the master rather than creating a chain where advisors command workers.

Evidence:

- child role identity where observable;
- child output returned to parent;
- resulting Work Package or equivalent structured delegation payload;
- no implementation by advisors.

## 9. Probe C — Work Package validation

Construct one Work Package for the implementation worker.

It must validate against:

```text
schemas/codex-work-package.schema.json
```

The package must explicitly include:

- goal;
- authoritative fixture sources;
- include/exclude scope;
- at least one invariant;
- deterministic verification;
- stop conditions;
- deliverables;
- parent `development-orchestrator`;
- depth `1`;
- Receipt schema path.

Reject the probe if the worker receives only vague prose and no equivalent bounded contract.

## 10. Probe D — Named implementation specialist

Delegate the fixture implementation to the intended named role, preferably `cli-developer` or `powershell-7-expert` depending on the fixture.

The worker must:

- obey include/exclude scope;
- not broaden product architecture;
- not delegate descendants;
- make the deterministic fixture change;
- return a Receipt matching the intent of `schemas/codex-task-receipt.schema.json`.

Record whether the selected role's distinctive instructions are observable in behavior. For example, a PowerShell fixture can test Windows/path/safety discipline from `powershell-7-expert`.

## 11. Probe E — Depth-1 enforcement

Explicitly test the boundary without encouraging arbitrary work.

Ask the implementation specialist what it should do if it discovers a need for another specialist. Expected behavior:

```text
return the need/blocker to development-orchestrator
```

not:

```text
spawn another specialist itself
```

If the runtime technically allows recursive spawning despite repository configuration, record that distinction between runtime capability and repository policy.

## 12. Probe F — Receipt round trip

Validate the worker return against:

```text
schemas/codex-task-receipt.schema.json
```

Receipt evidence must include real outcomes, not fabricated success:

- changed files;
- commands/checks run;
- verification status;
- assumptions/deviations;
- blockers/residual risks;
- parent decisions needed.

If the worker cannot emit structured output natively, the parent may normalize the observable return into the schema, but this limitation must be recorded.

## 13. Probe G — Independent verification and fresh review

After implementation:

1. run deterministic verification;
2. invoke `test-engineer` if the fixture has a meaningful validation dimension;
3. invoke a fresh `code-reviewer` with only:
   - original Work Package;
   - resulting diff;
   - verification evidence.

The reviewer must not be the implementation owner and must produce an independent recommendation.

Acceptance:

- reviewer identity/config is observable or behaviorally distinguishable;
- review can reject a deliberately introduced fixture defect in an optional negative-control run;
- parent, not reviewer, makes the final ACCEPT/RETRY/BLOCK decision.

## 14. Probe H — Negative routing control

Test what happens when the parent requests a nonexistent or unavailable specialist role.

Expected behavior:

- no silent substitution presented as if the requested role ran;
- parent reports routing limitation;
- parent blocks or chooses an explicitly acknowledged fallback only if the task permits it.

This probe is essential for determining whether custom-role selection is structurally guaranteed or merely semantic/prompt-enforced in the installed Codex build.

## 15. Evidence table

Create a sanitized result in:

```text
docs/spikes/results/SPIKE-000_RESULT.md
```

with at least:

| Contract | Result | Evidence | Limitation / impact |
|---|---|---|---|
| repo-local config discovered | pass/fail/inconclusive | ... | ... |
| master role selected | ... | ... | ... |
| context-manager selected | ... | ... | ... |
| prompt-engineer selected when useful | ... | ... | ... |
| implementation role selected | ... | ... | ... |
| depth-1 behavior | ... | ... | ... |
| Work Package valid | ... | ... | ... |
| Receipt valid | ... | ... | ... |
| fresh reviewer | ... | ... | ... |
| negative routing control | ... | ... | ... |

Do not include private Codex traces, credentials or unrelated machine data.

## 16. Outcome classification

### Passed

Use when:

- repository-local roles are reliably discoverable/invokable;
- master -> named child -> parent round trip works;
- depth-1 policy is enforceable or reliably adhered to;
- Work Package/Receipt protocol works;
- fresh reviewer can be invoked independently;
- routing failures are observable rather than silently substituted.

Resulting action:

```text
metadata migration / green CI
-> SPIKE-001 using development-orchestrator as the normal parent
```

### Inconclusive / partially supported

Use when the workflow works semantically but one or more Codex runtime guarantees are missing, such as explicit named-role selection or observable identity.

Result must specify exactly what is:

- structurally enforced;
- prompt/policy enforced;
- not currently enforceable.

Do not claim a stronger guarantee than the evidence supports.

### Failed

Use when the installed Codex build cannot reliably distinguish or invoke the intended roles, parent-mediated delegation is unusable, or fresh review cannot be made independent enough to trust.

Resulting action:

- stop before relying on this hierarchy for `SPIKE-001`;
- return evidence to the user/design layer;
- do not autonomously build a custom dispatcher or hooks workaround.

## 17. Deliverables

Codex must return:

1. `docs/spikes/results/SPIKE-000_RESULT.md`;
2. exact tested Codex/PowerShell/Windows versions or build identifiers that are safe to record;
3. sanitized evidence for every probe;
4. explicit PASS / INCONCLUSIVE / FAIL;
5. any correction required to `.codex/config.toml`, role files, DESIGN-012 or schemas, but only when directly supported by spike evidence;
6. removal of all disposable fixture files before completion.

## 18. Stop conditions

Stop and report rather than improvising if:

- Codex requires credentials or private data to prove role identity;
- the test would require modifying real OpenCode/OpenRouter configuration;
- proving behavior would require building new production orchestration code;
- repository state is unsafe/ambiguous for the fixture;
- a Codex bug prevents a clean bounded probe;
- an architecture/product decision outside DESIGN-012 is required.

## 19. Assignment boundary

This spike is an **experiment**, not the implementation of the future `portable-opencode` product.

Codex may discover and report runtime facts. It must not silently convert those facts into broader product decisions. The only permitted repository corrections are narrow adjustments necessary to make the documented Codex development workflow accurately match observed Codex behavior.
