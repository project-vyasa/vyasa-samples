# vyasa-samples notes

Coordination space for **sample publications and end-to-end validation** in this repo.

## Repository locations

| Repo | Path | Role |
|------|------|------|
| **vyasa-samples** (here) | `/Users/anand/Projects/project-vyasa/vyasa-samples` | Sample `.vy` content, `context.vy`, packed `.vyview` publications, catalog |
| **vyasa** (compiler) | `/Users/anand/Projects/project-vyasa/vyasa` | Rust toolchain: `vyasac`, viewer WASM runtime, language/schema |
| **vyasa-apps** | `/Users/anand/Projects/project-vyasa/vyasa-apps` | SvelteKit platform — viewer, explore, library |
| **vyasa-docs** | `/Users/anand/Projects/project-vyasa/vyasa-docs` | Astro Starlight docs; hosts an **earlier frozen** viewer and playarea — **do not replace WASM builds here** |

## Boundary

| Repo | Scope | Notes location |
|------|-------|----------------|
| **`vyasa-samples`** (here) | Sample content, workspace layout, `vyasac pack`/`publish`, catalog validation | `notes/` |
| **`vyasa`** | Compiler, language features, WASM runtime | [`../vyasa/notes/`](../vyasa/notes/) |
| **`vyasa-apps`** | Platform UI, viewer consumption of packed output | [`../vyasa-apps/notes/`](../vyasa-apps/notes/) |

When an issue spans repos, record it where work **starts**, and cross-link under **Blocked / upstream** or **Downstream**.

Compiler-facing backlog: [`vyasa/notes/compiler.md`](../vyasa/notes/compiler.md)  
Apps-facing backlog: [`vyasa-apps/notes/WORK.md`](../vyasa-apps/notes/WORK.md)

## Files

| File | Purpose |
|------|---------|
| [`view-templates-guide.md`](../../vyasa-apps/docs/guides/view-templates-guide.md) | **Draft** in vyasa-apps — view templates, content themes (→ vyasa-docs) |
| [`explicit-workspace-design.md`](./explicit-workspace-design.md) | **Durable principles** — explicit workspace declarations, vocabulary vs localization, primary stream, shift-left validation |
| [`TEMPLATE.md`](./TEMPLATE.md) | Blank template — copy or reset from this |
| [`WORK.md`](./WORK.md) | Live queue — edit together (NOW / NEXT / LATER) |

## Conventions

- **NOW** — actively in progress or ready to pick up next; keep short.
- **NEXT** — agreed follow-ups; confirm before opportunistic work.
- **LATER** — ideas, design questions, post–preview-release scope.
- Prefix items with `[ ]` / `[~]` / `[x]` for open / in progress / done.
- Tag cross-repo items: `(compiler)`, `(apps)`, `(samples)`, `(blocked: …)`.
- **GitHub issues** — defer until after a preview release; track here first.
- Archive completed tranches at the bottom of `WORK.md` or under **Done**.

## Agent handoff

Samples agents should read `WORK.md` before starting and update it when finishing a slice of work or discovering compiler/platform dependencies.
