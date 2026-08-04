---
type: Feature Definition
id: FEAT-001
title: Interactive Configuration TUI
description: Parked Ratatui interface concept to reconsider after the CLI is effective and stable.
status: deferred
created: 2026-08-04
modified: 2026-08-05
decision: DEC-013
sources:
  - ../context/PROJECT.md
  - ../context/VISION.md
  - ../context/ARCHITECTURE.md
  - ../context/DECISIONS.md
  - ../context/ROADMAP.md
verified:
  - by: repository-owner
    status: pending
---

# Interactive Configuration TUI

## Status

This feature is **parked**.

`portable-opencode` will first deliver a simple, effective and complete CLI for:

- inspection;
- planning;
- installation;
- diagnosis;
- project initialization;
- component lifecycle;
- status and repair.

Ratatui must not influence the initial implementation language, package layout or domain model.

## Why it is deferred

The TUI may eventually improve review of complex plans and diagnostics, but its value cannot be measured before the CLI workflows exist.

Building it now would create several risks:

- designing screens around unstable operations;
- introducing Rust primarily for presentation;
- expanding the application model for hypothetical UI needs;
- duplicating functionality already available in OpenCode and Phoenix;
- delaying the first complete personal workflow.

The current product needs a working control path, not another interface.

## Re-evaluation gate

Reconsider the feature only when:

1. `install`, `doctor`, `status`, `plan`, `apply` and `init-project` work end to end;
2. the CLI already emits structured plans and diagnostics;
3. repeated real use exposes a specific interaction problem;
4. the expected improvement can be stated and tested;
5. the TUI can remain a thin adapter over existing operations.

## Preserved constraints

If the feature is revived:

- the CLI remains independently complete;
- the TUI owns no filesystem or process mutation;
- CLI and TUI use the same operations and state;
- it does not replace OpenCode, Phoenix or Graphify interfaces;
- it remains optional;
- non-TTY execution never requires it.

## Deferred technology

Ratatui remains the preferred technology to evaluate, not an accepted dependency.

`SPIKE-005` is removed from the active roadmap. A future spike should be created only after the re-evaluation gate is met.

## Related decision

See [DEC-013](../context/DECISIONS.md#dec-013--defer-the-configuration-tui-until-the-cli-is-effective).
