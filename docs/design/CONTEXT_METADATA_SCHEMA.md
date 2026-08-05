---
type: Design
id: DESIGN-004
title: Minimal Context Metadata Schema
description: Repository-owned frontmatter policy for curated knowledge documents.
status: active
sources:
  - resource: https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md
    title: Open Knowledge Format v0.2 specification
  - resource: ../context/CONVENTIONS.md
    title: Repository conventions
---

# Minimal context metadata schema

## 1. Objective

Keep curated Markdown easy to read, route and validate without duplicating information already provided by Git, document bodies or machine-readable project state.

The policy is **OKF-compatible where useful, repository-owned where stricter**. It does not claim full support for OKF trust, attestation or computation families.

## 2. Design principles

- frontmatter exists for fields an agent or validator needs before reading the body;
- Git owns authorship and modification history;
- document bodies own rationale and evidence;
- `.portable-opencode/state.json` owns current operational verification;
- fields that remain permanently `pending` or require manual synchronization are removed;
- reserved navigation/history files remain structurally simple;
- optional metadata appears only when it changes how the document is consumed.

## 3. Required frontmatter

Every curated Markdown document except reserved `index.md` and `log.md` requires:

```yaml
type: <descriptive document type>
title: <human-readable title>
description: <one-line responsibility>
status: <lifecycle status>
```

### `type`

Identifies the document class for routing and filtering. It is the only field required by base OKF concept documents.

Examples:

```text
Project Context
Architecture
Decision Log
Research Note
Design
Feature Definition
Operations
Conventions
Roadmap
```

### `title`

Provides a stable display title independent of the first Markdown heading.

### `description`

States the document's responsibility in one line. It should explain what question the document answers, not summarize every section.

### `status`

Represents document lifecycle, not implementation readiness.

Allowed values:

```text
active
proposed
draft
deferred
superseded
deprecated
archived
```

Decision status inside `DECISIONS.md`, feature implementation state and runtime readiness remain separate concerns.

## 4. Conditional metadata

### `id`

Required for independently addressable records such as:

```text
RESEARCH-NNN
DESIGN-NNN
FEAT-NNN
SPIKE-NNN
```

Not required for canonical singleton documents such as `PROJECT.md` or `ARCHITECTURE.md`.

### `decision`

Optional link from a feature or design to its governing `DEC-NNN` when one exists.

### `sources`

Optional. Use only when the document materially derives from concrete internal or external artefacts.

Each source uses an OKF-compatible object:

```yaml
sources:
  - resource: ../context/ARCHITECTURE.md
    title: Portable OpenCode Architecture
  - resource: https://example.com/spec
    title: External specification
```

`resource` is required within each entry. Do not list every related document; ordinary relationships belong in Markdown links.

### `resource`

Optional canonical URI when the document describes another underlying asset.

### `tags`

Optional short strings only when tags support real filtering or retrieval. Do not add decorative tags.

### `generated`

Optional for machine-generated documents:

```yaml
generated:
  by: <generator identifier>
  at: <ISO 8601 timestamp>
```

Generated metadata does not imply verification.

## 5. Removed metadata

### `created` and `modified`

Removed from curated frontmatter.

Reason:

- Git already records creation and modification history;
- manual timestamps drift easily;
- updating them creates non-semantic churn;
- release or evidence dates belong in document bodies when meaningful.

### `verified`

Removed from generic document frontmatter.

Reason:

- a permanent `pending` value conveys no useful trust signal;
- verification is contextual rather than document-wide;
- accepted decisions, spike evidence, test results and machine state already express stronger verification semantics.

A future attestation system may add structured verification through a separate accepted design. It must not reintroduce ceremonial approval fields.

## 6. Reserved files

### `index.md`

- no YAML frontmatter;
- navigation and responsibility only;
- generated metadata is unnecessary unless the index itself becomes generated and validated by an explicit tool.

### `log.md`

- no YAML frontmatter;
- chronological Markdown headings;
- concise meaningful transitions only;
- not a session transcript.

This follows the OKF reserved-file model and reduces metadata that does not help navigation.

## 7. Validation schema

Parsed frontmatter is validated against:

```text
schemas/context-document.schema.json
```

The schema applies to non-reserved curated documents. Separate checks enforce:

- `index.md` and `log.md` have no frontmatter;
- internal links resolve;
- conditional IDs match document type and filename conventions;
- source resources are valid URLs or repository-relative paths;
- deprecated fields do not reappear.

## 8. Migration policy

Existing documents may temporarily contain `created`, `modified`, string-form `sources` or `verified` while the repository is migrated.

The migration must:

1. remove `created`, `modified` and `verified`;
2. remove frontmatter from `index.md` and `log.md`;
3. convert material `sources` to `{resource, title}` objects;
4. delete non-material source lists instead of converting them mechanically;
5. preserve document status and stable IDs;
6. validate all resulting frontmatter objects;
7. produce no content-body changes except broken-link corrections.

Until migration and validation complete, the `docs-only` profile remains pending rather than passed.

## 9. Example

```yaml
---
type: Design
id: DESIGN-004
title: Minimal Context Metadata Schema
description: Repository-owned frontmatter policy for curated knowledge documents.
status: active
sources:
  - resource: https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md
    title: Open Knowledge Format v0.2 specification
---
```

## 10. Reconsideration triggers

Expand the schema only when:

- an implemented query or validation workflow needs a field;
- automated generation requires provenance unavailable in Git;
- a real cross-repository exchange requires stronger OKF compatibility;
- formal trust or attestation becomes an implemented capability;
- repeated retrieval failures show that optional tags or resources add measurable value.
