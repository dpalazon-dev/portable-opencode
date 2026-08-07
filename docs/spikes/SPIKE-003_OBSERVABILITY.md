---
type: Spike
id: SPIKE-003
title: Windows-Native Observability Contract
description: Bounded experiment for the transparent proxy, Phoenix lifecycle, privacy, correlation and local operational viability.
status: active
sources:
  - resource: ../context/ROADMAP.md
    title: Portable OpenCode Roadmap
  - resource: ../research/CONFIGURATION_SURFACE_RESEARCH.md
    title: Configuration Surface Research
  - resource: ../design/OBSERVABILITY_LIFECYCLE.md
    title: Windows-Native Observability Lifecycle
  - resource: ../design/CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: ../design/CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
---

# SPIKE-003 — Windows-native observability contract

## 1. Decision question

Can a native Windows localhost proxy preserve the OpenCode-to-OpenRouter protocol while emitting useful metadata-only OpenTelemetry/OpenInference traces into a local Phoenix process with safe lifecycle, loopback binding, private SQLite storage and acceptable overhead?

The spike exists to accept or reject `DEC-010`. Phoenix is a candidate backend, not a predetermined implementation outcome.

## 2. Decisions and contracts informed

This spike provides evidence for:

- `DEC-010` Phoenix acceptance;
- `DESIGN-005` lifecycle/storage/privacy defaults;
- `DESIGN-007` private resource and process ownership;
- `DESIGN-008` private paths and environment state;
- `DESIGN-009` observability lifecycle commands and diagnostics;
- matrix contracts `OBS-01` through `OBS-07`, plus relevant `SEC`, `CLI` and `VER` contracts.

## 3. Hypotheses

Test, do not assume:

1. a localhost OpenAI/OpenRouter-compatible proxy can forward the protocol transparently enough for OpenCode;
2. SSE streaming remains correct;
3. tool calls and structured outputs survive unchanged;
4. OpenRouter-specific usage, cost, provider and error metadata can be observed without logging full content;
5. credentials and secret-like values can be redacted before persistence;
6. Phoenix can run natively on Windows in an isolated Python environment without Docker/WSL/PostgreSQL;
7. Phoenix can bind loopback-only and persist to private SQLite;
8. OTLP HTTP ingestion is reliable from the proxy;
9. telemetry/external resources can be disabled as intended;
10. 30-day retention is supported and observable enough for doctor/status;
11. start/stop/status/recovery can own only portable-managed processes;
12. process death or backend failure can degrade observability without unnecessarily killing the coding session;
13. idle and active resource overhead is acceptable for the personal workflow;
14. session/agent/command/context/compaction metadata can be correlated only where SPIKE-001 exposes reliable signals.

## 4. Scope

### In scope

- disposable transparent proxy prototype;
- Phoenix isolated native install and lifecycle;
- SSE and non-streaming requests;
- tool calls;
- structured output;
- headers and errors needed for correctness;
- OpenRouter usage/cost/resolution metadata;
- OTLP/OpenInference trace shape;
- metadata-only default;
- redaction;
- loopback enforcement;
- SQLite persistence;
- retention settings;
- telemetry/external-resource disabling;
- PIDs, ports, stale state and process identity;
- locked database/failure recovery;
- bypass/degraded behaviour;
- correlation with reliable OpenCode session metadata;
- CPU, memory and disk observations.

### Out of scope

- production proxy architecture;
- remote observability;
- dashboards beyond what Phoenix provides natively;
- evaluation pipelines;
- prompt/response content capture as a default;
- PostgreSQL;
- Docker or WSL;
- Windows service/boot startup;
- choosing an alternate backend inside this spike if Phoenix fails.

## 5. Safety and privacy

Use synthetic prompts only.

Spike-private working root:

```text
%LOCALAPPDATA%\portable-opencode\spikes\003\
```

Do not use the future canonical Phoenix database as test storage.

Rules:

- bind all experimental services to `127.0.0.1`;
- never persist API keys or authorization headers;
- content capture remains disabled except for a deliberate synthetic fixture used solely to prove that the off-switch works, then purge it;
- sanitize committed evidence;
- do not expose ports through firewall rules;
- do not terminate processes whose identity cannot be proven as spike-managed;
- preserve the coding request path when observability fails where safe.

## 6. Required environment record

Record:

```text
Windows edition/build
PowerShell version
Python distribution/version
isolated-environment mechanism
Phoenix exact version
proxy prototype runtime/language
OpenCode version
OpenRouter test path from SPIKE-002 or provisional equivalent
ports used
```

No Phoenix version is accepted into `config/components.jsonc` before the acceptance gate passes.

## 7. Prototype boundary

The proxy prototype needs only enough implementation to prove the transport and telemetry contract.

It may:

- accept the OpenAI/OpenRouter-compatible request shape required by the tested OpenCode provider path;
- forward requests to OpenRouter;
- preserve streaming and errors;
- observe response metadata;
- emit OTLP/OpenInference spans;
- expose a minimal local health endpoint if needed for lifecycle testing.

It must not become the production CLI, configuration core or generic gateway.

## 8. Procedure

### Test group A — Phoenix native installation

1. create an isolated Python environment under the spike-private root;
2. install one exact Phoenix version from the current supported package source;
3. start using the current supported terminal command;
4. prove the process runs without Docker/WSL/PostgreSQL;
5. record executable/package identity;
6. stop cleanly and start again from a new PowerShell session.

Compare `venv`, `uv tool`, `pipx` or equivalent only if necessary to determine a safe lifecycle mechanism. Do not generalize packaging beyond the evidence needed by DEC-010/012.

### Test group B — Network and storage contract

1. bind Phoenix HTTP and any enabled OTLP/gRPC endpoints to loopback;
2. verify listening sockets from Windows;
3. confirm no unexpected non-loopback listener exists;
4. configure SQLite under the spike-private root;
5. ingest one synthetic span;
6. restart Phoenix and prove persistence;
7. record database files and locking behaviour.

A non-loopback-only default that cannot be safely constrained fails the acceptance gate.

### Test group C — Telemetry and external-resource disabling

Apply the intended settings for:

- Phoenix telemetry disabled;
- external resources disabled;
- provider/model playground access disabled or constrained where the tested version supports it.

Verify each setting through observable behaviour/configuration. If a setting is documented but not externally verifiable, classify it explicitly instead of asserting enforcement.

### Test group D — Retention

1. configure the intended 30-day default using the tested Phoenix version;
2. inspect how the setting appears in runtime/project state;
3. determine whether existing projects can override it;
4. determine how deletion/retention is triggered and observed;
5. use synthetic short-lived data or documented dry mechanisms to avoid waiting 30 days;
6. record what `status` and `doctor` can reliably report.

Do not pretend to have observed 30 real days of retention if the spike only proves configuration semantics.

### Test group E — Basic transparent proxying

Using a synthetic non-streaming request:

1. configure OpenCode or a protocol-equivalent client to use the localhost proxy as base URL;
2. forward to OpenRouter;
3. compare status, response body semantics and relevant headers with a direct control request;
4. capture request/response timing;
5. ensure authorization is forwarded in memory but absent from logs/traces/storage;
6. prove the client cannot distinguish the proxy for the tested contract except expected latency.

### Test group F — SSE streaming

1. send a streaming request through the proxy;
2. preserve chunk ordering and framing;
3. preserve termination semantics;
4. measure time-to-first-token/chunk where observable;
5. inject one upstream streaming error if safely reproducible and preserve error behaviour;
6. verify the proxy does not buffer the complete content merely to emit telemetry.

Streaming failure is blocking for the proxy design.

### Test group G — Tool calls and structured outputs

Using synthetic tool definitions and structured-output requests:

- prove tool-call request fields arrive upstream unchanged;
- prove tool-call response/deltas return to the client unchanged;
- prove structured-output schema and response survive;
- record any OpenRouter-specific fields that require pass-through handling;
- test one malformed/unsupported request and preserve the upstream error contract.

### Test group H — Metadata extraction

For streaming and non-streaming responses, classify availability of:

```text
requested model/preset
resolved model
resolved provider
input tokens
output tokens
reasoning tokens
cache fields
cost
latency
TTFT where measurable
fallback/retry evidence
error type/status
```

Prefer fields returned by OpenRouter. Do not recompute cost when an authoritative field exists.

### Test group I — Metadata-only trace shape

Emit OpenTelemetry/OpenInference traces containing only allowed metadata by default.

Required correlation candidates:

```text
project
session
agent
command
request id
model/preset
provider
usage
cost
latency
cache
fallback
error
```

If SPIKE-001 provides reliable context/compaction fields, test correlation for those. Otherwise mark them unavailable and keep the trace schema extensible.

Verify that prompt text, response text, tool arguments containing arbitrary content and authorization headers are absent by default.

### Test group J — Redaction

Construct synthetic secret-like values in:

- authorization header;
- custom header;
- environment-derived value;
- tool argument;
- error text.

Prove the redaction boundary removes or masks them before trace/log persistence.

The exact synthetic values must be recognizable enough to search the Phoenix SQLite/log files after the request.

No real credential is used as a redaction fixture.

### Test group K — Process lifecycle

Prototype the semantics required by:

```text
observability start
observability stop
observability status
observability open
observability purge
```

Test:

- Phoenix starts before proxy;
- health checks before declaring healthy;
- PID/process identity recording;
- stale PID file;
- occupied port by an unrelated process;
- one managed process already running;
- graceful stop;
- forced termination after timeout only for proven-owned process;
- restart after abnormal death;
- locked SQLite during stop/reset.

Never kill an unrelated process to free a port.

### Test group L — Degraded/bypass behaviour

1. start a proxied coding request path;
2. stop or break Phoenix while keeping proxy forwarding safe if possible;
3. record whether inference continues with observability degraded;
4. test proxy failure separately;
5. determine the exact safe bypass/remediation semantics without silently changing provider privacy/routing.

The result must distinguish backend failure from proxy failure.

### Test group M — Resource overhead

Measure approximately, with the same synthetic workload:

```text
Phoenix idle CPU/memory
proxy idle CPU/memory
active CPU/memory
SQLite growth for representative metadata-only traces
latency overhead
streaming TTFT overhead
startup time
```

The project does not yet define a hard numeric threshold. The spike must provide enough measurements to make a reasoned accept/reject decision for a single-user development machine.

## 9. Required evidence table

The result must contain one row for `OBS-01` through `OBS-07`:

```text
contract
claim tested
version/environment
evidence
result: pass | fail | partial | unverified
impact
```

Also include a privacy evidence table mapping `SEC-04` and `SEC-05` plus any secret-redaction findings.

## 10. Acceptance criteria for DEC-010

Accept Phoenix only if all of these are true:

- native Windows operation works without Docker/WSL;
- isolated installation is reproducible enough for the supported component manifest;
- loopback-only binding is enforceable;
- private SQLite persistence works;
- proxy-to-Phoenix OTLP/OpenInference ingestion is reliable;
- SSE streaming remains correct;
- tool calls and structured outputs remain correct;
- metadata-only traces provide useful model/provider/usage/cost/error visibility;
- secrets can be redacted before persistence;
- prompt/response content remains absent by default;
- lifecycle can identify and manage only owned processes;
- recovery from stale PIDs, ports and locked files is understandable;
- 30-day retention can be configured and reported honestly;
- telemetry/external-resource defaults can be applied to an acceptable degree;
- observed resource overhead is acceptable for the personal workflow.

Any failure in streaming correctness, secret redaction, loopback enforcement or process ownership is blocking.

## 11. Decision impact

The result must end with:

```text
DEC-010: accept | reject | inconclusive
Phoenix exact version: value | none
isolated install mechanism: value | unresolved
proxy protocol contract: pass | fail | partial
metadata fields available: list
privacy gaps: list
resource overhead summary: values
DESIGN-005 corrections: none | list
DESIGN-008 path corrections: none | list
component manifest updates: exact values
new blocker: yes | no
```

If Phoenix is rejected, do not select Langfuse or another backend inside this spike. Open a separate bounded evaluation while preserving the proxy requirements.

## 12. Deliverables

Required:

```text
docs/spikes/results/SPIKE-003.md
```

Optional safe experimental evidence:

```text
spikes/SPIKE-003/proxy/
spikes/SPIKE-003/scripts/
spikes/SPIKE-003/fixtures/
```

Do not commit the SQLite database, raw trace export, real headers or private logs.

## 13. Codex assignment contract

Execute on a dedicated branch conceptually named:

```text
spike/003-observability
```

Rules for Codex:

- read `DESIGN-005`, `DESIGN-007`, `DESIGN-008`, `DESIGN-009` and this spike first;
- use native Windows only;
- keep all runtime state under the spike-private root;
- use synthetic prompts/secrets;
- do not expose services beyond loopback;
- do not turn the proxy prototype into production architecture;
- do not choose an alternate backend if Phoenix fails;
- preserve streaming correctness over telemetry completeness;
- preserve coding continuity over observability when a safe degraded mode exists;
- record exact versions, commands and measured overhead;
- finish with an explicit DEC-010 recommendation and contract corrections.

## 14. Discard boundary

The proxy prototype, temporary Python environment, SQLite database and runtime files are disposable. Keep only sanitized evidence, minimal transport/redaction fixtures and separately approved design changes.
