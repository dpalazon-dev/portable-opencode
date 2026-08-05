---
type: Design
id: DESIGN-005
title: Windows-Native Observability Lifecycle
description: Proposed local Phoenix and proxy lifecycle, storage, privacy and retention policy.
status: proposed
decision: DEC-010
sources:
  - resource: https://arize.com/docs/phoenix/self-hosting/deployment-options
    title: Phoenix terminal deployment
  - resource: https://arize.com/docs/phoenix/self-hosting/configuration
    title: Phoenix self-hosting configuration
  - resource: https://arize.com/docs/phoenix/settings/data-retention
    title: Phoenix data retention
---

# Windows-native observability lifecycle

## 1. Objective

Provide useful local inference observability on the owner's Windows machine without Docker, WSL, PostgreSQL, a Windows service or indefinite trace accumulation.

This design fixes the intended default. `DEC-010` remains proposed until `SPIKE-003` demonstrates that Phoenix and the transparent proxy work reliably together on Windows.

## 2. Selected deployment shape

```text
OpenCode
→ portable localhost proxy
→ OpenRouter

portable proxy
→ OTLP HTTP
→ Phoenix native terminal process
→ private SQLite storage
```

### Phoenix runtime

- install the pinned `arize-phoenix` package in an isolated managed Python environment;
- launch through the current supported CLI form of `phoenix serve`;
- do not install Phoenix into the user's global Python environment;
- do not use Docker or WSL in the MVP;
- do not use PostgreSQL for a single-user local deployment;
- do not register a Windows service or scheduled startup task.

The exact isolated-environment mechanism—managed venv, `uv tool`, `pipx` or equivalent—is selected by `SPIKE-003` and the final packaging decision.

## 3. Lifecycle commands

```text
portable-opencode observability start
portable-opencode observability stop
portable-opencode observability status
portable-opencode observability open
portable-opencode observability purge
```

### `start`

- inspect ports and existing managed PIDs;
- start Phoenix first and wait for health;
- start the transparent proxy and wait for health;
- record executable versions, PIDs, ports and working directories in private machine state;
- refuse to claim ownership of unrelated processes already using required ports;
- return `healthy` only when Phoenix ingestion and proxy forwarding both pass.

### `stop`

- stop only processes proven to be managed by portable-opencode;
- request graceful shutdown before forced termination;
- preserve SQLite data and diagnostic logs;
- clear stale PID state only after process identity checks.

### `status`

Report separately:

- Phoenix process and health;
- proxy process and health;
- UI and OTLP endpoints;
- storage path and approximate size;
- retention policy;
- last successful trace ingestion;
- bypass/degraded state;
- port or stale-process conflicts.

### `open`

Open the loopback Phoenix UI in the default browser only after a health check.

### `purge`

- show affected Phoenix projects and retention consequences;
- prefer Phoenix retention/API mechanisms;
- require explicit approval for immediate deletion;
- never delete unrelated application directories;
- allow full local database reset only as an explicit repair action with Phoenix stopped.

## 4. Network defaults

```text
PHOENIX_HOST=127.0.0.1
PHOENIX_PORT=6006
PHOENIX_GRPC_PORT=4317
```

The proxy uses another fixed loopback port selected in the final configuration design.

Rules:

- loopback binding is mandatory for `healthy`;
- unexpected non-loopback listening blocks healthy state;
- port conflicts produce findings and do not trigger blind process termination;
- the proxy exports traces through OTLP HTTP at `http://127.0.0.1:6006/v1/traces` unless SPIKE-003 proves another supported endpoint is necessary;
- gRPC may remain unused but must not become externally exposed.

## 5. Storage

Use Phoenix's SQLite backend because official guidance identifies SQLite for local and single-user deployments.

Private working directory:

```text
%LOCALAPPDATA%\portable-opencode\phoenix\
```

Expected private contents include database files, runtime logs and Phoenix state.

Rules:

- the directory never enters Git;
- trace storage is operational and disposable, not a project source of truth;
- no automatic backup is required for the MVP;
- database corruption degrades observability and may be repaired by explicit reset;
- project context, model-role intent and durable decisions must never depend solely on Phoenix data.

## 6. Retention

Default:

```text
PHOENIX_DEFAULT_RETENTION_POLICY_DAYS=30
```

Rationale:

- enough history for recent session, model and cost inspection;
- avoids Phoenix's indefinite-retention default;
- metadata-only traces make the window useful without encouraging long-term content storage;
- longer history can be chosen explicitly after real usage establishes a need.

Rules:

- 30 days is the global default for new Phoenix projects;
- project-specific indefinite retention is not created automatically;
- the CLI reports when existing Phoenix projects override the default;
- retention changes require an explicit plan because deletion is irreversible;
- aggregated long-term cost reporting, if later required, should use a separate minimal derived store rather than preserving raw traces indefinitely.

## 7. Privacy defaults

```text
PHOENIX_TELEMETRY_ENABLED=false
PHOENIX_ALLOW_EXTERNAL_RESOURCES=false
```

When supported by the selected Phoenix version:

```text
PHOENIX_ALLOWED_PROVIDERS=NONE
```

Rationale:

- Phoenix is used as a collector and trace explorer, not as a model playground;
- disable UI analytics and unnecessary external resource loading;
- reduce accidental provider interactions from the Phoenix UI.

Additional rules:

- proxy content capture remains off by default;
- credentials and authorization headers are redacted before export;
- authentication is not enabled in the MVP because the service is loopback-only and single-user;
- any move beyond loopback requires a separate security decision and authentication.

## 8. Start policy

Phoenix and the proxy are **on demand**, not boot services.

- installation configures them but does not run them permanently;
- a portable OpenCode launcher may later ensure observability is running before a coding session;
- direct OpenRouter use while observability is stopped is allowed only as explicit degraded mode;
- unexpected process death marks observability degraded and preserves the coding session where safe.

## 9. Version policy

- pin one Phoenix version in the supported-version manifest;
- do not track `latest` implicitly;
- upgrades require stop, backup-or-reset assessment, migration plan, start and ingestion verification;
- Phoenix CLI breaking changes are adapter concerns and must be covered by versioned commands and smoke tests.

## 10. SPIKE-003 validation

Validate on Windows without WSL:

- installation in an isolated Python environment;
- `phoenix serve` startup and shutdown;
- loopback binding for HTTP and gRPC;
- persistent SQLite working directory;
- retention policy application and cleanup visibility;
- telemetry/external-resource/provider disabling;
- OTLP HTTP ingestion from the portable proxy;
- SSE, tools, errors and redaction through the proxy;
- process identity, stale PID and port-conflict handling;
- interruption, forced termination and locked SQLite files;
- idle and active memory/CPU/disk use;
- database reset and recovery;
- current CLI syntax for the pinned Phoenix version.

## 11. Acceptance gate for DEC-010

Accept Phoenix as the MVP backend only when SPIKE-003 shows:

- native Windows operation without Docker or WSL;
- reliable proxy-to-Phoenix ingestion;
- safe start, stop and recovery;
- acceptable resource overhead;
- private persistent SQLite storage;
- enforceable loopback, telemetry and 30-day retention defaults.

If Phoenix fails this gate, keep the proxy and evaluate a smaller OTLP-compatible local backend rather than weakening Windows-native or privacy requirements.
