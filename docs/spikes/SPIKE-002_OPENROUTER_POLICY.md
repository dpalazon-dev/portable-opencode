---
type: Spike
id: SPIKE-002
title: OpenRouter Preset and Policy Contract
description: Bounded experiment for preset reconciliation, OpenCode representation, routing, fallback, privacy and usage evidence.
status: active
sources:
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
  - resource: ../research/CONFIGURATION_SURFACE_RESEARCH.md
    title: Configuration Surface Research
  - resource: ../design/OPENROUTER_PRESET_RECONCILIATION.md
    title: OpenRouter Preset Reconciliation
  - resource: ../design/AGENT_AND_MODEL_ROLES.md
    title: Agent and Model Role Policy
  - resource: ../design/CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
---

# SPIKE-002 — OpenRouter preset and policy contract

## 1. Decision question

Can the three semantic roles `main`, `reason` and `fast` be represented through reproducible OpenRouter presets, reconciled idempotently through the current API and invoked reliably through OpenCode without embedding concrete model choices in project instructions?

## 2. Decisions and contracts informed

This spike provides evidence for:

- `DEC-020` declarative preset reconciliation;
- `DESIGN-002` role-to-preset model policy;
- `DESIGN-006` remote reconciliation semantics;
- `DESIGN-008` remote resource ownership;
- `DESIGN-009` `inspect`, `plan`, `apply` and `doctor` remote-operation behaviour;
- matrix contracts `OR-01` through `OR-08`, plus relevant `OC`, `OBS`, `SEC` and `VER` contracts.

## 3. Hypotheses

Test, do not assume:

1. current preset APIs can list, create, retrieve and create new versions with stable enough semantics for reconciliation;
2. normalized desired-vs-remote comparison can be idempotent;
3. creating a new version preserves prior history and designates the expected active version;
4. OpenCode can invoke a preset through a documented/working representation;
5. the same representation works for tool-capable requests;
6. provider routing and model fallback can remain OpenRouter policy rather than portable-opencode logic;
7. privacy constraints can be represented and verified sufficiently for the canonical policy;
8. returned metadata exposes enough resolved model/provider/usage/cost information for observability;
9. a fallback can be rejected when it would remove required tool compatibility;
10. a remote failure can be surfaced as blocked/degraded without silently falling back to unmanaged manual configuration.

## 4. Scope

### In scope

- authentication presence and failure behaviour;
- preset list/get/create/new-version semantics;
- fields persisted from the selected request skin;
- normalized comparison;
- idempotent second-run behaviour;
- partial failure handling in a small reconciler prototype or controlled fixture;
- exact preset representation through OpenCode;
- tool support;
- provider routing/fallback;
- privacy/data-collection policy;
- returned usage, cache, reasoning, resolved model/provider and cost fields;
- synthetic role smoke tests.

### Out of scope

- selecting permanent concrete models by preference alone;
- changing the number or names of semantic roles;
- production billing dashboards;
- broad provider benchmarking;
- account-wide policy changes unrelated to the three roles;
- deleting or renaming canonical `portable-main`, `portable-reason` or `portable-fast` presets;
- implementing the production reconciler.

## 5. Safety and remote-state isolation

Use only synthetic prompts and temporary spike preset slugs.

Canonical managed slugs must not be mutated during the spike unless the repository owner explicitly chooses to convert validated temporary evidence into the real configuration later.

Temporary naming pattern:

```text
portable-spike-<run-id>-main
portable-spike-<run-id>-reason
portable-spike-<run-id>-fast
```

Rules:

- API keys remain in OpenCode's private auth store or a temporary private environment variable accepted for the spike;
- never commit credentials, authorization headers or complete account responses containing sensitive identifiers;
- keep prompts synthetic and non-project-specific;
- keep request volume and cost minimal;
- do not alter unrelated account presets;
- cleanup of temporary remote presets is explicit and manual if the current API supports it safely; do not make deletion semantics part of the production design by accident.

## 6. Required environment record

Record:

```text
OpenCode version from SPIKE-001 or currently tested version
OpenRouter API/documentation version/date if exposed
account/privacy settings observable to the spike
preset request skin used
provider/model identifiers used only in sanitized test configuration
exact temporary preset slugs
```

If SPIKE-001 has not completed, record the OpenCode version independently and mark cross-spike assumptions provisional.

## 7. Temporary desired-state fixture

Create a local spike manifest structurally equivalent to the production manifest but using temporary slugs.

It must define three roles with deliberately distinguishable harmless settings so remote persistence can be measured. Do not use project secrets or permanent policy values solely to make the test convenient.

## 8. Procedure

### Test group A — Authentication and read-only inspection

1. verify OpenRouter authentication from the intended OpenCode/private mechanism without printing the key;
2. list presets;
3. retrieve a known temporary or newly created spike preset by slug;
4. record stable identifiers, designated version fields and version metadata;
5. test unauthorized/missing-key behaviour separately using a deliberately absent credential context.

The result must identify which remote identifiers are useful to persist privately and which are unstable/noisy.

### Test group B — Preset creation and persistence

For one temporary role:

1. construct a minimal known-good preset request;
2. create the preset;
3. retrieve it immediately;
4. compare requested versus persisted fields;
5. identify fields omitted, normalized or rewritten by OpenRouter;
6. classify each field as canonical-comparable, ignored-by-comparison or unverifiable.

Repeat only as needed to distinguish role-specific policy.

### Test group C — Version creation semantics

1. change one harmless persisted field;
2. create a new version through the current API;
3. retrieve preset and version history;
4. prove whether the new version becomes designated/active;
5. prove the prior version remains recoverable;
6. repeat an equivalent request and determine whether the API itself deduplicates or whether portable normalization must prevent unnecessary versions.

Do not create version churn merely to gather more examples.

### Test group D — Normalized reconciliation

Build the smallest disposable comparison prototype needed to prove:

```text
local desired
→ remote persisted response
→ normalization
→ semantic diff
```

Required cases:

- missing remote preset;
- exactly in sync;
- semantically equivalent but reordered/normalized response;
- one-field drift;
- unknown remote field;
- unreadable/unauthorized remote state.

A second equivalent reconciliation calculation must produce no operation.

The prototype is disposable evidence, not production architecture.

### Test group E — Partial failure model

Prove how a three-role apply should behave when one operation fails after another succeeds.

Use one of:

- safe remote validation failure on a temporary preset;
- a controlled local adapter/mock around the real response shapes if intentionally causing a remote failure would create harmful state.

Evidence must justify:

```text
one slug at a time
record partial success
stop/continue rule
post-operation verification
final outcome partial | blocked | degraded
```

Do not corrupt a canonical preset to test failure handling.

### Test group F — Exact OpenCode preset representation

Starting from current upstream documentation and `SPIKE-001` provider/config evidence, test only plausible documented mechanisms, for example where supported:

```text
direct @preset/<slug> reference
provider/model alias representation
preset request field through provider configuration
```

For each attempted representation:

- record exact OpenCode configuration;
- run a minimal non-tool request;
- record success/failure and resolved OpenRouter fields;
- run a tool-capable request if the representation succeeds;
- verify the request actually used the intended temporary preset rather than silently resolving some other model path.

The spike must end with one accepted representation or a blocking conclusion. Do not invent a custom OpenCode plugin solely to force presets through if a native path is unavailable.

### Test group G — Role smoke tests

Using temporary role presets:

#### Main

- minimal coding/tool-capable request;
- verify required tool call path;
- capture requested preset, resolved model/provider and usage.

#### Reason

- deterministic analysis request;
- verify intended reasoning/generation parameter survives where supported;
- tool support remains available if required by the agent.

#### Fast

- lightweight low-cost request;
- verify latency/usage metadata and tool compatibility expected by `general`, `explore`, `scout` or `small_model`.

The purpose is contract compatibility, not ranking models.

### Test group H — Routing and fallback

For a temporary preset:

1. configure a provider ordering or routing policy supported by the current API;
2. run a synthetic request and capture the resolved provider;
3. test one controlled fallback scenario if it can be induced safely;
4. verify fallback metadata;
5. test or reason from explicit capability metadata whether a fallback lacking required tools can be excluded;
6. record any fields OpenRouter resolves dynamically that cannot be treated as desired-state identity.

Portable-opencode must not reimplement provider routing if OpenRouter proves sufficient.

### Test group I — Privacy policy

Test the exact current representation of:

- data collection denial where supported;
- Zero Data Retention preference/requirement where supported;
- provider inclusion/exclusion necessary to enforce the policy;
- prompt logging/account controls that are actually inspectable from the available surface.

Classify each requirement:

```text
request/preset-enforceable
account-enforceable-and-inspectable
account-only-unverifiable
not-supported
```

Do not claim privacy guarantees beyond observable evidence.

### Test group J — Usage and cost metadata

For streaming and non-streaming requests where both are part of the supported path, record availability and semantics of:

```text
requested preset
resolved model
resolved provider
input tokens
output tokens
reasoning tokens
cache read/write or equivalent
cost
finish/error information
fallback/retry evidence
```

Identify which fields can feed `OBS-03` without recomputation.

## 9. Required evidence table

The result must contain one row for every `OR-01` through `OR-08` contract:

```text
contract
claim tested
request/API surface
evidence
result: pass | fail | partial | unverified
impact
```

Also record the exact OpenCode preset representation outcome separately because it gates environment health.

## 10. Acceptance criteria

SPIKE-002 passes only if:

- temporary presets can be created and retrieved reproducibly;
- new-version semantics are understood;
- a normalized second run is idempotent;
- remote drift can be represented as a deterministic local plan;
- partial outcomes can be detected and verified per slug;
- OpenCode can successfully invoke the intended preset through an accepted representation;
- required tool calls survive for applicable roles;
- routing and fallback can remain OpenRouter-owned;
- privacy enforcement and unverifiable account-level gaps are clearly separated;
- usage/cost/resolved model/provider fields are sufficient for later observability or their limits are explicit;
- no canonical preset or unrelated remote resource was changed accidentally.

Failure to find a reliable OpenCode preset representation is a blocking result for the current three-preset design, not permission to hide the problem with direct concrete model strings.

## 11. Decision impact

At completion state explicitly:

```text
DEC-020: retain | revise | block
DESIGN-006 changes: none | list
DESIGN-002 role mapping changes: none | list
OpenCode preset representation: exact value or blocked
component manifest updates: exact values
privacy verification gaps: list
observability fields available: list
new blocker: yes | no
```

Concrete model/provider choices may be proposed only when needed to make the three role contracts executable and must be justified by capability evidence, not personal preference.

## 12. Deliverables

Required:

```text
docs/spikes/results/SPIKE-002.md
```

Optional safe reusable evidence:

```text
spikes/SPIKE-002/fixtures/
spikes/SPIKE-002/reconciliation-prototype/
```

Do not commit raw authenticated responses with sensitive account data.

## 13. Codex assignment contract

Execute on a dedicated branch conceptually named:

```text
spike/002-openrouter-policy
```

Rules for Codex:

- read accepted context, `DESIGN-002`, `DESIGN-006`, `DESIGN-008` and this spike first;
- use temporary spike preset slugs only;
- do not mutate canonical managed slugs;
- do not broaden the role catalogue;
- use synthetic prompts and minimal spend;
- never expose API keys;
- verify remote state after every mutation;
- preserve exact request/response semantics in sanitized evidence;
- prefer native OpenCode/OpenRouter surfaces over a custom adapter;
- do not promote experimental reconciler code to production automatically;
- finish with explicit contract corrections and the evidence table.

## 14. Discard boundary

Temporary presets, one-off request files and the reconciliation prototype are experimental. Preserve only sanitized result evidence and fixtures that directly improve later contract or regression testing.
