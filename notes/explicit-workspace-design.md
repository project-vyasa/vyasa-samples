# Explicit workspace design

> Durable principles for **publishers, linguists, and researchers** authoring Vyasa workspaces.  
> Companion (viewer obligations): [`vyasa-apps/notes/explicit-workspace-design.md`](../../vyasa-apps/notes/explicit-workspace-design.md)

## Why this document exists

Vyasa serves two very different audiences:

| Audience | Scale | Expectation |
|----------|-------|-------------|
| **Publishers / linguists / researchers** | ~10⁵ | Explicit, inspectable workspace definitions. Willing to carry modest authoring burden for correctness. |
| **Readers / explorers** | ~10¹⁰ | Fast, pleasant UX in the viewer. Convenience is fine here — but only when it does not smuggle domain assumptions into the runtime. |

**Default posture:** declare intent in the workspace and resolve it at **build time**. Prefer a `vyasac pack` error over a viewer guess.

“Magic” and UX delighters belong in **vyasa-apps** (the viewer), not in **vyasac** (the compiler) or in packed publication data — unless the publication manifest already states the resolved outcome explicitly.

This aligns with our code-review guideline: the compiler and viewer runtime stay **domain-neutral**; no hardcoded symbols like `"mula"`, `"devanagari"`, `"verse"`, or `"speaker"` as implicit fallbacks.

---

## 1. Declare intent in workspace definitions

Authors express meaning in durable, version-controlled files:

| Concern | Where | Example |
|---------|-------|---------|
| Stream layout & primary text | `vyasac.toml` `[streams]` | `primary = { path = "content/mula" }` |
| URN hierarchy | `vyasac.toml` `[urn]` | `hierarchy = ["chapter", "verse"]` |
| Semantic aliases (entities) | `vocabulary/` | canonical IDs, alternate names (RFC-019 §4) |
| Stream display labels | `content/<stream>/localization.vy` | structure terms for that stream’s UI |
| Out-of-band metadata | `annotations/` | speaker ranges, editorial notes |

If a downstream consumer (viewer, search, graph export) needs to know something, it should be **compiled into the `.vyview` manifest** — not inferred at runtime from stream folder names or hardcoded lists.

---

## 2. Primary stream

The primary stream is the **authoritative text** for URNs and the **default label set** for streams that do not define their own localization.

Declare it explicitly in `vyasac.toml`:

```toml
[streams]
primary = { path = "content/mula" }
iast      = { path = "content/iast" }
# translation = { path = "content/translation" }  # future
```

**Resolution order (target behaviour, option C):**

Each stream that appears in the viewer **must** ship a resolved localization table in the manifest. Authors express reuse with `` `localization { extend = "primary" } `` (or another stream id) — see §3. The packer merges and validates; the viewer does not walk a fallback chain.

The primary stream is the usual **`extend` target** and must define a complete baseline for all `[urn].hierarchy` keys.

---

## 3. Vocabulary ≠ localization

These were conflated in early samples. They serve different purposes.

### Vocabulary (semantic registry — until RFC-019)

**Purpose:** declare **which identifiers exist** in this publication’s semantic model. Not display text.

- **Entity IDs** — canonical keys used in annotations (`speaker=arjuna`), graph nodes, search
- **Action IDs** — keys for annotation/UI chrome types (`uvaca`, `speaker`, `note`)
- Lives in `vocabulary/` (e.g. `entities.vy`, `actions.vy`)
- Values are **identity maps** (`"arjuna" = "arjuna"`) until RFC-019 adds alias properties on nodes

**Rule:** if it is shown to a human in the UI, it belongs in **localization** (below), not vocabulary.

When RFC-019 is implemented, vocabulary gains **alias properties** (e.g. `krishna` aliases `["śrī-bhagavān"]`) — identity linking for graph/search, distinct from stream display spellings.

See RFC-019 §4 (*Alternate Interpretations & Aliasing*) in [`vyasa-docs` — `rfc-019-extending-publications.md`](../../vyasa-docs/astro-starlight/src/content/docs/notes/rfc-019-extending-publications.md).

### Localization (presentational — per stream)

**Purpose:** human-facing labels for structure and chrome **in the convention of that stream**.

- Example (vyasa-bg / iast): `chapter` → `adhyāya`, `verse` → `śloka`
- Example (Rigveda / iast): `verse` → `ṛc` (work-specific norm — not a global Vyasa default)
- Lives in `content/<stream>/localization.vy` — **not** in `vocabulary/`

**Rule of thumb:** if removing the label would not change the graph or annotations, it is localization, not vocabulary.

#### `localization` command (draft spec)

> **Canonical proposal:** this section in [`notes/explicit-workspace-design.md`](./explicit-workspace-design.md).  
> Viewer impact only: [`vyasa-apps/notes/explicit-workspace-design.md`](../../vyasa-apps/notes/explicit-workspace-design.md).

Authors declare display strings with a top-level `` `localization `` command in `content/<stream>/localization.vy`. The packer validates, merges, and emits a **fully resolved** label table per stream into the manifest. The viewer performs lookup only — no inheritance at runtime.

**Reuse another stream’s labels** with `extend` (explicit; infrequent):

```vyasa
`localization { extend = "primary" }
```

`primary` is the stream id declared in `vyasac.toml` under `[streams] primary = { path = … }`. A stream may also extend a named peer, e.g. `extend = "mula"`.

Overlay only keys that differ:

```vyasa
`localization { extend = "primary" }

`structure [
    "chapter" = "adhyāya",
    "verse" = "śloka"
]
```

To reuse primary labels unchanged, a single `extend` line is enough — but that line **must** be present. There is no silent “fall back to primary if this file is missing.”

**Primary stream** carries the baseline localization for the work. It does not use `extend` unless intentionally layering on a shared template (unusual).

#### Key identifiers — use names declared elsewhere

Localization keys are **not** an open-ended string map. Keys must be identifiers already declared in the workspace schema:

| Category | Key source | Example keys |
|----------|------------|--------------|
| **structure** | `[urn].hierarchy` in `vyasac.toml` | `chapter`, `verse` — or `mandala`, `sukta`, `verse` for Rigveda |
| **entities** | `vocabulary/entities.vy` (canonical IDs) | `arjuna`, `krishna`, `sanjaya` |
| **actions** | `vocabulary/actions.vy` or `command-def` | `uvaca`, `speaker`, `note` |
| *(future)* | other `command-def` / annotation types | same rule: key must exist in workspace defs first |

**Principle:** *use identifiers declared elsewhere (`vyasac.toml`, `context.vy`, `vocabulary/`, `command-def`) as keys.* The packer rejects unknown keys and missing required keys (see below).

Structure labels always mirror **`[urn].hierarchy`** — not ad-hoc synonyms. The *value* may be work- and stream-specific (`śloka` vs `ṛc`); the *key* stays `verse` because that is what the URN schema declares.

#### Pack-time resolution (explicit `extend` only)

For each content stream that participates in the viewer:

1. **Require** `content/<stream>/localization.vy` (or a documented exemption for non-UI streams).
2. If `extend = "<id>"` is set, resolve that stream’s localization first (depth-first; detect cycles → error).
3. Overlay categories from this file (`structure`, `entities`, `actions`, …).
4. **Validate:** every key in `[urn].hierarchy` has a `structure` label in the merged result; every key referenced by annotations/UI for that build profile is covered.
5. Write the merged table to the manifest keyed by stream id.

No implicit chain `active → primary → global` at runtime. If a stream needs primary’s labels, the author writes `extend = "primary"` explicitly.

#### Examples

**Primary (mula) — full baseline:**

```vyasa
`structure [
    "chapter" = "अध्याय",
    "verse" = "श्लोक"
]
```

**IAST — extend + structure overrides:**

```vyasa
`localization { extend = "primary" }

`structure [
    "chapter" = "adhyāya",
    "verse" = "śloka"
]
```

**Future English translation — extend + English chrome:**

```vyasa
`localization { extend = "primary" }

`structure [
    "chapter" = "Chapter",
    "verse" = "Verse"
]
```

**Rigveda iast — same hierarchy keys, different norms:**

```toml
# vyasac.toml
[urn]
hierarchy = ["mandala", "sukta", "verse"]
```

```vyasa
`structure [
    "mandala" = "maṇḍala",
    "sukta" = "sūkta",
    "verse" = "ṛc"
]
```

---

## 4. Shift left — build errors, not viewer heuristics

### Today (legacy — to remove)

The platform viewer’s `getVocabularyLabel()` falls back through a hardcoded list:

`'vocabulary'`, `''`, `'mula'`, `'devanagari'`, `'primary'`

That made early samples work by accident but violates domain neutrality and hides misconfigured workspaces.

### Target

| Stage | Responsibility |
|-------|----------------|
| **Pack** | Parse `localization.vy`; resolve `extend` explicitly; validate keys against `vyasac.toml` / vocabulary; error on missing required labels |
| **Manifest** | Ship fully merged label table per stream + `primary_stream` id |
| **Viewer** | Lookup by manifest only; optional UX polish (typography, layout) — **no domain symbol fallbacks** |

If a stream needs another stream’s labels, the author must declare `` `localization { extend = "…" } ``. A missing `localization.vy` (for a UI stream) → **pack fails** with an actionable message.

---

## 5. vyasa-bg sample — current vs target

### Current (vyasa-bg)

| File | Role |
|------|------|
| `vocabulary/entities.vy`, `actions.vy` | Canonical ID registry (identity values) |
| `content/mula/localization.vy` | Primary display labels (Devanagari) |
| `content/iast/localization.vy` | IAST display labels + `extend = "primary"` |
| `vyasac.toml` `[streams] primary` | Declares authoritative stream path |

### Target (when `extend` merge lands in vyasac)

iast may list **only overrides** under `extend = "primary"`; packer merges with mula baseline. Until then, iast `localization.vy` lists full label sets explicitly.

---

## 6. Implementation tracking

| Item | Repo | Status |
|------|------|--------|
| Primary stream in manifest | `vyasa` / vyasac | Not wired to vocabulary fallback |
| `localization.vy` load + skip at pack | `vyasa` / vyasac | Done — sidecar loaded like `context.vy` |
| `extend` merge at pack time | `vyasa` / vyasac | Pending — iast lists full labels until then |
| Remove hardcoded stream fallbacks | `vyasa-apps` | [`WORK.md`](./WORK.md) |
| vyasa-bg: split vocabulary / localization | `vyasa-samples` | [`WORK.md`](./WORK.md) |
| Document per-work structure terms (ṛc vs śloka) | `vyasa-samples` | Authoring guide in workspace README |

Cross-repo queue: [`notes/WORK.md`](./WORK.md) · apps: [`vyasa-apps/notes/WORK.md`](../../vyasa-apps/notes/WORK.md) · compiler: [`vyasa/notes/compiler.md`](../../vyasa/notes/compiler.md)

---

## 7. Agent handoff

When touching vocabulary, localization, or stream config:

1. Read this doc and the apps companion.
2. Do not add viewer-side domain fallbacks — extend the packer/manifest instead.
3. Keep `vocabulary/` for semantic aliases; put stream display strings in `localization.vy`.
4. Update samples to model explicit `primary` in `vyasac.toml`.
