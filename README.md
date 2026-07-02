# Project Vyasa Samples

This repository contains the official sample publications and workspaces for **Project Vyasa**. 

Each directory in `workspaces/` is a self-contained publication that can be compiled using the Vyasa compiler (`vyasac`).

## 📚 Live Catalog

The unified catalog containing all sample publications is deployed to GitHub Pages and can be accessed directly by the Vyasa Platform viewer or other compatible frontends.

**Global Catalog Endpoint**: 
[https://project-vyasa.github.io/vyasa-samples/catalog.json](https://project-vyasa.github.io/vyasa-samples/catalog.json)

## 🛠️ Building the Samples

The `.vyview` output files and the unified `catalog.json` are generated dynamically via the build script.

1. Install dependencies:
   ```bash
   bun install
   ```

2. Build all workspaces and pack them to the `dist/` folder:
   ```bash
   bun run build
   ```

3. Deploy to GitHub pages:
   ```bash
   bun run deploy
   ```

## 📂 Repository Structure

- `workspaces/`: Contains individual Vyasa publications. Each workspace has its own `vyasac.toml`, `context.vy`, and `.vy` content files.
- `scripts/`: Build and deployment scripts.
- `dist/`: The generated output directory containing `.vyview` archives and the `catalog.json`. This directory is deployed to GitHub Pages.
