---
type: Spike Result
title: Codex Development Orchestration Result
description: Sanitized Windows-native evidence for repository-local Codex role routing, bounded delegation, receipts and independent review.
status: active
sources:
  - resource: ../SPIKE-000_CODEX_ORCHESTRATION.md
    title: SPIKE-000 execution brief
  - resource: ../../design/CODEX_DEVELOPMENT_ORCHESTRATION.md
    title: Codex Development Orchestration
  - resource: ../../../.codex/config.toml
    title: Repository-local Codex configuration
---

# SPIKE-000 result

## Outcome

**INCONCLUSIVE / partially supported.** The bounded workflow is usable as a prompt- and policy-mediated experiment, but this run did not demonstrate structural discovery or named-role selection in the installed Codex CLI. The repository must not claim that a named specialist was structurally invoked merely because a session was instructed to act as that role.

This result is not a PASS gate for treating the hierarchy as structurally reliable. It is not a product-runtime failure, and no custom dispatcher or hook workaround was added.

## Tested environment

- Codex CLI: `codex-cli 0.153.4`.
- Windows: `Microsoft Windows NT 10.0.26200.0`.
- Host PowerShell: `5.1.26100.8457`.
- Nested native PowerShell used by Codex: `PowerShell 7.6.5`.
- Branch: `spike/000-codex-orchestration`, based on clean `main`.

No credentials, private traces, unrelated user files or real OpenCode/OpenRouter/Graphify/RTK/Phoenix configuration were read or changed.

## Evidence table

| Contract | Result | Evidence | Limitation / impact |
|---|---|---|---|
| repo-local config discovered | inconclusive | `.codex/config.toml` and all eight referenced role files were present and readable; `max_depth = 1` and the named roles were visible as repository files. | File presence and model-visible reading do not prove that the installed runtime loads the role registry. |
| master role selected | inconclusive | A fresh generic Codex session was instructed to act as `development-orchestrator`, read the required sources and returned a bounded Work Package. | No runtime role identity or explicit selector was observable; this was semantic/prompt invocation. |
| context-manager selected | inconclusive | The Work Package named `context-manager` as an advisor and the master session grounded itself in repository context. | No independent child identity or parent-mediated advisor invocation was observable. |
| prompt-engineer selected when useful | inconclusive | The Work Package named `prompt-engineer` only as an advisor for the structured execution brief. | No independent child identity or actual advisor handoff was observable; ceremonial invocation was avoided. |
| implementation role selected | inconclusive | The worker followed PowerShell-specific behavior: `ToUpperInvariant()`, literal paths, scratch-boundary checks, no descendant spawning, and a schema-shaped Receipt. | The role name came from the prompt; the CLI exposed no structural `--agent`/`--role` selection. |
| depth-1 behavior | inconclusive | Configuration and Work Package both declared depth `1`; the worker Receipt stated that any additional specialty must return to `development-orchestrator`. | No runtime child-spawn API was exercised, so enforcement is repository policy/prompt behavior, not demonstrated runtime enforcement. |
| Work Package valid | pass | The orchestrator session returned a bounded package with goal, sources, scope, invariants, verification, stop conditions, deliverables, parent, depth and Receipt schema. `Test-Json` passed against `schemas/codex-work-package.schema.json`. | The CLI's `--output-schema` rejected the repository schema because its response-format subset disallows `uniqueItems`; validation was therefore performed locally with PowerShell. |
| Receipt valid | pass | The retry Receipt declared `partial`, the actual changed file, command outcomes, verification, deviations, blockers, residual risks and parent decisions. `Test-Json` passed against `schemas/codex-task-receipt.schema.json`. | The first Receipt was `failed` because the disposable verifier itself had a newline defect; the parent corrected only that fixture and retained the failure as evidence. |
| fresh reviewer | pass for behavioral gate | An independent reviewer rejected a deliberately broken output, then a fresh reviewer inspected the restored output and returned `APPROVE`; an independent test-engineer returned `PASS`. | Reviewer identity was behaviorally distinguishable by separate fresh sessions, but repository role-file loading was not structurally observable. |
| negative routing control | pass for failure behavior | Requesting absent `unavailable-specialist` returned `BLOCK` with `silent_substitution: false`. `codex exec --agent unavailable-specialist` failed with `unexpected argument '--agent'`; help exposed no named-role selector. | This confirms safe observable failure, not successful custom-role routing. |

## Fixture and verification summary

The disposable fixture contained a binding context, lowercase input, expected uppercase output, a protected sentinel and a PowerShell verifier. The worker initially stopped on a real sentinel-newline mismatch. The parent corrected only the scratch verifier, retried, and obtained `FIXTURE_VERIFY_OK`. The parent then independently confirmed:

- `output.txt` equals `input.txt.ToUpperInvariant()` and `expected.txt` byte-for-text;
- the protected sentinel hash remained unchanged;
- no repository changes occurred outside `.codex/spike-000-scratch/`;
- the negative-control reviewer rejected `CODEX ORCHESTRATION DEFECT` before the output was restored.

All scratch files, receipts and raw probe outputs are disposable and are removed before completion. This result retains only sanitized summaries.

## Structural versus policy guarantees

Structurally evidenced:

- repository-local role/config files exist;
- `max_depth = 1` is declared in repository configuration and Work Package data;
- Work Package and Receipt schemas parse and validate the tested instances;
- failed routing is observable and not silently substituted;
- fresh behavioral review can reject and approve fixture states.

Prompt/policy enforced or behaviorally observed:

- master grounding and bounded Work Package creation;
- PowerShell-specific worker discipline;
- direct parent reporting and no descendant delegation in the tested worker;
- independent test/review behavior.

Not currently demonstrated by this Codex build:

- runtime discovery/loading of `.codex/agents/*.toml` as named roles;
- explicit named-role selection for master, advisors, worker or reviewer;
- runtime-enforced depth-1 child delegation;
- structural child identity in the parent round trip.

## Decision impact

Keep the repository-local roles, schemas and protocol. Before relying on this hierarchy for later runtime spikes, treat role routing and depth enforcement as semantic/prompt-mediated and preserve the explicit limitation in task receipts and reviews. Do not mark the orchestration contract structurally validated, and do not build a replacement dispatcher without a later accepted design decision.

The next bounded repository step is controlled metadata migration followed by the canonical documentation validator; later runtime spikes may proceed only with this routing limitation understood and recorded.

## Repository documentation verification

The canonical `scripts/verify-docs.ps1` run was repeated with the pinned dependencies in a temporary `.codex` directory and then that directory was removed. It exited non-zero with **45 errors**, all in pre-existing tracked configuration/context metadata: three JSONC `$schema` additional-property mismatches and inherited frontmatter/source-shape errors in `VISION.md`, `AGENT_AND_MODEL_ROLES.md`, `GRAPHIFY_OUTPUT_POLICY.md`, `CONFIGURATION_TUI.md` and `CONFIGURATION_SURFACE_RESEARCH.md`. The SPIKE-000 state status itself was corrected before this second run. No scratch or validator dependency files remain.

## Discard boundary

The disposable fixture was created only under `.codex/spike-000-scratch/` and was removed after evidence capture. No product configuration or external state was mutated.
