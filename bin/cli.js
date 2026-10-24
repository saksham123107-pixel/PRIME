#!/usr/bin/env node
/* ═════════════════════════════════════════════════════════════════════
   PRIME SKILLS — one command, 99 skills, every AI, every IDE.
   Cross-platform (Windows/macOS/Linux). Zero dependencies. Works offline.
   Usage:
     npx prime-skills                 -> ./skills
     npx prime-skills --all-agents    -> also every AI/IDE skills dir
     npx prime-skills --ponytail      ->
     npx prime-skills --dest=PATH
   ═════════════════════════════════════════════════════════════════════ */
"use strict";
const fs = require("fs");
const path = require("path");
const os = require("os");
const { spawnSync } = require("child_process");

const args = process.argv.slice(2);
const allAgents = args.some(a => a === "--all-agents" || a === "-a");
const pony = args.some(a => a === "--ponytail");
const skipEcc = args.some(a => a === "--skip-ecc");
const destArg = args.find(a => a.startsWith("--dest="));
const DEST = destArg ? path.resolve(destArg.slice(7)) : path.join(process.cwd(), "skills");

const PKG = path.dirname(path.dirname(__filename));
const BUNDLE = path.join(PKG, "bundle");

const C = { g: s => `\x1b[32m${s}\x1b[0m`, m: s => `\x1b[35m${s}\x1b[0m`, y: s => `\x1b[33m${s}\x1b[0m`, c: s => `\x1b[36m${s}\x1b[0m`, r: s => `\x1b[31m${s}\x1b[0m` };

console.log("");
console.log(C.m("   =========================================================="));
console.log(C.m("    P R I M E   S K I L L S   I N S T A L L E R"));
console.log(C.m("    one command - every skill - every AI - every IDE"));
console.log(C.m("   =========================================================="));
if (pony) {
  console.log(C.y(`
        \\_\\
      (( \\ \\,   PONYTAIL MODE ENGAGED
       \\\\ \\.\\\\  installing PRIME skills...
        \`\`  (\\)
         \`-->
`));
}

if (!fs.existsSync(BUNDLE)) {
  console.error(C.r(" [!] bundle/ not found in package — reinstall: npm i -g prime-skills"));
  process.exit(1);
}

// --- 1. offline bundle install --------------------------------------------
fs.mkdirSync(DEST, { recursive: true });
const entries = fs.readdirSync(BUNDLE, { withFileTypes: true }).filter(d => d.isDirectory());
let n = 0;
for (const e of entries) {
  n++;
  process.stdout.write(`  [${String(n).padStart(2, "0")}/${entries.length}] ${e.name.padEnd(42)}`);
  const src = path.join(BUNDLE, e.name);
  if (e.name === "ecc-suite") { // flatten 46 ECC skills into DEST
    for (const s of fs.readdirSync(src, { withFileTypes: true })) {
      if (s.isDirectory()) fs.cpSync(path.join(src, s.name), path.join(DEST, s.name), { recursive: true });
    }
    console.log(C.g("OK bundle(offline suite)"));
  } else {
    fs.cpSync(src, path.join(DEST, e.name), { recursive: true });
    console.log(C.g("OK bundle(offline)"));
  }
}

// --- 2. distribute to every AI / IDE ----------------------------------------
const HOME = os.homedir();
const CWD = process.cwd();
const AGENTS = [
  ["Claude Code", path.join(HOME, ".claude", "skills")],
  ["Codex CLI", path.join(HOME, ".codex", "skills")],
  ["Gemini CLI", path.join(HOME, ".gemini", "skills")],
  ["Cursor", path.join(HOME, ".cursor", "skills")],
  ["Windsurf", path.join(HOME, ".windsurf", "skills")],
  ["Qoder", path.join(HOME, ".qoder", "skills")],
  ["Qoder(project)", path.join(CWD, ".qoder", "skills")],
  ["OpenCode", path.join(HOME, ".opencode", "skills")],
  ["Goose", path.join(HOME, ".goose", "skills")],
  ["Claude(project)", path.join(CWD, ".claude", "skills")],
  ["Cursor(project)", path.join(CWD, ".cursor", "skills")],
];
if (allAgents) {
  console.log("");
  console.log(C.y(" distributing to every AI + IDE..."));
  for (const [name, dir] of AGENTS) {
    fs.mkdirSync(dir, { recursive: true });
    fs.cpSync(DEST, dir, { recursive: true });
    console.log(C.g(`   OK ${name.padEnd(16)} -> ${dir}`));
  }
} else {
  console.log(C.c("\n [i] add --all-agents to mirror into Claude/Codex/Gemini/Cursor/Windsurf/Qoder/OpenCode/Goose"));
}

// --- 3. ECC full harness (optional, best-effort) -----------------------------
if (!skipEcc) {
  console.log("");
  console.log(C.y(" ECC full harness (agents+commands+hooks) — best effort..."));
  const r = spawnSync("npx", ["-y", "ecc-universal@2.2.3", "setup"], { stdio: "ignore", timeout: 150000, shell: process.platform === "win32" });
  if (r.status === 0) console.log(C.g("   OK ECC harness installed via ecc-universal"));
  else console.log(C.c("   [i] ECC skills bundled OK; full harness later: npx ecc-universal@2.2.3 setup"));
}

// --- 4. summary ----------------------------------------------------------------
const count = fs.readdirSync(DEST, { withFileTypes: true })
  .filter(d => d.isDirectory() && fs.existsSync(path.join(DEST, d.name, "SKILL.md"))).length;
console.log("");
console.log(C.m(" ========================================================"));
console.log(C.m(`  PRIME SKILLS: ${count} skills installed -> ${DEST}`));
console.log(C.y("  ponytail secured. go build something."));
console.log(C.m(" ========================================================"));
