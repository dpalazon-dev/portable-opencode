---
type: Design
id: DESIGN-006
title: OpenRouter Preset Reconciliation
description: Declarative inspect, plan and apply policy for the three managed semantic presets.
status: active
sources:
  - resource: https://openrouter.ai/docs/guides/features/presets
    title: OpenRouter presets
  - resource: https://openrouter.ai/docs/api/api-reference/presets/list-presets
    title: OpenRouter preset API
---

# OpenRouter preset reconciliation

## 1. Objective

Make the `main`, `reason` and `fast` policies reproducible without requiring manual dashboard setup and without treating remote OpenRouter state as safe to overwrite blindly.

The repository owns desired intent. OpenRouter owns active remote presets and version history.

## 2. Managed presets

```text
portable-main
portable-reason
portable-fast
```

Only these exact slugs are managed by the canonical personal configuration.

Other user presets are out of scope and must not be modified, renamed or deleted.

## 3. Desired-state manifest

Versioned location:

```text
config/openrouter/presets.jsonc
```

Conceptual structure:

```jsonc
{
  "$schema": "../../schemas/openrouter-presets.schema.json",
  "presets": {
    "main": {
      "slug": "portable-main",
      "skin": "chat-completions",
      "config": {}
    },
    "reason": {
      "slug": "portable-reason",
      "skin": "chat-completions",
      "config": {}
    },
    "fast": {
      "slug": "portable-fast",
      "skin": "chat-completions",
      "config": {}
    }
  }
}
```

Concrete model, provider, fallback, privacy and generation settings are added only after SPIKE-002 validates them.

The manifest contains no API key, workspace secret or mutable remote identifier.

## 4. Reconciliation model

```text
local desired manifest
→ inspect remote presets and designated versions
→ normalize comparable configuration
→ produce remote change plan
→ explicit approval
→ create missing preset or create new version
→ verify active designated version
→ record outcome
```

Remote mutation never occurs during inspection or planning.

## 5. Inspection

The CLI queries:

- preset list;
- each managed preset by slug;
- designated active version;
- version history when drift or rollback information is needed.

It reports for each role:

```text
missing
in-sync
remote-drift
unreadable
unauthorized
```

The comparison excludes fields that OpenRouter does not persist from inference bodies and normalizes semantically equivalent ordering where safe.

Unknown or beta API response fields do not enter the canonical manifest automatically.

## 6. Planning

### Missing preset

Plan:

```text
create portable-<role> version 1
```

### Drifted managed preset

Plan:

```text
create new active version for portable-<role>
```

The plan shows:

- role and slug;
- current designated version;
- normalized field diff;
- proposed request skin and persisted config;
- privacy, routing and fallback consequences;
- whether tool compatibility has been verified;
- previous version retained for manual rollback.

### In-sync preset

No operation.

### Extra remote preset

No operation and no warning unless it collides with a reserved managed slug or creates an OpenCode ambiguity.

## 7. Apply policy

- remote changes require the normal portable plan/apply boundary;
- creating a missing preset is allowed after explicit approval;
- changing a managed preset creates a new OpenRouter version rather than deleting history;
- operations execute one managed slug at a time and record partial success;
- after each operation, retrieve the designated version and compare it with the intended normalized configuration;
- a failed verification marks the preset `blocked` and does not continue silently;
- no automatic deletion, archival or rename is part of the MVP;
- no automatic rollback is performed; the CLI reports retained prior versions and a manual recovery path.

## 8. First installation behaviour

`portable-opencode install` includes preset reconciliation in its global plan.

Default flow:

```text
inspect credentials
→ inspect managed presets
→ show create/version operations
→ approve
→ apply
→ run authenticated preset smoke tests
→ mark OpenRouter policy healthy
```

A verify-only mode is available through `inspect`, `doctor` and dry-run. It is not the canonical completed setup because manual dashboard configuration would break reproducibility.

If the preset API is unavailable or cannot be made idempotent, the CLI falls back to explicit manual remediation and keeps OpenRouter policy `blocked` or `degraded` according to whether direct model references remain a safe temporary path.

## 9. Ownership and state

### Versioned

- role names and slugs;
- desired preset configuration;
- schema version;
- normalized comparison rules;
- smoke-test intent.

### Private machine state

May record non-secret operational facts:

- remote preset ID;
- designated version ID and number;
- last successful reconciliation time;
- normalized desired-state hash;
- last smoke-test result.

The API key remains in OpenCode's private auth store or another accepted private mechanism.

## 10. OpenCode integration boundary

OpenRouter documents direct preset references such as `@preset/<slug>`, but the exact identifier accepted through OpenCode remains unproven.

SPIKE-002 must validate whether OpenCode should use:

- a direct preset model reference;
- a provider model alias;
- a preset request field;
- another documented provider configuration mechanism.

The reconciler can manage remote presets independently of this representation, but environment `healthy` requires both remote preset correctness and successful OpenCode inference through each required role.

## 11. Smoke tests

After reconciliation:

- `main`: tool-capable minimal coding request;
- `reason`: deterministic analysis request with required reasoning policy;
- `fast`: low-cost lightweight request;
- capture requested preset, resolved model/provider, usage and cost;
- verify required parameters and privacy policy;
- reject a fallback that removes required tool support.

Test prompts must be synthetic and contain no project secrets.

## 12. Failure policy

| Failure | State |
|---|---|
| missing API key | blocked |
| managed preset missing before approved apply | planned, then blocked if skipped |
| unauthorized preset API | blocked |
| remote drift | update-required |
| one of three preset applies fails | degraded or blocked by affected required role |
| smoke test fails | blocked for that role |
| extra unmanaged preset | ignored |
| inability to inspect account-level privacy | warning with explicit unverifiable field |

## 13. SPIKE-002 validation

Validate:

- list/get/version response shapes;
- create-new and create-new-version semantics;
- fields persisted from each request skin;
- normalized comparison and idempotent second run;
- partial failure and retry behaviour;
- exact OpenCode preset representation;
- tool, routing, fallback and privacy behaviour;
- designated version verification;
- API limits, errors and authentication;
- stable identifiers worth storing privately.

## 14. Reconsideration triggers

Change this policy only when:

- OpenRouter adds a first-class declarative update/delete API with safer semantics;
- preset version creation ceases to designate the new active version;
- OpenCode supports local named aliases that make remote presets unnecessary;
- the owner intentionally stops using OpenRouter presets;
- multiple real profiles require separate preset namespaces.
