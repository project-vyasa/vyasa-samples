# vyasa-bg — Bhagavad Gita sample

Structured verse publication with **mula** (Devanagari) and **iast** transliteration streams, plus speaker metadata in `annotations/`.

## Layout

| Path | Role |
|------|------|
| `content/mula/` | Devanagari verse text (primary stream) |
| `content/iast/` | IAST transliteration (parallel chapter files) |
| `content/*/localization.vy` | Per-stream display labels (structure, entities, actions) |
| `annotations/speakers.vy` | Speaker ranges for all 18 chapters via `annotate { speaker=… }` |
| `vocabulary/` | Canonical entity / action / facet ID registry (not display text) |
| `context.vy` | Workspace commands, settings, annotation aliases |
| `templates/html/` | Stream block templates (`context.vy`); `theme.css` / `reading.css` listed in `[build.default] css` |
| `templates/html/views/theme.vy` | `theme_layout` body slot — shell + CSS from packer |
| `templates/html/views/reading.vy` | Craft stacked reading — `item` weaving (`reading.css` for craft rules) |
| `styles/indic-verse.css` | Publisher-shared tokens, `html.theme-*`, grid `.vyasa-block-*` (`publisher_css`) |

See also [`notes/explicit-workspace-design.md`](../../notes/explicit-workspace-design.md) for vocabulary vs localization principles.

## Streams

```toml
[streams]
primary = { path = "content/mula" }
iast      = { path = "content/iast" }
```

**Primary** (`mula`) is the authoritative text for URNs and the baseline for display labels. The iast stream declares `` `localization { extend = "primary" } `` and overrides structure/entity/action labels for its convention.

## Vocabulary vs localization

| Layer | Location | Example |
|-------|----------|---------|
| **Registry** | `vocabulary/entities.vy` | `"arjuna" = "arjuna"` (canonical ID) |
| **Display** | `content/mula/localization.vy` | `"arjuna" = "अर्जुन"` |
| **Display (iast)** | `content/iast/localization.vy` | `"arjuna" = "arjuna"`, `"verse" = "śloka"` |

Structure keys always match `[urn].hierarchy` (`chapter`, `verse`).

## Authoring verses

Use the verse alias:

```vyasa
`v 1 [
dharma-kṣetre kuru-kṣetre
samavetā yuyutsavaḥ
]
```

Each `` `v N [...] `` block is a **leaf-block** (verse). The compiler assigns **segment 0** to leaf-block body text.

## Speaker attribution (inter-verse text)

**Do not** put speaker attribution inside a verse block. Speaker *metadata* lives in `annotations/speakers.vy`.

Traditional colophon lines (`arjuna uvāca`, `śrī-bhagavān uvāca`, etc.) are **plain text between verses**:

```vyasa
sañjaya uvāca
`v 2 [
dṛṣṭvā tu pāṇḍavānīkaṁ
...
]
```

Narrative speech *within* a verse stays inside the verse.

## Speaker annotations

```vyasa
`annotate 2:11..2:53 { speaker=krishna }
```

Explorer and reader resolve the **Speaker** facet type label from `vocabulary/facets.vy` + per-stream `localization.vy` (`facets` block); entity names from `entities` + localization.

## Build

```bash
bun run build:vyasa-bg
```

Verify the pack without sqlite3:

```bash
vyasac inspect dist/vyasa-bg/vyasa-bg.vyview
vyasac inspect --table html_templates dist/vyasa-bg/vyasa-bg.vyview
vyasac inspect --urn 1:1 dist/vyasa-bg/vyasa-bg.vyview
vyasac inspect --check dist/vyasa-bg/vyasa-bg.vyview
```

## Removed legacy patterns

| Old pattern | Replacement |
|-------------|-------------|
| Display strings in `vocabulary/` | `content/<stream>/localization.vy` |
| `content/iast/context.vy` vocabulary block | `content/iast/localization.vy` |
| `` `person `uvaca `` inline headers | `annotations/speakers.vy` |
