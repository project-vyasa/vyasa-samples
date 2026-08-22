# Samples work queue

> Last updated: 2026-07-28 — explicit workspace design documented

## Context

This repo validates Vyasa **end-to-end from a publisher POV**: workspace layout, `.vy` content, `vyasac pack`/`publish`, and catalog deployment. Primary focus workspace: **`vyasa-bg`** (Bhagavad Gita with mula + iast streams and speaker annotations).

**Design principles:** [`explicit-workspace-design.md`](./explicit-workspace-design.md) — explicit declarations, vocabulary vs localization split, primary stream, shift-left validation.

**Sibling repos:** compiler `/Users/anand/Projects/project-vyasa/vyasa` · platform `/Users/anand/Projects/project-vyasa/vyasa-apps` · docs `/Users/anand/Projects/project-vyasa/vyasa-docs` (legacy viewer — **do not update WASM there**).

## NOW

- [x] **vyasa-bg content cleanup** — remove legacy `person uvaca` event headers; move speaker attribution text out of verse scope; speaker metadata lives in `annotations/speakers.vy`.
- [x] **Rebuild vyasa-bg** — packed successfully with vyasac `localization.vy` sidecar support (rebuild vyasac from `vyasa/` first).
- [x] **CSS files (HTML target)** — `publisher_css` / `css`; vyasa-bg + vedabase-bg share `styles/indic-verse.css`; intimate-note uses `styles/prose.css`; bible is self-contained (`templates/html/theme.css` only).

## NEXT

- [ ] **vedabase-bg** — align with current compiler/schema after vyasa-bg patterns settle.
- [ ] **FEATURE_MATRIX.md** — add annotations, inter-verse text, localization.

## LATER

- [ ] **Workspace READMEs** — per-workspace authoring guides; document work-specific structure terms (e.g. Rigveda `ṛc` vs Gita `śloka`).
- [ ] **GitHub issues** — file from this list after preview release.

## Blocked / upstream (compiler or other repos)

| Item | Repo | Notes |
|------|------|-------|
| **`localization.vy` sidecar load** | `vyasa` | Done — skipped as content; merged into stream env at pack |
| **`extend` merge + manifest `primary_stream`** | `vyasa` | Pending |
| **Remove vocabulary stream-name heuristics** | `vyasa-apps` | [`explicit-workspace-design.md`](../../vyasa-apps/notes/explicit-workspace-design.md) |
| Inter-verse text URN segments (`:pre`/`:post`) | `vyasa` | See `urn_bitwise_test.rs` |
| Explorer/reader display of inter-verse text | `vyasa-apps` | Plain text between `v` blocks |
| Annotation-driven speaker labels in reader | `vyasa-apps` | Done — chrome Labels + gutter badges; titlesByStream for container names |
| Localized numerals for URN / component display | `vyasa-apps` (+ packer maps?) | See apps `WORK.md` NEXT |

## Open questions

1. Should inter-verse speaker attribution lines use explicit `:pre` URN markers, or is positional plain text sufficient for now?
2. ~~Retain `vocabulary/` vs stream `context.vy`?~~ **Resolved:** `vocabulary/` = semantic aliases (RFC-019 §4); `content/<stream>/localization.vy` = display labels. See [`explicit-workspace-design.md`](./explicit-workspace-design.md).

## Done (recent)

- [x] Initial notes folder and work queue (this file).
- [x] **vyasa-bg content cleanup** — 58 legacy `` `person `uvaca `` commands removed; 117 speaker colophon lines moved outside verse scope across mula + iast streams.
- [x] **vyasa-bg baggage removal** — entity command-defs, debug-marker templates, `event_header.subject_key`, unused speaker CSS.
- [x] **Authoring docs** — `workspaces/vyasa-bg/README.md` (inter-verse text, annotations, URN segments).
- [x] **Explicit workspace design doc** — vocabulary vs localization, primary stream (option C), shift-left validation.
- [x] **Expand speaker annotations** — `annotations/speakers.vy` covers all 18 chapters (60 ranges); derived from inter-verse colophons; fixed ch 1 v20 sanjaya / v21 arjuna split.

---

### Exchange log

| Date | From | Note |
|------|------|------|
| 2026-07-28 | User | Explicit workspace design: vocabulary vs localization, primary stream, no viewer heuristics. |
