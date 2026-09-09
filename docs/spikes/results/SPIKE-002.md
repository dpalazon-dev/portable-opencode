---
type: Spike Result
title: OpenRouter preset and policy contract result
description: Sanitized evidence for OpenRouter preset lifecycle, reconciliation semantics, OpenCode representation and policy metadata.
status: active
sources:
  - resource: ../SPIKE-002_OPENROUTER_POLICY.md
    title: OpenRouter preset and policy contract
  - resource: ../../design/OPENROUTER_PRESET_RECONCILIATION.md
    title: OpenRouter Preset Reconciliation
  - resource: ../../design/AGENT_AND_MODEL_ROLES.md
    title: Agent and Model Role Policy
  - resource: ../../design/EVIDENCE_AND_SPIKE_MAPPING.md
    title: Evidence and Spike Mapping
  - resource: SPIKE-001_RESULT.md
    title: OpenCode Windows lifecycle and runtime contract result
---

# SPIKE-002 — OpenRouter preset and policy contract result

## 1. Classification

**Final classification: `INCONCLUSIVE`.**

The authenticated OpenRouter surface was not available in this process. The unauthenticated list and get requests returned `401`, while no API key or OpenCode credential was read, printed or persisted. Official OpenRouter documentation and a disposable local comparison prototype provide useful partial evidence, but remote mutations, authenticated inference, OpenCode preset invocation, tools, routing resolution, privacy inspection and usage/cost capture remain unverified.

This result does not authorize a production reconciler, a concrete model/provider choice or creation of `config/openrouter/presets.jsonc`.

## 2. Tested boundary and safety

| Item | Evidence |
|---|---|
| Date / run | 2026-09-09 / `20260909-002` |
| OpenCode baseline | `opencode-ai@1.18.30`, inherited from the version-scoped SPIKE-001 evidence; no provider-backed turn was run here |
| OpenRouter surface | Official API v1 paths and documentation retrieved on 2026-09-09 |
| Temporary slugs | `portable-spike-20260909-002-main`, `portable-spike-20260909-002-reason`, `portable-spike-20260909-002-fast` |
| Credentials | `OPENROUTER_API_KEY` was absent; no credential value, auth header, `.env` or auth-store content was read |
| Remote mutations | None; no POST was attempted and no remote preset was created or changed |
| Canonical/unrelated presets | Not touched: `portable-main`, `portable-reason`, `portable-fast` and all other account resources |
| Prompts | No provider prompt was sent; the local prototype used synthetic non-project values only |
| Disposable processes | No process was started by this spike; the pre-existing `node` process was not altered |

Read-only checks:

- `GET https://openrouter.ai/api/v1/presets` without authorization returned HTTP `401`.
- `GET` for each of the three run-scoped temporary slugs without authorization returned HTTP `401`.
- No authenticated list, get, create, version, inference or cleanup operation was possible.

SPIKE-001 limitations remain unchanged: it is `INCONCLUSIVE`, version-scoped to `opencode-ai@1.18.30`, and did not prove auth-store mechanics, provider-backed turns, real command/subtask execution, formatter execution, watcher events, compaction/context limits, session recovery, adversarial model behavior, managed settings or organization configuration.

## 3. Official API and persistence evidence

The official OpenRouter preset documentation describes:

- `GET /api/v1/presets` for authenticated listing, with `id`, `slug`, `status`, `designated_version_id` and timestamps in the list shape;
- `GET /api/v1/presets/{slug}` for the preset with its designated version;
- `GET /api/v1/presets/{slug}/versions` for ascending version history and `GET /api/v1/presets/{slug}/versions/{version}` for a specific version;
- `POST /api/v1/presets/{slug}/chat/completions`, `/messages` or `/responses` to create a preset or a new version for an existing slug;
- persistence of fields overlapping the preset configuration, such as `model`, `temperature`, `provider`, `top_p` and `system`, while transient request fields such as `messages`, `input`, `prompt` and `stream` are ignored;
- the new version becoming designated/active when a request is posted to an existing slug.

These are documentation-backed API semantics, not live account evidence in this run. The official references are [preset management](https://openrouter.ai/docs/guides/features/presets), [list presets](https://openrouter.ai/docs/api/api-reference/presets/list-presets), [create from Chat Completions](https://openrouter.ai/docs/api/api-reference/presets/create-presets-chat-completions), [list preset versions](https://openrouter.ai/docs/api/api-reference/presets/list-preset-versions) and [OpenRouter's TypeScript preset reference](https://openrouter.ai/docs/client-sdks/typescript/api-reference/presets).

### Desired state versus remote response

No authenticated remote response was available. The following is the exact evidence boundary rather than a fabricated remote diff:

| Desired/local contract | Remote evidence | Difference / impact |
|---|---|---|
| Three semantic roles with fixed temporary run slugs | No authorized list or get response | Remote existence, active version and ownership are unknown; apply is blocked |
| `skin` plus comparable persisted `config` | Docs expose separate skin endpoints and a designated `config` object | A reconciler must compare the selected skin and persisted config, not the full inference body |
| No transient prompt/request fields in desired state | Docs say transient fields are ignored | Exclude ignored fields from desired-state identity |
| Stable private `id` / designated version identifiers | Docs show IDs and version fields | Persist only privately after live evidence; never add them to the versioned manifest |
| Provider/model/privacy/fallback policy | No live designated version | Concrete values remain unverified and must not be invented |

## 4. Local normalization and idempotence prototype

The disposable PowerShell prototype used a synthetic desired config with only harmless fields (`system_prompt`, `temperature`, `top_p`, `provider.allow_fallbacks`) and a synthetic remote-shaped response. It sorted object keys, preserved array order, ignored an unknown `experimental` field and compared only an explicit allowlist. It did not call OpenRouter and was removed from memory after the run.

| Case | Prototype result | Required production behavior |
|---|---|---|
| Missing remote preset | `missing` / `create` | Plan create after explicit approval |
| Exact in-sync | `in-sync` / `none` | No operation |
| Reordered response plus unknown field | `in-sync` / `none` | Normalize safe object ordering; ignore unknown response fields |
| One-field drift | `remote-drift` / `new-version` | Plan a new active version, preserving prior history |
| Unauthorized state | `unauthorized` / `blocked` | Stop with actionable authentication remediation |
| Second equivalent calculation | `no-op` | Portable normalization must prevent version churn; API deduplication was not assumed |

### Version and idempotence conclusion

The official API shape supports retaining previous versions and retrieving them by version number. It does not provide evidence that posting an equivalent request is deduplicated. Therefore the portable design must normalize before apply and must not create a new version for a semantic no-op. A live test is still required to prove designated-version behavior for the account and selected skin.

## 5. Partial failure model

Only a local synthetic failure model was exercised. It used the DESIGN-006 rule of one slug at a time, post-operation verification and no silent continuation:

```text
main   → verified
reason → verification-failed
fast   → not-started
outcome → partial-blocked
```

The evidence supports recording prior success and stopping after a failed verification. Automatic rollback was not inferred; the retained previous version and a manual recovery path remain the safe design. A live remote failure and retry behavior are unverified.

## 6. Exact OpenCode representation

**Conclusion: `BLOCKED / UNVERIFIED`.**

OpenRouter documents the wire-level request representation:

```json
{
  "model": "@preset/<slug>"
}
```

It also documents the combined `<model>@preset/<slug>` form. OpenCode's current documentation defines model selection as `provider/model`, or an expanded `{ "providerID": "...", "model": "..." }` object, and its provider configuration maps an OpenCode model key to an upstream `modelID`. No documented OpenCode preset field or verified mapping from an OpenCode model entry to `@preset/<slug>` was exercised here.

Because there was no credential and no provider-backed OpenCode turn, this spike cannot accept any of the following as production representation:

- `openrouter/@preset/<slug>`;
- a guessed `provider/model` alias;
- a custom `modelID` containing `@preset/<slug>`;
- a provider request-body override intended to inject a preset.

Do not populate the root `opencode.jsonc`, generated agent mappings or the concrete preset manifest with a guessed value. The three role mappings remain conceptually:

```text
build                            → main
plan, review, verify             → reason
general, explore, scout, small_model → fast
```

but runtime acceptance of the remote preset identity is blocked. See [OpenCode models](https://opencode.ai/v2/docs/models), [OpenCode providers](https://opencode.ai/v2/docs/providers) and [OpenRouter presets](https://openrouter.ai/docs/guides/features/presets).

## 7. Routing, fallback and tools

OpenRouter documentation exposes provider policy fields including provider order, `allow_fallbacks`, `require_parameters`, `data_collection` and `zdr`. It also documents model/provider routing and fallback as OpenRouter behavior. This supports retaining routing ownership in OpenRouter, but no resolved provider, fallback attempt or tool-capable request was captured.

Tool compatibility is therefore `UNVERIFIED`. A fallback must not be accepted for a role that requires tools unless a later authenticated test proves the fallback model/provider supports the required tool path. `require_parameters` can help reject providers that do not support requested parameters, but it is not evidence that an arbitrary fallback preserves OpenCode's tool contract.

References: [provider routing](https://openrouter.ai/docs/guides/routing/provider-selection) and [latency/fallback behavior](https://openrouter.ai/docs/guides/best-practices/latency-and-performance).

## 8. Privacy and data collection

| Requirement | Classification | Evidence / gap |
|---|---|---|
| Request-level deny of providers that may collect data | `request/preset-enforceable` by documented `provider.data_collection: "deny"` | Official request contract; not live-tested |
| Request-level ZDR routing | `request/preset-enforceable` by documented `provider.zdr: true` | Official request contract; not live-tested |
| Account-wide provider data policy | `account-enforceable-and-inspectable` in OpenRouter documentation, but not inspected here | Requires authenticated account surface |
| Prompt logging/account controls | `account-only-unverifiable` in this run | No private account access |
| Provider-specific retention/training guarantees | `account-only-unverifiable` / provider-dependent | OpenRouter exposes policy metadata, but this run cannot verify the selected endpoint or account policy |
| OpenRouter own prompt retention | Documentation says prompts are not retained unless prompt logging is enabled | Documentation-backed only; no account setting was inspected |

No privacy guarantee is promoted to the manifest. The future doctor must report unavailable account-level values instead of treating them as disabled.

References: [provider logging](https://openrouter.ai/docs/guides/privacy/provider-logging), [ZDR](https://openrouter.ai/docs/guides/features/zdr) and [provider routing policy fields](https://openrouter.ai/docs/guides/routing/provider-selection).

## 9. Usage, cache, reasoning, cost and errors

The official documentation states that non-streaming responses and the final streaming SSE message expose usage information. Documented fields include:

- prompt/input, completion/output and total token counts;
- reasoning token details when supported;
- prompt-cache read/write counters where supported;
- total cost and upstream inference cost;
- response model plus standard finish/error information;
- optional `openrouter_metadata` when `X-OpenRouter-Metadata: enabled` is sent, including requested model, selected provider/model, attempts and routing context.

These fields are available as documented source fields for later `OBS-03` ingestion, but none was captured from a real request in this spike. Cache behavior also has policy interaction: the documented response-cache feature is unavailable when account-level ZDR is enforced. Do not infer latency, fallback, provider, cost or cache values from an empty OpenCode session.

References: [usage accounting](https://openrouter.ai/docs/cookbook/administration/usage-accounting), [router metadata](https://openrouter.ai/docs/guides/features/router-metadata), [prompt caching](https://openrouter.ai/docs/guides/best-practices/prompt-caching) and [reasoning tokens](https://openrouter.ai/docs/guides/best-practices/reasoning-tokens).

## 10. Contract table OR-01 through OR-08

| Contract | Claim tested | Request/API surface | Evidence | Result | Impact |
|---|---|---|---|---|---|
| `OR-01` | One personal API key remains private and authentication failures are explicit | OpenRouter bearer-auth preset API; OpenCode private auth boundary | Missing-key environment check; unauthenticated list/get returned `401`; no positive auth test | `PARTIAL` | Failure path is known; authenticated setup and no-secret persistence fixture remain blocked |
| `OR-02` | Three semantic roles map to the three managed identities | Local role policy and preset manifest shape | DESIGN-002 and schema preserve the exact role/slugs; no remote or OpenCode invocation | `PARTIAL` | Mapping is accepted as design intent, but runtime preset references remain blocked |
| `OR-03` | Presets are reconciled with normalized idempotent desired state, versioning and no automatic deletion | List/get/version endpoints and create-from-skin endpoints | Official endpoint/response documentation; local synthetic normalization and no-op/drift/partial model; no authenticated mutation | `PARTIAL` | Production manifest and reconciler implementation remain unapproved; live account semantics required |
| `OR-04` | Provider routing/fallback remains OpenRouter-owned | Preset/request `provider` object | Official fields and fallback documentation; no resolved provider or fallback attempt | `UNVERIFIED` | Keep policy ownership in OpenRouter; runtime smoke test required |
| `OR-05` | Fallbacks preserve required tools and parameters | `allow_fallbacks`, `require_parameters`, tool-capable inference | Documentation exposes routing controls; no tool request or incompatible fallback test | `UNVERIFIED` | Do not accept a fallback for `main`, `reason` or `fast` until tool compatibility is proven |
| `OR-06` | ZDR, collection denial and logging policy are represented without overclaiming | `provider.data_collection`, `provider.zdr`, account privacy controls | Official request fields and privacy docs; no account inspection | `PARTIAL` | Doctor must distinguish request-enforceable from account-only-unverifiable fields |
| `OR-07` | Resolved model/provider, tokens, reasoning, cache, cost and errors feed observability | Chat/stream usage object and optional router metadata | Official usage/metadata docs; no live response | `PARTIAL` | Field contract is plausible/documented; runtime field availability and semantics remain unverified |
| `OR-08` | Spending cap is optional until real usage establishes a threshold | Account/key guardrail policy | Existing owner decision says absence does not block initial setup; no account surface required by this spike | `PASS` | Keep optional; revisit after authenticated usage evidence |

## 11. Decision and design impact

| Area | Outcome |
|---|---|
| `DEC-020` | **Retain**, with live authenticated validation still required before production activation |
| `DESIGN-006` | Add explicit API v1 endpoint/response boundary, normalize before version creation, treat `@preset/<slug>` as wire-level only, and keep account privacy/runtime fields unverified until authenticated evidence exists |
| `DESIGN-002` | Role mapping unchanged; exact OpenCode preset representation remains blocked and concrete models remain absent |
| `DESIGN-010` | OR-01 through OR-07 remain partial/unverified as shown above; post-spike implementation fixtures remain required |
| `config/components.jsonc` | Keep OpenRouter `evidence_state: "pending"`, no version or model/provider values added; update notes with the blocked authenticated lifecycle and OpenCode integration evidence |
| Concrete manifest | Do not create `config/openrouter/presets.jsonc`; model/provider/privacy values are not validated |
| New blocker | Yes: private authenticated fixture and OpenCode provider-backed preset invocation are required before environment health can be accepted |

## 12. Cleanup and discard boundary

No temporary remote presets were created, so no remote deletion was needed. No local fixture or child process was left by this run. The only retained artifact is this sanitized result; the in-memory comparison prototype, synthetic response objects and execution plan were discarded. No commit or push was performed.

## 13. Exact authenticated evidence gate still required

`SPIKE-002` may only move beyond `INCONCLUSIVE` after a separately authorized, disposable run supplies all of the following evidence. The credential must be injected through the private mechanism, checked for presence without printing its value, and absent from repository files, logs, traces and generated state.

| Gate | Required authenticated evidence | Acceptance condition |
|---|---|---|
| Auth boundary | OpenCode's private provider/auth path and the OpenRouter bearer request path | A positive request succeeds without persisting or exposing the credential; cleanup proves no secret-bearing fixture remains |
| Preset lifecycle | For each run-scoped `portable-spike-<run-id>-{main,reason,fast}` slug: list/get, create, designated-version read, version-list/version-get and cleanup | IDs and designated version are observed only in sanitized private evidence; canonical slugs are never mutated |
| Normalization/idempotence | Missing, exact, reordered/unknown-field, semantic no-op and one-field drift cases against live responses | No-op creates no new version; drift creates one designated new version while prior history remains; transient fields are excluded |
| Partial failure | One-slug-at-a-time apply with an induced verification failure or safe invalid operation | Prior success is recorded, later slugs do not continue silently, and retry/recovery behavior is explicit |
| OpenCode representation | Exact disposable `opencode-ai@1.18.30` provider/model configuration for a preset reference | One verified configuration invokes a run-scoped preset through OpenCode; no guessed alias or `modelID` is promoted |
| Roles, tools and routing | Synthetic `main`, `reason` and `fast` requests, including a tool-capable request and a controlled fallback/provider-policy case | Each role resolves to the intended preset; selected provider/model, fallback behavior and tool compatibility are captured or explicitly rejected |
| Privacy and usage | Authenticated account/request privacy visibility plus non-streaming and streaming usage with router metadata | Account-only fields are distinguished from request-enforceable fields; model/provider, tokens, reasoning/cache, cost, latency/TTFT and errors are recorded only when actually returned |

Until every row is satisfied, keep `OR-04`/`OR-05` unverified, keep the concrete manifest absent, and leave `SPIKE-003` blocked on this gate.

## 14. Next safe action

Run the gate above in a separately authorized disposable fixture, keeping the exact run-scoped slug pattern and synthetic prompts. Until then, OpenRouter policy remains `INCONCLUSIVE` and the environment cannot be marked healthy for the three managed presets.
