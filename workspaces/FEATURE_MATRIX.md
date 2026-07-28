# Feature Matrix

This matrix tracks the coverage of Vyasa language features across the available sample workspaces.

| Feature Category | Feature | Syntax / Command | `minimal` | `bible` | `intimate-note` | `vyasa-bg` |
| :--- | :--- | :--- | :---: | :---: | :---: | :---: |
| **Structure** | Command Definition | `` `command-def `` | ❌ | ✅ | ✅ | ✅ |
| | Alias Definition | `` `alias-def `` | ❌ | ✅ | ❌ | ✅ |
| | Context Settings | `` `set context `` | ❌ | ❌ | ❌ | ✅ |
| | Entity Registry | `` `set entities `` | ❌ | ❌ | ❌ | ✅ |
| **Content** | Text Stream | *text* | ✅ | ✅ | ✅ | ✅ |
| | Command Arguments | `` `cmd "arg" `` | ✅ | ✅ | ✅ | ✅ |
| | Attributes | `{ key="val" }` | ❌ | ❌ | ✅ | ✅ |
| | Segments | `|` | ❌ | ❌ | ❌ | ✅ |
| **Templating** | Native Templates | `` `template `` | ❌ | ✅ | ✅ | ✅ |
| | Variable Sub. | `$.text`, `$.arg` | ❌ | ✅ | ✅ | ✅ |
| | HTML Tags | `` `div { ... } `` | ❌ | ✅ | ✅ | ✅ |
| **Events/State** | Inline Entity | `` `entity `` | ❌ | ❌ | ❌ | ❌ |
| | Event Header | `` `( ... ) `` | ❌ | ❌ | ❌ | ❌ |
| | Annotations | `` `annotate `` | ❌ | ❌ | ❌ | ✅ |
| | Inter-verse text | *plain text between* `` `v `` | ❌ | ❌ | ❌ | ✅ |
| **Formatting** | Preserve Whitespace | `whitespace="preserve"` | ❌ | ❌ | ✅ | ✅ |
| | Line Break | `` `break `` | ❌ | ✅ | ✅ | ❌ |
| **URN** | URN Scheme | `[urn] scheme` | ❌ | ❌ | ❌ | ✅ |
| | Hierarchy | `[urn] hierarchy` | ❌ | ❌ | ❌ | ✅ |
| | `urn` Attribute | `urn="true"` | ❌ | ❌ | ❌ | ✅ |
| **Views** | Reference View | `--view reference` | ❌ | ❌ | ❌ | ✅ |

## Legend
- ✅ : Implemented
- ❌ : Not used

## Sample Overviews

### minimal
A bare-bones example relying on default behavior. Shows basic text and standard commands.

### bible
Demonstrates flow-oriented content.
- Uses `alias-def` for `v` -> `verse`.
- Uses simple Templates for formatting (`wj` - Words of Jesus).

### intimate-note
Demonstrates unstructured/semi-structured note-taking.
- Heavily uses `whitespace="preserve"`.
- Uses styling templates (`center`, `right`).

### vyasa-bg
Structured multi-stream verse sample (mula + iast).
- **Annotations**: Speaker ranges in `annotations/speakers.vy` via `annotate` and `*.uvaca` aliases.
- **Inter-verse colophons**: Traditional `X uvāca` lines as plain text between `` `v `` blocks (segment 0 reserved for verse body).
- **URN Config**: `[urn]` hierarchy `chapter` → `verse` in `vyasac.toml`.
- **Vocabulary**: `vocabulary/structure.vy` for Devanagari structure labels.
- **Templates**: Multi-stream reading layout in `templates/html/views/`.
