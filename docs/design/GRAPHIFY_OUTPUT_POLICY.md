---
type: Design
id: DESIGN-003
title: Graphify Output Ownership Policy
description: Versioning, privacy and regeneration policy for Graphify project artefacts.
status: active
created: 2026-08-05
modified: 2026-08-05
sources:
  - ../context/PROJECT.md
  - ../context/ARCHITECTURE.md
  - ../context/DECISIONS.md
  - ../research/CONFIGURATION_SURFACE_RESEARCH.md
  - CONFIGURATION_MATRIX.md
verified:
  - by: repository-owner
    status: pending
---

# Graphify output ownership policy

## 1. Objective

Keep enough Graphify output in Git to preserve structural continuity across machines and sessions without versioning large, private or easily regenerated artefacts.

The policy is personal-first. Team merge convenience is not the reason for versioning; reproducible access to the graph after clone or machine replacement is.

## 2. Upstream output

Graphify's standard output may include:

```text
graphify-out/
├── graph.json
├── GRAPH_REPORT.md
├── graph.html
├── manifest.json
├── cost.json
└── cache/
```

Additional exports such as wiki pages, call-flow HTML, SVG, GraphML or Cypher appear only when requested.

## 3. Versioned allowlist

### `graphify-out/graph.json`

**Versioned: yes.**

Reason:

- canonical machine-readable graph;
- enables `query`, `path`, `explain` and possible local MCP use without rebuilding;
- preserves node, edge, relationship, source and community data;
- provides the structural memory needed by later sessions.

Requirements:

- generated only from the approved source scope;
- updated through the explicit graph workflow;
- no conflict markers or partial output;
- graph quality gate passes before commit;
- Graphify version and freshness are recorded in project state.

### `graphify-out/GRAPH_REPORT.md`

**Versioned: yes.**

Reason:

- compact human and agent entry point;
- exposes god nodes, communities, surprising relations and gaps;
- useful without opening the full JSON or HTML;
- provides reviewable evidence of graph quality.

The report is generated evidence, not curated project architecture. Durable conclusions must still be distilled into canonical context.

### `graphify-out/manifest.json`

**Versioned: yes when produced by the supported Graphify version.**

Reason:

- current Graphify documentation describes it as portable;
- relative paths allow re-anchoring after clone;
- avoids unnecessary full rebuilds on another machine;
- supports incremental freshness.

`SPIKE-004` must verify the exact schema and absence of absolute or private paths before enabling this rule.

## 4. Ignored private or regenerable output

### `graphify-out/graph.html`

**Versioned: no by default.**

Reason:

- derived from `graph.json`;
- can become very large or be omitted for graphs above visualization limits;
- creates repository churn without improving machine continuity;
- can be regenerated locally when visual exploration is needed.

### `graphify-out/cache/`

**Versioned: no.**

Reason:

- performance cache rather than knowledge source;
- potentially large and high-churn;
- graph and portable manifest provide sufficient continuity;
- local rebuilding is acceptable.

### `graphify-out/cost.json`

**Versioned: no.**

Reason:

- local operational and potentially sensitive data;
- irrelevant to project knowledge;
- may reveal provider or usage information.

### Query logs

**Versioned: no.**

Graphify query logs belong to private user cache. Full subgraph-response logging remains disabled by default.

### Optional exports

The following are ignored unless explicitly promoted for a concrete purpose:

```text
graphify-out/wiki/
graphify-out/callflow*.html
graphify-out/*.svg
graphify-out/*.graphml
graphify-out/cypher.txt
```

Promotion requires a durable use that is not served by `graph.json`, `GRAPH_REPORT.md` or curated context.

## 5. Git ignore strategy

The project `.gitignore` should use an allowlist equivalent to:

```gitignore
graphify-out/*
!graphify-out/graph.json
!graphify-out/GRAPH_REPORT.md
!graphify-out/manifest.json
```

If a supported Graphify version uses additional required parent directories or different output names, `SPIKE-004` updates this policy deliberately.

`.graphifyignore` must exclude `graphify-out/` from source extraction so generated graph artefacts never feed back into the graph.

## 6. Update and commit policy

Graph output is committed when:

- source changes materially affect structure;
- explicit graph update succeeds;
- graph quality checks pass;
- node/edge shrink is explained rather than bypassed blindly;
- the report and manifest correspond to the same graph;
- the diff is not caused only by nondeterministic ordering or an unsupported Graphify version.

Graph output does not need a commit after every source edit. Project state may remain `dirty` until the next meaningful synchronization boundary.

## 7. Clone and recovery behaviour

After cloning on another supported Windows machine:

1. verify `graph.json`, report and manifest parse;
2. verify recorded Graphify version compatibility;
3. query the existing graph immediately where possible;
4. run an explicit incremental update;
5. rebuild fully only when manifest/version incompatibility or quality checks require it.

## 8. Readiness and degradation

- missing `graph.json` blocks project `ready` in the canonical workflow;
- missing or invalid report degrades graph review and blocks initial readiness, but may be regenerated;
- missing manifest allows a rebuild and is therefore degraded rather than blocked after initial setup;
- ignored HTML or cache never affects readiness;
- stale graph marks project state `dirty`;
- corrupt or unexplained severely shrunken graph marks project state `blocked` until repaired.

## 9. SPIKE-004 validation

Validate on Windows:

- exact standard output set and paths;
- deterministic `graph.json` and report regeneration;
- manifest portability and private-path absence;
- clone plus incremental update behaviour;
- repository size and diff churn;
- graph HTML regeneration and large-graph limits;
- hook merge-driver side effects even though the personal MVP is single-user;
- exclusion of `graphify-out/` from source scanning;
- no secrets in versioned output.

## 10. Reconsideration triggers

Change the allowlist only when:

- Graphify changes its canonical output schema;
- an optional export becomes a repeated personal workflow dependency;
- `graph.json` becomes too large for practical Git use;
- manifest portability fails on Windows;
- a remote graph store replaces repository versioning through an explicit decision.
