# Project Vyasa Samples

This repository contains the official sample publications and workspaces for **Project Vyasa**. 

Each directory in `workspaces/` is a self-contained publication that can be compiled using the Vyasa compiler (`vyasac`).

## 📚 Live Catalog

The unified catalog containing all sample publications is deployed to GitHub Pages and can be accessed directly by the Vyasa Platform viewer or other compatible frontends.

**Global Catalog Endpoint**: 
[https://project-vyasa.github.io/vyasa-samples/catalog.json](https://project-vyasa.github.io/vyasa-samples/catalog.json)

## 🛠️ Building the Samples

Each `build` runs **pack** (compile to `.vyview`) then **publish** (copy into `dist/` and refresh `catalog.json` timestamps). You should not need to run `publish` separately.

1. Install dependencies:
   ```bash
   bun install
   ```

2. Build all workspaces into `dist/`:
   ```bash
   bun run build
   ```

   Single workspace: `bun run build:vyasa-bg` (etc.)

3. Deploy to GitHub Pages (runs `build` automatically via `predeploy`):
   ```bash
   bun run deploy
   ```

**Advanced:** `pack:*` runs compile only (no copy to `dist/`). `publish:*` copies an already-packed workspace — useful only if you intentionally skipped publish after pack.

## Local development (Caddy)

The viewer loads local catalogs/registries via Settings (not Vite middleware). Serve `dist/` with Caddy:

```bash
caddy run --config Caddyfile
```

Then in the viewer Settings → Catalog Sources:
- **Custom Registries:** `http://localhost:8080/registry.json`
- **Custom Catalogs:** `http://localhost:8080/vysamples/catalog.json` (enable the toggle)

Library lists **Local Catalogs** / **Local Registries** above **Global Registry**. Open publications from a local section so URLs include `?catalog=` and load from localhost.

## 📂 Repository Structure

- `workspaces/`: Contains individual Vyasa publications. Each workspace has its own `vyasac.toml`, `context.vy`, and `.vy` content files.
- `notes/`: Coordination queue for sample-publication work ([`notes/readme.md`](notes/readme.md)).
- `scripts/`: Build and deployment scripts.
- `dist/`: The generated output directory containing `.vyview` archives and the `catalog.json`. This directory is deployed to GitHub Pages.
