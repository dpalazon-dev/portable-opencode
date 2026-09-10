---
type: Design
id: DESIGN-013
title: Guided Installation and Onboarding
description: Formal contract for a guided, resumable, browser-assisted and secret-safe Windows installation flow.
status: active
decision: DEC-022
sources:
  - resource: ../context/PROJECT.md
    title: Portable OpenCode Project Definition
  - resource: ../context/ARCHITECTURE.md
    title: Portable OpenCode Architecture
  - resource: ../context/OPERATIONS.md
    title: Portable OpenCode Development Operations
  - resource: CLI_OPERATION_CONTRACTS.md
    title: CLI Operation Contracts
  - resource: CANONICAL_RESOURCE_CATALOG.md
    title: Canonical Resource Catalog and File Trees
  - resource: MANAGED_CONFIGURATION_MATERIALIZATION.md
    title: Managed Configuration Materialization
  - resource: POWERSHELL_SCRIPT_INVENTORY.md
    title: PowerShell Script Inventory
  - resource: ../spikes/SPIKE-002_OPENROUTER_POLICY.md
    title: OpenRouter Policy Contract
---

# Guided installation and onboarding

## 1. Purpose and status

This design fixes the contract for the first-machine journey:

```text
independently authenticated bootstrap bytes for a public GitHub Release
→ one PowerShell bootstrap command
→ verified portable-opencode CLI
→ non-mutating preflight
→ explicit plan and approval
→ guided installation
→ native OpenCode authentication
→ configuration and verification
→ final doctor
```

The contract is accepted at the product level by `DEC-022`, and owner approval of `DESIGN-013` is recorded. The design is ready for implementation planning, but approval does not select an implementation language, package format, OpenCode version, OpenRouter representation or Phoenix deployment. Those choices remain evidence-gated as described in Section 21.

This document defines behaviour and boundaries only. It creates no CLI, bootstrap script, installer, fixture or prototype.

## 2. Three-layer distribution boundary

The distribution path has three deliberately separate layers.

### 2.1. GitHub Release

The public GitHub Release is the versioned distribution channel. A release provides, subject to `DEC-012` evidence:

- an immutable release identity and version;
- platform and architecture metadata;
- the CLI asset or package required by the bootstrap;
- integrity metadata, including a verifiable digest and a release signature whose trust anchor is established outside the same Release;
- a release manifest that contains no credentials;
- the official URLs needed for browser-assisted onboarding.

The release is not the installer. It does not inspect the machine, ask semantic questions, write configuration, authenticate a provider or reconcile remote state.

Release selection is explicit. The bootstrap must resolve a concrete version or an approved release channel to one immutable release identity before invoking the CLI. Floating tags, unverified redirects and unpinned package content are not valid installation inputs.

The checksum and signature have different security meanings. A checksum downloaded from the same Release detects transfer corruption or an asset mismatch; it does not authenticate the release origin if the repository, account or release metadata is compromised. A production bootstrap therefore requires an independent trust anchor available before release metadata is trusted: for example, an out-of-band publisher key fingerprint or an accepted platform/package-signing root. The exact mechanism remains `DEC-012` evidence-gated, but an integrity-only path is not a successful production installation.

The signature must cover a canonical release manifest containing the repository identity, release identity, target platform, asset identity and asset digest. A key fetched only from the same Release is not an independent trust anchor. Key rotation, revocation and emergency release blocking require an out-of-band trust update; the bootstrap must not silently replace its trust anchor.

### 2.1.1. Bootstrap acquisition trust gate

The bootstrap bytes are themselves executable input. An already trusted acquisition launcher or gate must authenticate the exact bytes before PowerShell parses or executes them. The production trust chain is therefore:

```text
independent trust root
→ authenticate the exact bootstrap bytes
→ execute the authenticated bootstrap
→ authenticate the canonical release manifest
→ verify asset digests and establish the CLI transactionally
```

The one-command user experience does not waive this gate. A production path must not execute an unverified remote script, including a download-and-immediate-pipe form equivalent to `Invoke-WebRequest ... | Invoke-Expression`, `irm ... | iex` or an equivalent launcher. The command may invoke a verified launcher or a locally staged, independently authenticated bootstrap, but it must never treat transport success or same-Release metadata as proof of executable origin.

The independent root may be anchored in the operating system, an accepted package platform or material distributed outside GitHub. The exact root, signature format, key rotation and package mechanism remain blocked by `DEC-012`; the repository copy is a development source boundary, not an automatic production trust root. If the bootstrap bytes or the complete chain cannot be authenticated before execution, production bootstrap is `BLOCKED`.

### 2.2. `bootstrap.ps1`

`bootstrap.ps1` is the smallest possible Windows entrypoint. It begins only after an external acquisition gate has authenticated its exact bytes. Its only product responsibility is to establish a verifiable CLI invocation from a clean supported machine.

It may:

- confirm Windows and the supported architecture;
- obtain public release metadata and the selected CLI asset over HTTPS;
- validate the asset's release identity, digest and signature against the independent trust anchor;
- stage the selected CLI in a private bootstrap-owned location;
- verify the staged identity, digest, signature and version before activation;
- activate an isolated immutable CLI identity atomically;
- invoke `portable-opencode --version` and verify the reported identity;
- print or return the next `portable-opencode install` command.

CLI establishment is transactional even though it is the bootstrap's limited mutation. Its invariants are:

1. staging is private and distinct from the active CLI location;
2. every byte, identity, signature, digest and reported version is verified before activation;
3. each release is isolated by an immutable version or identity, and activation is atomic;
4. an equivalent repetition is a `no-op` when the verified identity is already active;
5. an existing path is never overwritten when ownership cannot be proven;
6. the previous verified CLI remains available until the new CLI passes activation and startup verification;
7. interruption leaves either the previous active CLI or the complete new CLI, never a partially activated CLI;
8. cleanup removes only temporary paths created and tagged by this bootstrap invocation;
9. the bootstrap can restore the last verified CLI identity without repairing OpenCode configuration or environment state;
10. Recovery of the bootstrap's own CLI identities belongs to the bootstrap, while environment backups and configuration recovery belong to the CLI.

The concrete staging, activation and packaging primitives remain evidence-gated by `DEC-009` and `DEC-012`.

It must not:

- inspect or write OpenCode configuration;
- install or configure OpenCode, OpenRouter, RTK, Graphify or Phoenix;
- open authentication pages;
- read, receive or store credentials;
- create the environment checkpoint;
- manage ownership, backups, drift or recovery for any environment resource;
- contain a second implementation of the CLI lifecycle.

The bootstrap may govern ownership and recovery only inside its private CLI boundary: bootstrap-owned staging directories, immutable CLI version identities, the active-version selector, minimal private identity metadata, recognized invocation temporaries and restoration of the last verified CLI. The installed CLI is not an entry in the environment's managed-resource graph. `portable-opencode install` remains the sole owner of the environment lifecycle, plans, approvals, configuration, checkpoints, environment backups, environment ownership, environment drift and environment recovery.

The final low-level download and package primitives remain subject to `DEC-009`, `DEC-012` and `SPIKE-001`. The boundary does not.

### 2.3. `portable-opencode install`

The CLI owns the installation lifecycle. It owns inspection, planning, approval, mutation, checkpointing, native-auth handoff, configuration, verification, diagnostics and recovery. All mutation remains inside the common `inspect → plan → approve → apply → doctor` model from `DESIGN-009`.

`install` is an orchestration convenience, not a second mutation engine:

```text
inspect
→ collect semantic decisions required by the pre-auth plan
→ approve the exact pre-auth plan
→ apply pre-auth operations in dependency order
→ authenticated re-inspection
→ approve the exact authenticated plan
→ apply authenticated operations in dependency order
→ doctor
```

## 3. Clean-machine minimum

The minimum is the intersection of the release manifest, the supported-component manifest and the following fixed product requirements.

| Area | Minimum condition | If absent |
|---|---|---|
| Operating system | Native Windows version accepted by the release and component manifests | `BLOCKED` |
| Architecture | A published release asset and supported component path exist for the detected architecture | `BLOCKED` |
| PowerShell | A supported Windows PowerShell environment can run the bootstrap without changing execution policy; a supported `pwsh` is reported separately | `BLOCKED` for bootstrap, unless the accepted package contract provides another verified entrypoint |
| Network | HTTPS access to the public GitHub Release and every required official package source | `BLOCKED` for a network-dependent step; no offline fallback is implied |
| Bootstrap trust | The exact bootstrap bytes and their complete chain are authenticated before PowerShell execution | `BLOCKED`; a public URL, transport success or same-Release checksum is insufficient |
| Release trust | An independent publisher/platform trust anchor is available before release metadata is trusted, and the selected manifest/asset signature verifies | `BLOCKED`; a same-Release checksum alone is insufficient |
| User scope | Write access to the user's private application data and managed installation locations; elevation is not assumed | `BLOCKED` only for a required target |
| Browser | A default browser can open official onboarding pages when authentication or an external account action is required | `DEGRADED` only if the step is optional; otherwise `BLOCKED` with a manual URL |
| Storage | Enough free space for the selected release, supported components, backups and private runtime state | `BLOCKED` when the computed requirement is not met |
| Credentials | No credential is required by the bootstrap or preflight | Never a preflight blocker; native authentication may later be required |
| Git, GitHub and SSH | None is required to download or install the environment | `WARNING` when absent; `BLOCKED` only inside an explicitly selected optional module |

The CLI must not claim that a machine is clean because it has no files. It must inspect relevant existing state before it decides whether the installation is safe.

## 4. Non-mutating preflight

Preflight is a read-only observation phase and remains safe to repeat. It may execute read-only version queries, resolve names, inspect ACLs and enumerate processes. It must not install, configure, stop, delete, adopt, authenticate, change `PATH`, change execution policy, create a persistent directory, open a credential prompt or modify a remote service. It returns evidence in memory or in the current command's structured output; it does not persist a preflight result, write `environment-state.json`, create a checkpoint or append a persistent log.

Checkpointing begins only after the user approves the exact plan and immediately before the first approved side effect. The checkpoint records the preflight and plan hashes as inputs to the approved operation; it does not turn preflight itself into a mutation. If the user exits before approval, the next invocation runs a fresh preflight and plan. An explicit `plan --out <file>` is a separate user-requested plan export, not a preflight write.

There is no temporary-write exception. Preflight may use only mechanisms that are demonstrably read-only. If a check requires creating or modifying a file or directory, starting a helper with side effects, changing process state, changing configuration or contacting a remote service in a mutating way, it is not preflight: it becomes an operation in the plan and may execute only after the exact plan is approved and the first checkpoint is persisted. Temporary cleanup is not a justification for treating that operation as non-mutating.

### 4.1. Required inspection set

| Domain | Evidence collected without mutation |
|---|---|
| Windows and architecture | Windows product/build, native versus WSL context, process architecture, user scope, elevation state, supported-release match and unsupported-platform reason |
| PowerShell | executable identity, edition, version, host, execution-policy visibility and whether the bootstrap can run without policy mutation; availability of `pwsh` is informational unless required by an evidenced component |
| Connectivity | DNS resolution, HTTPS reachability, TLS negotiation, certificate validation, proxy discovery, proxy reachability and whether a proxy requires user action; no proxy password or credential value is read |
| Official sources | public GitHub Release metadata, selected asset, package indexes and official pages required by the selected plan; source identity, status and latency are recorded, not downloaded packages beyond the bootstrap asset |
| Space and permissions | free bytes on relevant volumes, ACL/effective access for private roots and managed targets, path length constraints where relevant, and whether existing backups can be read; no target is created or changed |
| `PATH` | user and machine entries, command resolution, duplicate or shadowed executable names, and whether the planned CLI location is already resolvable; `PATH` is never modified by preflight |
| Existing components | identity, version, executable path, package source where knowable, process owner, install owner and compatibility status for OpenCode, its runtime, RTK, Graphify, observability components and optional Git/GitHub/SSH tools |
| Processes and locks | relevant running processes, managed process identities, open ports, PIDs, locked managed targets and active OpenCode sessions; no process is stopped and no lock is bypassed |
| Configuration and ownership | canonical targets, noncanonical OpenCode files, active environment overrides, private override schema, managed-resource inventory, prior backups, hashes, ownership evidence and drift; unknown resources remain unknown |
| Native credential presence | existence, metadata, ACL and ownership of the OpenCode native auth store; presence of secret-like environment variable names, credential-manager integration and optional tool auth metadata; values and file contents are never read |
| Existing checkpoint | state schema version, lifecycle state, release identity, plan identity, checkpoint sequence, last operation and resumability; invalid or newer state is read-only evidence and is never overwritten by preflight |

### 4.2. Credential-presence rule

The preflight may answer only questions such as:

- does the native auth store exist;
- can the native OpenCode status mechanism report authentication without exposing its raw output;
- is a known secret-bearing environment variable name present;
- does an optional GitHub or SSH integration appear configured.

`portable-opencode` never requests, accepts, accesses, loads, copies, compares or stores the value of an API key, token, cookie, OAuth code, private key or passphrase. It observes only names and non-secret metadata. Child processes are launched with an explicit environment allowlist or equivalent scrub policy; known secret-bearing variables are not inherited by default. It may not read a secret value, infer a secret from its length, copy a credential, inspect browser cookies, invoke a credential helper in a way that returns a secret, or include raw command output in a log.

The native OpenCode authentication mechanism retains credential custody. Its input and sensitive output are not captured by portable-opencode. Native status adapters may return only a sanitized status or an explicit `sensitive evidence suppressed` marker. If OpenCode does not expose a demonstrably sanitized status surface, verification fails closed and returns `BLOCKED`.

Structural redaction of already-permitted data is defense in depth. It may recognize secret-like field names, authorization syntax, private-key delimiters and credential-shaped values that appear accidentally in allowed diagnostics; it must never be used as permission to read secret-bearing environment values or adapter output. An adapter that cannot enforce this boundary fails closed and returns `WARNING`, `DEGRADED` or `BLOCKED` according to the affected capability.

## 5. Uniform finding classification

Every preflight, plan, onboarding and doctor finding has one classification. The classification is independent of presentation format.

| Classification | Meaning | Installation effect |
|---|---|---|
| `PASS` | The required predicate is evidenced and no action is needed for that finding | Continue |
| `WARNING` | A non-blocking condition or optional absence deserves user visibility | Continue and preserve the finding |
| `DEGRADED` | The core path can continue, but a declared capability is unavailable, unverified or operating below the intended contract | Continue only if the affected capability is optional or explicitly accepted as degraded |
| `BLOCKED` | Safety, ownership, required evidence, approval, authentication or a required dependency prevents a safe next step | Stop mutation and return a resumable checkpoint |

Classification rules:

- `PASS` is evidence, not an assumption derived from absence of an error.
- `WARNING` never hides a `DEGRADED` or `BLOCKED` child finding.
- A required `DEGRADED` capability promotes the aggregate result to `BLOCKED` until the requirement is changed by an accepted contract; the CLI must not silently downgrade it.
- The aggregate preflight result is the most restrictive classification present after dependency evaluation.
- Existing CLI severities (`info`, `warning`, `error`, `blocker`) remain compatible; `classification` is the normalized lifecycle decision.

## 6. Lifecycle state machine

The environment lifecycle is represented by the private schema. Before approval, `inspected` and `plan-ready` may exist only for the current command; the first persistent checkpoint is written transactionally at the boundary between `approved` and `installing`.

```text
not-started
    ↓ inspect
inspected
    ↓ plan with all required decisions resolved
plan-ready
    ↓ explicit approval of the exact plan
approved
    ↓ write checkpoint, then begin first approved mutation
installing
    ├─ native credentials absent or require user action → authentication-required
    └─ authentication already verified or not required → configuring
authentication-required
    ↓ native OpenCode authentication verified
inspected
    ↓ second authenticated inspection and new plan
plan-ready
    ↓ second explicit approval of the authenticated plan
approved
    ↓ resume approved authenticated operations
installing
    ↓ authenticated configuration and local operations verified
configuring
    ↓ managed configuration and component operations verified
verifying
    ↓ final doctor
healthy | degraded | blocked
```

The states have these meanings:

| State | Entry predicate | Exit predicate |
|---|---|---|
| `not-started` | No valid private environment checkpoint exists | A complete preflight begins |
| `inspected` | Non-mutating preflight completed for the current command; no checkpoint write is implied | The plan inputs and required decisions are complete |
| `plan-ready` | A plan has identity, hashes, dependencies and no unresolved required decision; it may be in memory or an explicit plan file | The user approves that exact plan |
| `approved` | Approval matches the current plan hash; the checkpoint is written immediately before the first side effect | The first operation starts or the plan is found stale |
| `installing` | Approved dependency-ordered operations are executing | Auth gate, configuration phase, blocking failure or interruption |
| `authentication-required` | Native OpenCode authentication must be completed outside portable-opencode; no authenticated remote mutation is yet approved | A sanitized native-auth verification passes, or the user retries/exits |
| `configuring` | Required authentication is verified, or no authentication is required | All planned mutations and their local verification complete |
| `verifying` | The plan's operations completed or produced an explicitly recoverable partial result | Final doctor classifies the environment |
| `healthy` | All predicates required by the accepted manifests pass | A later inspection starts a new assessment cycle |
| `degraded` | The core path works with an explicitly reduced optional capability | A later plan restores or changes that capability |
| `blocked` | A required safety, ownership, dependency, auth or verification predicate fails | A new inspection and valid plan remove the blocker |

The terminal status does not erase the last plan, checkpoint or diagnostic. A new invocation may move `healthy`, `degraded` or `blocked` back to `inspected` after a fresh preflight; this is a new assessment cycle, not an undocumented transition. After native authentication, the authenticated re-inspection uses the same `inspected → plan-ready → approved` states and creates a new plan identity before any authenticated remote mutation.

The state/result fields have distinct meanings:

- `lifecycle` is the current installation state-machine position and governs which transition is legal next;
- `health.classification` is the latest aggregate health classification: `PASS`, `WARNING`, `DEGRADED` or `BLOCKED`;
- `last_outcome` is the outcome of the most recent command or durable operation, using the outcome vocabulary from `schemas/operation-result.schema.json`.

They must not be inferred from one another. For example, an `authentication-required` lifecycle may have `last_outcome=blocked`, while a `healthy` lifecycle has `health.classification=PASS` and `last_outcome=healthy`. `last_outcome=cancelled` or `partial` records what happened; it does not silently move the lifecycle to a healthy state.

## 7. Private checkpoints

The canonical checkpoint is:

```text
%LOCALAPPDATA%\portable-opencode\environment-state.json
```

It is private, schema-validated against `schemas/environment-state.schema.json` version `0.2.0` and excluded from Git. It contains no API keys, tokens, cookies, private-key material, raw auth output, prompts, model responses or secret-bearing command lines. Absolute local paths, component identities, hashes, PIDs, timestamps and sanitized diagnostics are allowed because the file is machine-private state.

Preflight and plan calculation do not create this file. After explicit approval, the CLI writes the first checkpoint atomically before entering `installing` or opening any browser/native-auth handoff. Every later durable side effect advances the checkpoint sequence. A cancelled plan before that boundary leaves no newly created environment checkpoint; a rerun performs fresh inspection.

The checkpoint contract includes:

| Field group | Required content |
|---|---|
| Identity | schema version, installation instance identifier, CLI version and selected immutable release identity |
| Lifecycle | current state, last aggregate classification, last outcome, checkpoint sequence and last transition reason |
| Plan | plan ID, plan hash, observed-state hash, desired-state hash and plan schema version |
| Progress | operation IDs, dependency order, completed operations, operation currently in progress, last safe resume boundary and per-operation verification result |
| Decisions | semantic decisions and conflict resolutions, each with a stable key, normalized value and plan association; never free-form secrets |
| Ownership | managed-resource identities, ownership evidence references, backup references and detached resources |
| Authentication | native auth required/present/verified status only, provider identity if non-secret and supported, and the next user action; no credential data |
| Health | component classifications, doctor revision, diagnostics and the last verified state |
| Recovery | interruption marker, retry count, rollback availability and the exact resume instruction |

The CLI writes the checkpoint atomically at every durable boundary. A crash during a write must leave either the previous valid checkpoint or the next valid checkpoint, never a partially parsed file. The checkpoint is written before an external mutation when the operation has a replay identity, and immediately after the mutation before the next operation begins.

Checkpoint writes must not become a covert log. Keep one current state file; store larger private diagnostics only under the existing private log boundary and apply the redaction contract in Section 12.

## 8. Resume, cancellation, interruption, retry and idempotence

The installation is resumable by default.

- A rerun reads and validates the checkpoint before planning.
- Completed operations are not replayed when their postcondition and identity still match.
- An operation with unknown completion is re-inspected before it is retried; the CLI must not assume failure merely because the process was interrupted.
- A stale plan invalidates approval and returns to `inspected`; the CLI generates a new plan instead of replaying old mutations.
- A user cancellation before any irreversible mutation records `cancelled`, preserves the last safe state, and leaves the plan available for review.
- A user cancellation or process interruption after mutation records `partial` or `cancelled` as appropriate, preserves all completed operation evidence and stops broad mutation.
- Retry is allowed for transient network, browser, package-source, lock and upstream failures only after fresh evidence; retry is not a bypass for ownership or approval blockers.
- A failed operation may resume only from its declared idempotency boundary. If no safe boundary exists, the state is `blocked` and the user receives a recovery action.
- Idempotence means that equivalent observed and desired state yields `no-op`; it does not mean that an external API is called repeatedly without checking its current identity.

Normal recovery is:

```text
inspect
→ reconcile checkpoint and observed state
→ plan remaining or rollback operations
→ approve
→ apply
→ doctor
```

The CLI never deletes a checkpoint to force progress. A corrupt or newer checkpoint is preserved, copied to a private recovery record, and treated as a blocker until a compatible migration or explicit recovery plan exists.

## 9. Dependency-ordered installation

The release manifest and component manifest define the concrete dependency graph. The following order is the product-level minimum:

```text
verified CLI
→ preflight and private-state readiness
→ package/runtime prerequisites required by evidenced components
→ OpenCode runtime and version verification
→ native helper components (RTK, Graphify and other accepted components)
→ authentication-required gate when native auth is absent
→ authenticated non-mutating inspection of OpenCode/provider/remote state
→ second plan and explicit approval for authenticated operations
→ OpenCode configuration and authenticated OpenRouter reconciliation
→ accepted local observability components
→ final configuration checks
→ verifying and doctor
```

Rules:

1. The CLI itself is available before `install`; the bootstrap establishes it.
2. A component cannot run before its declared runtime and package source are verified.
3. OpenCode must be present before its native assets, permissions or auth mechanism are exercised.
4. Native authentication precedes any operation that requires an authenticated OpenRouter or OpenCode provider path.
5. The pre-auth plan cannot mutate authenticated remote state or rely on an observation unavailable before authentication.
6. After native authentication, the CLI runs a second non-mutating inspection, computes a new observed-state hash and creates a new plan identity.
7. The second plan requires a second explicit approval before any authenticated OpenRouter or provider mutation. The first approval never authorizes the second plan.
8. Remote preset reconciliation is one operation per managed slug, with verification after each version change.
9. Observability is installed only when its evidence-gated contract is accepted and its dependencies are available. A pending Phoenix decision is not treated as an installed component.
10. Optional GitHub/Git/SSH operations are outside the required graph unless the user explicitly selects that module.
11. Each node has an install, verify, retry and rollback policy. A missing policy is a design blocker, not permission to guess.

## 10. Question model

The CLI inspects first and asks only when a human decision changes the plan or protects ownership.

### 10.1. No question required

- detected versions, paths, architecture, `PATH`, free space and process state;
- whether a required resource is already managed and matches its identity;
- whether a component can be verified without a choice;
- whether a native credential store exists, without reading it;
- deterministic creation of a missing private checkpoint or a new managed resource after approval.

### 10.2. Question required

- adopting, replacing, detaching or preserving an existing resource whose ownership is ambiguous;
- choosing among supported release or component versions when the plan exposes a real choice;
- resolving a conflicting OpenCode configuration source;
- accepting a declared degraded capability;
- selecting an optional GitHub/Git/SSH module;
- approving a plan that mutates files, installs components or changes remote OpenRouter state;
- approving the authenticated second plan after native authentication and remote-state inspection;
- deciding whether a failed operation should be retried when the retry is not provably safe;
- resolving an unsupported or obsolete private override.

Questions must be typed, stable, and included in the plan hash. The CLI must present the consequence, affected resources, backup/rollback path and classification before asking.

The CLI must not ask the user to paste an API key into `portable-opencode`. It must direct the user to the native OpenCode mechanism.

## 11. Browser-assisted onboarding

Browser assistance is a controlled handoff, not browser automation.

### 11.1. Official-page contract

Each page-opening action is represented by a non-secret descriptor containing:

- purpose;
- official authority and normalized URL;
- release or component version that requires it;
- user action expected;
- whether completion is mandatory or optional;
- opened timestamp and completion status.

Only official domains declared by the release, component manifest or accepted upstream contract may be opened. Query strings and fragments are stripped from persisted URLs. The CLI does not scrape page contents, inspect browser storage, read cookies, capture screenshots or infer completion from browser state.

### 11.2. Required flow

When a user action is needed, the interactive flow is:

```text
explain the exact action and why it is required
→ open the official page automatically
→ wait for the user to finish the external action
→ launch the native OpenCode authentication mechanism
→ wait for native authentication to finish
→ verify only the sanitized native status and required provider capability
→ run a second non-mutating authenticated inspection
→ present a new authenticated plan and request approval again
→ continue, retry, or exit with a checkpoint
```

The CLI may open more than one official page when the plan identifies separate actions, but it must explain each page before opening it. It must not turn an external web page into a credential input surface owned by portable-opencode.

If the user chooses retry, the CLI rechecks the native state and reopens only the page needed for the failed step. After authentication succeeds, the CLI does not reuse the pre-auth approval: it performs the second inspection, produces a new plan hash and asks for approval again. If the user chooses continue with a declared optional capability absent, the result is `DEGRADED`. If the user exits, the checkpoint remains `authentication-required` or the last safe preceding state.

In non-interactive `--json` mode, the CLI emits a structured `authentication-required` action record, never opens a browser or launches a graphical/native-auth interface, does not prompt, persists the checkpoint only after a prior approved mutation boundary and returns `BLOCKED`/exit class `30`. The user completes the official-page and native-auth actions outside this process, then reruns the command; the rerun performs the second inspection and requires the second plan approval. The CLI never waits indefinitely for a human in a non-interactive process.

## 12. Secret boundary and log redaction

The boundary is strict:

```text
user
  → native OpenCode authentication
  → OpenCode's private credential mechanism
  → authenticated provider request
```

`portable-opencode` may orchestrate and verify this boundary. It never receives, stores, copies, prints or transmits an API key. It does not make a provider request by substituting its own credential path.

The following are never persisted in checkpoints, plans, diagnostics, logs or backups:

- API keys, bearer tokens, OAuth codes, refresh tokens and cookies;
- SSH private keys, certificates and passphrases;
- `.env` values and secret-bearing configuration values;
- raw native-auth output, authorization headers and credential-helper output;
- prompts, model responses or private browser data captured during onboarding.

Redaction is applied before serialization and before error aggregation. At minimum it recognizes authorization headers, bearer/basic credentials, JWT-like values, common provider key prefixes, private-key delimiters, credential-like query parameters and cookie headers when those patterns appear in already permitted data; it may also recognize secret-bearing field or variable names and an explicit `sensitive evidence suppressed` marker. It never obtains a secret-bearing value in order to redact it. If a field cannot be safely redacted, the field is omitted and the diagnostic records only that sensitive evidence was suppressed.

Logs are private, bounded, and useful without raw payloads. Verbose mode can add timing, resource identity, operation ID and sanitized exit information; it cannot disable redaction. Secret scanning is a doctor predicate for persisted portable-opencode logs, plans, state and backups.

## 13. Existing configuration, backups and ownership

Installation preserves existing user state by default.

### 13.1. Configuration policy

- A canonical target that is already managed and matches its recorded identity is a no-op.
- A target with proven portable-opencode ownership may be replaced only after a verified backup and an approved plan.
- A matching but unrecorded target is not silently adopted. Adoption is a semantic decision and requires a plan, content comparison and backup.
- A user-owned or unknown target is preserved. A conflict that affects required loading or safety is `BLOCKED`; an unrelated unmanaged file is `WARNING` or `DEGRADED`.
- Root `opencode.json`, dual root configurations, misplaced `.opencode\opencode.json(c)`, active environment overrides and managed Windows sources follow the conflict policy in `DESIGN-008` and `DEC-017`.
- The private override is read-only to normal install operations. Unknown keys or invalid schema block desired-state resolution.
- Native OpenCode authentication data is never backed up, copied, migrated or removed by portable-opencode.

### 13.2. Backup contract

Backups are private, operation-scoped and linked to a resource identity and plan hash. Before replacement, migration, detach or retirement of a portable-owned file, the CLI records the original bytes or a safe equivalent, original identity, ownership evidence, timestamp and restore instructions. A backup that cannot be verified blocks the mutation.

Backups do not authorize deletion. They provide a recoverable preimage for an approved operation. Backup retention and purge are separate explicit lifecycle actions; normal install never purges prior recovery data.

### 13.3. Ownership contract

Ownership is proven from current target identity plus private managed-resource evidence. A version match alone is insufficient. The CLI never kills an unknown process, overwrites an unknown file, adopts a remote preset or removes an optional tool solely because it resembles a managed resource.

## 14. GitHub, Git and SSH optional module

The installation path does not require GitHub access beyond public HTTPS access to the release, and it does not require Git or SSH.

| Capability | Default | Boundary |
|---|---|---|
| Download the release | Required public HTTPS | Git CLI, GitHub account and SSH are unnecessary |
| Git repository initialization | Optional project action | Separate `init-project` plan; no install blocker |
| GitHub account/authentication | Optional | Native tool mechanism; never handled by portable-opencode |
| SSH executable/keys | Optional | Presence may be inspected without reading keys; no key generation or migration |
| GitHub API/repository operations | Optional module | Explicit plan, explicit approval and native credential boundary |

When these tools are absent, `install` records `WARNING` and continues if the selected plan does not depend on them. If the user selects a module that depends on one, its absence is `BLOCKED` for that module only. The base environment remains resumable.

## 15. Interactive and non-interactive behaviour

### 15.1. Interactive mode

Interactive `install`:

1. prints the preflight classification and relevant warnings;
2. presents only semantic decisions and the exact plan consequences;
3. requests approval for the current plan;
4. opens official pages and waits at the native-auth checkpoint;
5. performs a second authenticated inspection, presents the new plan and requests approval again;
6. offers `retry`, `continue-as-degraded` where allowed, or `exit`;
7. writes a checkpoint after every durable boundary;
8. ends with `doctor` and a concise next action.

The CLI never hides a mutation behind a question whose consequence was not part of the displayed plan.

### 15.2. `--json` mode

`--json` emits one structured result envelope per command, using the `DESIGN-009` schema plus the fields required by this design:

```json
{
  "schema_version": "0.1.0",
  "command": "install",
  "outcome": "blocked",
  "exit_class": 30,
  "changed": true,
  "plan": {
    "plan_id": "...",
    "plan_hash": "..."
  },
  "diagnostics": [
    {
      "code": "POC-INSTALL-009",
      "severity": "blocker",
      "summary": "Native authentication is required before authenticated inspection.",
      "evidence": ["The sanitized native status reports no verified provider session."],
      "impact": "The authenticated plan and remote configuration cannot be calculated safely.",
      "remediation": "Complete the official-page and native OpenCode actions outside --json mode, then rerun install for a second inspection and approval.",
      "resource_id": null
    }
  ],
  "state": {
    "lifecycle": "authentication-required",
    "classification": "BLOCKED",
    "next_action": "complete-native-authentication-outside-json-mode",
    "official_url": "<normalized-official-url>",
    "resume_with": "portable-opencode install --json --yes"
  },
  "summary": "Pre-authentication operations completed; authenticated inspection and a second approval are required."
}
```

This example validates against `schemas/operation-result.schema.json`; the `state` object carries design-specific fields because that schema permits additional state properties. The example is structural and contains no credential field. In JSON mode:

- the CLI never writes a human prompt to stdout or stderr;
- `--yes` is still required for mutation;
- missing approval, unresolved semantic decisions, authentication and ownership conflicts are serialized as actions and return a stable non-success exit class;
- the CLI never opens a browser or launches a graphical/native-auth interface;
- a rerun consumes the checkpoint and either resumes, creates a new plan or reports the same blocker with updated evidence.

`--json` changes presentation and prompt handling, not the plan, ownership, dependency, redaction or verification rules.

## 16. Plan identity and obsolete-plan detection

Every plan has a stable identity and a content hash. The minimum envelope is:

```text
plan_schema_version
plan_id
plan_hash
plan_phase
supersedes_plan_id
authentication_epoch
created_at
release_identity
cli_identity
platform_identity
observed_state_hash
desired_state_hash
checkpoint_sequence
required_decisions
operations[]
```

The hash covers normalized, secret-free plan content, including operation order, resource identities, current and desired identities, dependencies, user decisions, release identity and verification predicates. It excludes volatile presentation text.

A plan is obsolete when any relevant input changes, including:

- selected release, CLI or supported component identity;
- Windows or architecture evidence;
- target content, ownership, lock or process state;
- native OpenCode provenance or auth status;
- remote OpenRouter state;
- private override content or schema version;
- checkpoint sequence or completed-operation evidence;
- user decision values;
- required official page or package-source identity.

`apply` must re-inspect these inputs and compare hashes before mutation. A mismatch returns `POC-CORE-004`/`POC-INSTALL-010`, preserves the old plan, invalidates approval and requires a new plan. `--yes` authorizes only the matching current plan hash.

Authentication creates a mandatory plan boundary. The pre-auth plan has `plan_phase=pre-authentication` and cannot authorize authenticated remote changes. After native authentication, the second inspection increments `authentication_epoch`, produces a new `observed_state_hash`, and creates a new `plan_id`/`plan_hash` with `plan_phase=authenticated` and `supersedes_plan_id` pointing to the pre-auth plan. The second plan requires a second explicit approval, even when the first plan was approved with `--yes`.

## 17. Updates, rollback, uninstallation and recovery

### 17.1. Update

An update is the same lifecycle with a new release identity:

```text
inspect current release and environment
→ compare supported versus installed versions
→ plan migrations, backups and dependency changes
→ approve
→ apply in dependency order
→ verify
→ doctor
```

The update never changes the release or component version silently. It preserves the previous verified CLI and managed-resource backup until the new state passes doctor. A versioned migration is required for a private state schema change; an unknown schema version blocks the update.

### 17.2. Rollback

Rollback is an explicit plan, not an automatic reaction to every error.

- CLI rollback re-establishes the previous verified release asset through the bootstrap/package mechanism.
- Managed file rollback restores only a verified preimage whose ownership is still proven.
- Remote OpenRouter rollback selects a preserved managed version through the accepted remote policy; it does not delete history.
- Native credentials, user-owned files, unknown files, project repositories and external accounts are never rolled back by portable-opencode.
- A rollback itself requires approval and ends in doctor verification.

### 17.3. Uninstallation and detach

The initial install contract defines the safety rules for a later `uninstall`/detach operation; the command is not added to the initial `DESIGN-009` surface until the implementation and ownership tests exist.

When introduced, it must:

- inspect first and produce an explicit retirement plan;
- remove only portable-owned resources whose ownership is still proven;
- preserve user-owned and unknown files, native auth, projects, Git data, SSH material and backups unless a separate explicit purge contract exists;
- detach ownership without deleting a target when removal is unsafe;
- never delete remote presets automatically;
- record the result and run doctor on the remaining environment.

### 17.4. Recovery

Recovery uses the checkpoint, private backups, `inspect`, an explicit plan, `apply` and `doctor`. If the CLI cannot start, `bootstrap.ps1` may re-establish the CLI only. It must not repair application state directly. A locked file, unknown process, corrupt checkpoint or unverifiable backup produces a narrow remediation rather than broad cleanup.

## 18. Diagnostics and exit classes

The existing `DESIGN-009` diagnostic and exit contracts remain authoritative. This design adds the following stable diagnostic meanings for installation and onboarding:

| Code | Meaning |
|---|---|
| `POC-INSTALL-001` | Release or architecture has no supported asset |
| `POC-INSTALL-002` | Bootstrap or PowerShell capability is unsupported or unverifiable |
| `POC-INSTALL-003` | DNS, TLS, HTTPS or proxy access is unavailable for a required source |
| `POC-INSTALL-004` | An official package source is unavailable or returned unverifiable metadata |
| `POC-INSTALL-005` | Required storage, ACL or private-target access is unavailable |
| `POC-INSTALL-006` | `PATH` or an existing executable creates an unresolved CLI/runtime collision |
| `POC-INSTALL-007` | Relevant process or locked file prevents a safe owned operation |
| `POC-INSTALL-008` | Existing configuration or ownership requires a semantic decision |
| `POC-INSTALL-009` | Native authentication is required or its sanitized verification failed |
| `POC-INSTALL-010` | The checkpoint or supplied plan is obsolete or cannot be resumed safely |
| `POC-INSTALL-011` | An official browser handoff could not be opened or completed |
| `POC-INSTALL-012` | A private-state or log redaction boundary was not verifiable |
| `POC-INSTALL-013` | An installation operation has an unknown completion state |
| `POC-INSTALL-014` | The release has no independently verifiable origin trust anchor |
| `POC-INSTALL-015` | The release signature is invalid, revoked or does not match the selected asset |
| `POC-INSTALL-016` | The bootstrap bytes or their complete pre-execution trust chain cannot be independently authenticated |

Exit classes remain coarse and stable:

| Exit class | Use in this design |
|---:|---|
| `0` | `no-op`, `applied`, `healthy` or an explicitly completed optional flow |
| `2` | Invalid arguments, malformed plan or invalid supplied document |
| `10` | A valid plan exists or supported updates are available without mutation |
| `20` | `degraded` result where the core workflow remains usable |
| `30` | Approval, semantic decision, authentication, ownership, checkpoint or required-precondition blocker; includes non-interactive `authentication-required` |
| `40` | Partial mutation or interrupted operation after a mutation began |
| `50` | External package, network, upstream API, process or filesystem failure without a safe degraded continuation |
| `60` | Internal invariant, schema or checkpoint atomicity failure |

Every human and JSON result includes the lifecycle state, normalized classification, outcome and summary. `diagnostics` is always present as an array: it may be empty when no finding exists, including for a healthy result. Each present finding contains the schema-required code, severity, summary, evidence, impact and remediation, with `resource_id` when applicable. The CLI never invents a success diagnostic merely to make the array non-empty; resume instructions appear when applicable.

## 19. Final `doctor` and health meaning

`install` ends by invoking `doctor`; `doctor` never repairs. It verifies:

- lifecycle/checkpoint schema and plan completion;
- CLI and release identity;
- required component versions and executable paths;
- OpenCode config validity, canonical paths, provenance and required assets;
- native auth presence and provider capability through sanitized native status only;
- managed OpenRouter state and required preset verification when the authenticated gate is accepted;
- RTK and Graphify integration, freshness and quality predicates;
- accepted observability process, loopback, storage, redaction and ingestion predicates;
- ownership, backup and lock evidence;
- private-boundary and persisted-secret scans;
- optional Git/GitHub/SSH status without making it a base readiness gate.

The result means:

- `healthy`: every capability marked required for the selected release and manifest is verified, no blocker exists, and no accepted degradation remains.
- `degraded`: the required coding path is usable, but one or more optional or explicitly deferred capabilities are unavailable; the result names each omitted capability and does not present full readiness.
- `blocked`: a required capability, safety predicate, ownership decision, native-auth action, plan freshness check or verification gate is unresolved. The checkpoint remains resumable.

An evidence-gated component cannot be called `healthy` merely because installation succeeded. The component's evidence and accepted criticality must exist first.

## 20. Test strategy

The implementation must preserve traceability to this design without making tests part of the product distribution.

### 20.1. Unit tests

- state-machine transition legality, terminal-state re-entry and invalid transitions;
- checkpoint schema, monotonic sequence and atomic-replacement recovery;
- plan normalization, identity/hash calculation and obsolete-plan detection;
- pre-auth versus authenticated plan phases, authentication epochs and mandatory second approval;
- dependency ordering and operation idempotency;
- uniform `PASS`/`WARNING`/`DEGRADED`/`BLOCKED` aggregation;
- question gating and decision persistence;
- diagnostic redaction and exit-class mapping;
- `last_outcome` persistence and the distinction between lifecycle, health classification and command outcome.

### 20.2. Simulated adapters

Adapters must be replaceable by deterministic simulators for Windows evidence, PowerShell, DNS/TLS/proxy, package sources, filesystem/ACLs, process locks, OpenCode native auth, browser opening, OpenRouter state, RTK, Graphify and observability. Simulators must expose events before and after side effects so interruption cases can be tested without credentials or live remote mutation.

### 20.3. Lifecycle and recovery tests

- interrupt before approval, after approval, before each operation, after each operation and during checkpoint replacement;
- resume without repeating completed work;
- retry transient failures and refuse unsafe retries;
- detect unknown completion and require re-inspection;
- reject authenticated remote mutations when the second inspection or second approval is absent;
- preserve partial results and restore from a verified backup;
- reject corrupt, newer and obsolete checkpoints.
- validate `cancelled` before any mutation, `cancelled` after a mutation, `partial` after interruption, blocked authentication and safe re-entry after resume.

### 20.4. Pre-existing configuration tests

Cover clean state, matching managed state, unmanaged matching state, drift, dual OpenCode roots, misplaced `.opencode` config, active environment overrides, locked files, unknown processes, invalid private overrides and user-owned files. Every case must verify preservation or explicit blocking.

### 20.5. Network and secret-protection tests

Cover DNS failure, TLS failure, proxy refusal, package metadata drift, same-Release checksum mismatch, missing independent trust anchor, invalid/revoked release signature, timeout, partial remote reconciliation and browser unavailability. Prove that `--json` opens no browser or native graphical interface. Use sentinel secret values only inside isolated test inputs; prove that they do not appear in plans, checkpoints, diagnostics, logs, backups, process arguments, inherited child environments, stdout or stderr. Test that native-auth adapters return only sanitized status or `sensitive evidence suppressed`, and that a missing sanitized surface blocks verification.

### 20.6. Bootstrap trust and transaction tests

- reject tampered bootstrap bytes before PowerShell execution, including direct download-and-pipe equivalents;
- accept only an independently anchored bootstrap trust chain and then verify the canonical manifest signature and asset digests;
- prove private staging, pre-activation verification, immutable version isolation, atomic activation, no-op repetition, ownership-safe collision handling and preservation of the previous verified CLI;
- interrupt during staging, verification, activation and cleanup, and prove that recovery leaves either the previous CLI or the fully verified new CLI;
- prove cleanup is limited to bootstrap-owned temporaries and that CLI recovery cannot modify OpenCode configuration or environment state.

### 20.7. Windows clean-machine E2E

After the evidence gates and implementation exist, `E2E-001` must run on a clean supported native Windows machine:

```text
independently authenticated bootstrap bytes
→ public release
→ one PowerShell bootstrap command
→ inspect
→ plan
→ install
→ browser/native-auth handoff
→ doctor healthy or explicit degraded/blocked result
→ rerun without corruption
→ interruption and resume
→ authenticated second inspection and second approval
→ optional Git/GitHub/SSH absence remains non-blocking
```

The E2E must not use WSL, repository credentials, an SSH key, an API key visible to the test harness or a hand-written machine state file.

## 21. Evidence-gated dependencies and implementation gate

| Dependency | Current status | Constraint on this design |
|---|---|---|
| `DEC-009` | Proposed; implementation language remains open | Do not select CLI runtime, native launcher or package primitives by preference |
| `DEC-012` | Deferred; exact packaging remains open | Public GitHub Releases are the accepted initial channel; bootstrap-byte trust, asset/package/signature, independent trust-anchor, key-rotation, revocation and transactional activation details remain evidence-gated |
| OpenCode | `SPIKE-001` remains version-scoped `INCONCLUSIVE` | Do not claim a universal auth store, native auth command, path, precedence or version contract until verified |
| Authenticated `SPIKE-002` gate | Pending private authentication | Do not create the concrete preset manifest or claim authenticated role/fallback/tool/privacy/usage behaviour |
| `SPIKE-003` and Phoenix | `SPIKE-003` is defined, blocked and not started; `DEC-010` remains proposed | Do not install, require or call Phoenix healthy before the gate accepts it |
| `SPIKE-004` and Graphify/RTK | Partial; only version-scoped promoted evidence is valid | Preserve the partial/degraded boundaries for determinism, hooks, recovery and OpenCode integration |

Implementation may begin only after the owner accepts this design and the implementation plan, and after each external mechanism is resolved by the evidence owner named above. This design does not authorize starting `SPIKE-003`, using credentials or resolving an evidence-gated decision.

## 22. Contract summary

The first release must provide one safe path with six properties:

1. the bootstrap is independently authenticated before execution and then establishes only a verifiable CLI;
2. the authenticated bootstrap verifies release origin with an independent trust anchor; a same-Release checksum is not enough;
3. preflight is strictly read-only, and checkpoint persistence begins only after approval at the first side-effect boundary;
4. the CLI inspects before asking, plans before mutating, re-inspects after authentication, requires a second authenticated plan approval and resumes without replaying verified work;
5. native OpenCode owns authentication, child processes receive no secret-bearing environment by default and portable-opencode never handles secret values;
6. doctor reports `healthy`, `degraded` or `blocked` from evidence, while `last_outcome` records the latest operation outcome without replacing the lifecycle or health classification.

The TUI and graphical installer remain deferred. GitHub, Git and SSH remain optional. The next required action is to create the implementation plan; implementation of mechanisms dependent on unresolved evidence-gated decisions remains prohibited.
