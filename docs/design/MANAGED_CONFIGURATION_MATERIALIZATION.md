---
type: Design
id: DESIGN-007
title: Managed Configuration Materialization
description: Ownership, materialization, versioning, bootstrap and drift contracts for reproducible managed resources.
status: active
decision: DEC-021
---

# Managed configuration materialization

## 1. Objective

Turn versioned intent into a reproducible Windows environment without treating the whole machine as disposable, exposing the canonical repository to application rewrites or deleting resources merely because they are absent from desired state.

The design applies to configuration files, installed components, generated project assets and externally managed state coordinated by `portable-opencode`. It does not make the project a general dotfiles or desktop-personalization manager.

## 2. Resource contract

Every managed resource declares:

```text
resource_id
canonical_source
managed_target
owner
materialization_mode
mutability
content_identity
backup_policy
drift_policy
verification
version_policy when applicable
```

The contract must be inspectable before mutation and serializable in the managed-resource inventory.

## 3. Materialization modes

### `rendered`

The target is generated from canonical templates, schemas and explicit inputs. The generated target is not edited manually. Drift is resolved by changing the source or input and rendering again.

### `copied`

The target is a byte-equivalent native file copied from a canonical source. This is preferred when the upstream application may rewrite its target or when a direct link would expose the repository to mutation.

### `linked`

The target links to the canonical source. This is exceptional, not a convenience default. It requires evidence that:

- Windows link creation and resolution are reliable for the supported environment;
- the consumer treats the target as effectively immutable;
- runtime changes cannot silently modify the canonical repository;
- backup, drift and detach behaviour are understood.

### `queried`

The resource remains owned by an upstream service or tool. `portable-opencode` inspects and verifies it but does not claim filesystem ownership. OpenRouter presets are reconciled through their own accepted policy rather than represented as local files.

### `private`

The resource contains credentials, local runtime data, installation metadata, traces, databases, caches or overrides that must remain outside Git.

## 4. Default policy

```text
versioned intent
→ render or copy to the native target
→ verify content and upstream loading
→ record ownership and outcome
```

Use `rendered` when project- or machine-specific inputs are required. Use `copied` when the canonical file is already complete. Use `linked` only after an explicit contract and Windows-native validation.

No fixed symbolic path to the repository is required. The installation location is discovered from private installation state or the running executable.

## 5. Ownership and adoption

Ownership states are conceptually:

```text
unmanaged
managed-created
managed-adopted
managed-modified
retirement-planned
detached
```

Creating a resource records ownership. Adopting a pre-existing resource requires a reviewed plan, content comparison and backup. Detecting a matching file is not sufficient to claim ownership silently.

The CLI may replace, detach or remove only resources whose ownership is proven by recorded state and current target evidence. Ambiguous ownership blocks mutation.

## 6. Drift and retirement

Drift classes include:

```text
missing target
content drift
target-type drift
source drift
version drift
ownership ambiguity
external rewrite
```

A second equivalent run is a no-op. Explained drift produces a plan. Unexplained drift blocks automatic application.

Removing a resource from desired state creates a retirement plan. It does not authorize cleanup of arbitrary packages or files. User-owned and unknown resources are preserved.

## 7. Supported-component version manifest

A versioned manifest is required during contract definition, before implementation and packaging are fixed. It records, where applicable:

```text
component identity
supported version or range
installation source and mechanism
platform constraints
compatibility state
upgrade policy
spike or test that supplies evidence
```

Installed versions are observed state, not canonical intent. The manifest enables reproducible detection, installation, diagnosis and migration without pretending to reproduce every transitive dependency as Nix would.

## 8. Bootstrap boundary

The canonical clean-machine path is:

```text
git clone
→ PowerShell bootstrap
→ portable-opencode inspect
→ portable-opencode plan
→ portable-opencode apply
→ portable-opencode doctor
```

The bootstrap script is deliberately small. It may verify prerequisites and establish or invoke the pinned CLI. It must not duplicate desired-state resolution, planning, mutation, backup, verification or state recording.

## 9. Generated artefacts

Generated or autogenerated files are changed only through their canonical source, generator or inputs. Agents must not patch them manually. Verification should prove that regeneration is deterministic enough for the resource's contract.

## 10. Defect workflow

Before fixing a defect, reproduce it through the closest feasible user-facing or end-to-end path. If exact reproduction is impossible, record the evidence, assumptions and substitute verification before mutation.

Unrelated findings do not become silent scope. They are recorded or handled separately unless they block the correctness or verification of the current outcome.

## 11. Session and context visibility

SPIKE-001 must validate parallel OpenCode sessions on Windows Terminal before a terminal multiplexer or harness manager is considered. The evidence should cover identification, independent execution, diff review, closure and recovery.

Where OpenCode and providers expose reliable values, observability should correlate:

```text
input tokens accumulated
context limit
context utilization
compaction start and completion
tokens before and after compaction
compaction count
project, session and agent
```

Unavailable values remain explicitly unavailable. The system must not fabricate a context percentage from incomplete metadata.

## 12. Validation

Validate through schemas, fixtures and Windows-native spikes:

- deterministic resource identities and plans;
- copied and rendered file convergence;
- link creation, rewrite and detach behaviour;
- adoption and backup of pre-existing targets;
- drift classification and no-op reruns;
- refusal to mutate unknown resources;
- retirement without broad cleanup;
- supported-version comparison and upgrade planning;
- minimal bootstrap behaviour;
- generated-file regeneration;
- parallel-session and context-metadata availability.

## 13. Reconsideration triggers

Change the default modes only when repeated Windows evidence shows that links are safer or materially simpler than copies, an upstream tool gains a reliable declarative configuration mechanism, or a second real personal configuration requires a different ownership model.
