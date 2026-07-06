import { readdirSync, readFileSync, copyFileSync, mkdirSync, writeFileSync } from "fs";
import { join } from "path";
import { execSync } from "child_process";

const workspacesDir = join(import.meta.dir, "../workspaces");
const distDir = join(import.meta.dir, "../dist");

mkdirSync(distDir, { recursive: true });

const catalogItems = [];

const dirs = readdirSync(workspacesDir, { withFileTypes: true })
  .filter(d => d.isDirectory() && d.name !== 'minimal')
  .map(d => d.name);

for (const dir of dirs) {
  const projectPath = join(workspacesDir, dir);
  console.log(`Building ${dir}...`);
  
  // Run pack for view target
  console.log(`Packing view...`);
  execSync(`cargo run --manifest-path ../vyasa/vyasac/Cargo.toml -- pack --target view ${projectPath}`, { stdio: 'inherit' });

  // Copy output artifacts to dist
  const outTypes = ['sqlite', 'vyview', 'zip', 'catalog.json'];
  for (const ext of outTypes) {
    const filename = `${dir}.${ext}`;
    const src = join(projectPath, "output", filename);
    const dst = join(distDir, filename);
    try {
      copyFileSync(src, dst);
      console.log(`Copied ${filename}`);
    } catch (e) {
      console.warn(`Could not copy ${src}`);
    }
  }

  // Read the workspace catalog to merge
  try {
    const catSrc = join(projectPath, "output", `${dir}.catalog.json`);
    const data = JSON.parse(readFileSync(catSrc, "utf8"));
    catalogItems.push({ id: data.id, title: data.name || data.title, vyviewUrl: data.payloadUrl || data.vyviewUrl });
  } catch (e) {
    console.warn(`Could not read catalog for ${dir}`);
  }
}

// Generate unified catalog
const globalCatalog = {
  schemaVersion: "0.1.0",
  identifier: "project-vyasa-samples",
  title: "Project Vyasa Samples",
  publications: catalogItems
};

writeFileSync(join(distDir, "catalog.json"), JSON.stringify(globalCatalog, null, 2));
console.log("Unified catalog.json generated.");
