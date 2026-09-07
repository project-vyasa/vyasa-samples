# Project Vyasa Samples

This repository contains the official sample publications and workspaces for **Project Vyasa**. 

Each directory in `workspaces/` is a self-contained publication that can be compiled using the Vyasa compiler (`vyasac`).

## 📚 Live Catalog

The unified catalog containing all sample publications is deployed to GitHub Pages and can be accessed directly by the Vyasa Platform viewer or other compatible frontends.

**Global Catalog Endpoint**: 
[https://project-vyasa.github.io/vyasa-samples/catalog.json](https://project-vyasa.github.io/vyasa-samples/catalog.json)

## 🛠️ Building the Samples

Each `build` runs **pack** (compile to `.vyview`) then **publish** (copy into `vysamples/dist/` and refresh `catalog.json` timestamps). You should not need to run `publish` separately.

1. Install dependencies:
   ```bash
   bun install
   ```

2. Build all workspaces into `vysamples/dist/`:
   ```bash
   bun run build
   ```

   Single workspace: `bun run build:vyasa-bg` (etc.)

3. Deploy to GitHub Pages (runs `build` automatically via `predeploy`):
   ```bash
   bun run deploy
   ```

**Advanced:** `pack:*` runs compile only (no copy to `vysamples/dist/`). `publish:*` copies an already-packed workspace — useful only if you intentionally skipped publish after pack.

## Local development (Caddy)

The viewer loads local catalogs/registries via Settings (not Vite middleware). `root` paths in the Caddyfile are relative to the file itself (no home-directory prefixes).

```bash
caddy run --config Caddyfile
```

**Committed registry** (`local-registry.json`) lists **vysamples only** — what sample-repo contributors need.

**Multi-publisher testing:** copy the example and reload Caddy:

```bash
cp local-registry.local.json.example local-registry.local.json
caddy reload --config Caddyfile
```

`local-registry.local.json` is gitignored. The Caddyfile serves it when present; otherwise it falls back to `local-registry.json`.

In the viewer Settings → Catalog Sources:
- **Custom Registries:** `http://localhost:8080/registry.json`
- **Custom Catalogs:** `http://localhost:8080/vysamples/catalog.json` (enable the toggle)

The Caddyfile also exposes sibling publisher paths (`/muktabodha/`, `/sa_wikisource/`) for integrators who build those dist trees locally. Single-repo contributors in other publisher repos should use that repo’s own Caddyfile instead.

Library lists **Local Catalogs** / **Local Registries** above **Global Registry**. Open publications from a local section so URLs include `?catalog=` and load from localhost.

## 📂 Repository Structure

- `vysamples/`: Publisher catalog root (`publisher.toml`, shared `styles/`, generated `dist/`). Matches `[publisher] identifier = "vysamples"`. Workspaces point here via `[publish] publisher_dir`.
- `workspaces/`: Contains individual Vyasa publications. Each workspace has its own `vyasac.toml`, `context.vy`, and `.vy` content files.
- `notes/`: Coordination queue for sample-publication work ([`notes/readme.md`](notes/readme.md)).
- `scripts/`: Build and deployment scripts.
- `vysamples/dist/`: Generated `.vyview` archives and `catalog.json`. This directory is deployed to GitHub Pages.
