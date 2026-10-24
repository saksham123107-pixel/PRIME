<div align="center">

# PRIME SKILLS

### One command. 99 elite skills. Every AI. Every IDE. Zero dependencies.

**The complete skill arsenal for AI coding harnesses — reverse engineering, security audit, CTF, code review, testing, and web development — installed offline in seconds.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Skills](https://img.shields.io/badge/skills-99-8A2BE2)](#whats-inside-99-skills)
[![Platforms](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-blue)](#install)
[![Node](https://img.shields.io/badge/node-%3E%3D16.7-green)](https://nodejs.org)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#contributing)

[Quick Start](#-quick-start) · [Skill Catalog](#-whats-inside--99-skills) · [How It Works](#-how-it-works) · [FAQ](#-faq)

</div>

---

## Why PRIME SKILLS?

AI coding assistants are only as good as the knowledge they carry. PRIME SKILLS turns **any** AI harness — Claude Code, Codex CLI, Gemini CLI, Cursor, Windsurf, **Qoder**, OpenCode, Factory Droid, GitHub Copilot, Goose — into a full-stack engineering powerhouse by installing **99 curated, production-grade skills** in one shot:

-  **Reverse engineering** — APKs (JADX/Apktool), native binaries (Ghidra/DWARF), protocols, Rust, C++, C#, Python, JS, .NET, WASM, Go
-  **Security** — OWASP audits, red-team adversarial testing, CodeQL static analysis, secret scanning
-  **Project review** — the highest-rated code-review skills on skills.sh (Matt Pocock 778k installs, Sentry, Anthropic, CodeRabbit)
-  **Testing** — E2E patterns, testing strategy, constant-time testing, React Native & Angular suites
-  **ECC suite** — the full 46-skill agent-harness system from [affaan-m/ECC](https://github.com/affaan-m/ECC)
-  **Web & design** — web development, website cloning, design-system extraction

**Offline-first**: every skill ships inside this repo. No network? No problem — installation is a local file copy that finishes in under a second.

---

##  Quick Start

### npx (recommended — no install)
```bash
npx github:saksham123107-pixel/PRIME --all-agents
```

### Windows — double-click
```
prime-skills.bat
```
or from CMD:
```bat
node bin\cli.js --all-agents
```

### Linux / macOS / WSL / Git Bash
```bash
bash prime-skills.sh --all-agents
```

### Global install (npm)
```bash
npm i -g prime-skills        # once published to the registry
prime-skills --all-agents
```

<details>
<summary><b>All flags</b></summary>

| Flag | Effect |
|---|---|
| `--all-agents` / `-a` | Mirror skills into every detected AI/IDE skills dir |
| `--ponytail` | verbose rainbow mode |
| `--skip-ecc` | Skip the optional ECC full-harness step |
| `--dest=PATH` | Custom install directory (default `./skills`) |

</details>

---

##  What's Inside — 99 Skills

| Category | Count | Skills |
|---|---:|---|
|  [ECC Suite](https://github.com/affaan-m/ECC) | 46 | api-design, backend-patterns, tdd-workflow, frontend-patterns, deep-research, security-review, mcp-server-patterns, eval-harness, unified-memory, strategic-compact … |
|  Reverse Engineering | 7 | reverse-engineer-anything (REA), reverse-engineering-agent, reverse-engineering, protocol-reverse-engineering, binary-analysis-patterns, dwarf-expert, apk-teardown-research |
|  CTF | 10 | ctf-reverse, ctf-crypto, ctf-forensics, ctf-malware, ctf-osint, ctf-pwn, ctf-web, ctf-writeup, solve-challenge, ctf-web-reverse-audit |
|  Security | 6 | security-scanner, code-security-audit, security-audit-owasp, red-team-adversarial-testing, li-python-sec-check, codeql |
|  Project Review | 8 | smart-code-review, code-review, code-review-matt 778k, code-review-sentry, code-review-anthropics, code-review-coderabbit, codebase-design, diagnosing-bugs |
|  Testing | 8 | e2e-testing-patterns, testing-patterns, afrexai-qa-testing-engine, testing-strategy (Anthropic), constant-time-testing, testing-handbook-generator, react-native-testing, angular-testing |
|  Web & Design | 13 | web-development, clone-website, python-executor, extract-design-system 130k, angular suite ×10, autofix |
| **Total** | **99** | |

<details>
<summary><b>Full skill list</b></summary>

`3mper0rr-red-team-adversarial-testing` · `afrexai-qa-testing-engine` · `agent-introspection-debugging` · `agent-sort` · `angular-component` · `angular-di` · `angular-directives` · `angular-forms` · `angular-http` · `angular-routing` · `angular-signals` · `angular-ssr` · `angular-testing` · `angular-tooling` · `apk-teardown-research` · `article-writing` · `autofix` · `binary-analysis-patterns` · `clone-website` · `code-review` · `code-review-anthropics` · `code-review-coderabbit` · `code-review-matt` · `code-review-sentry` · `code-security-audit` · `codebase-design` · `coding-standards` · `constant-time-testing` · `ctf-crypto` · `ctf-forensics` · `ctf-malware` · `ctf-osint` · `ctf-pwn` · `ctf-reverse` · `ctf-web` · `ctf-web-reverse-audit` · `ctf-writeup` · `deep-research` · `diagnosing-bugs` · `dwarf-expert` · `e2e-testing-patterns` · `ecc-suite` · `eval-harness` · `extract-design-system` · `li-python-sec-check` · `protocol-reverse-engineering` · `python-executor` · `react-native-testing` · `reverse-engineer-anything` · `reverse-engineering` · `reverse-engineering-agent` · `security-audit-owasp` · `security-scanner` · `security-review` · `smart-code-review` · `solve-challenge` · `testing-handbook-generator` · `testing-patterns` · `testing-strategy` · `tdd-workflow` · `web-development` … and all 46 ECC skills

</details>

---

##  Where Skills Get Installed

| Target | Path (`--all-agents`) |
|---|---|
| Claude Code | `~/.claude/skills` |
| Codex CLI | `~/.codex/skills` |
| Universal shared | `~/.agents/skills` |
| Codex CLI | `~/.codex/skills` |
| Gemini CLI | `~/.gemini/skills` |
| Cursor | `~/.cursor/skills` |
| Windsurf | `~/.windsurf/skills` |
| **Qoder** | `~/.qoder/skills` |
| OpenCode | `~/.config/opencode/skill` |
| OpenCode (alt) | `~/.opencode/skills` |
| Factory Droid | `~/.factory/skills` |
| GitHub Copilot | `~/.copilot/skills` |
| Universal shared | `~/.agents/skills` |
| Goose | `~/.goose/skills` |
| Project-local | `./.claude/skills`, `./.cursor/skills`, `./.qoder/skills` |

Without `--all-agents`, skills install to `./skills` in your current project only.

---

##  How It Works

Every skill is a folder containing a `SKILL.md` — a name, a description, and expert instructions. Modern AI harnesses scan their skills directories and **auto-load the relevant skill** when your task matches (ask your agent to "audit this code" and the security-audit skill activates).

PRIME SKILLS simply puts the right folders in the right places. It:

1. **Copies the bundled skills** (offline, instant) — no network required
2. **Mirrors them** into every detected AI/IDE directory with `--all-agents`
3. Optionally boots the **ECC full harness** (`npx ecc-universal@2.2.3 setup`) for agents + commands + hooks + memory
4. Falls back gracefully: bundle -> `clawhub` -> GitHub tarball -> `npx skills add`

---

##  FAQ

<details>
<summary><b>Is this safe?</b></summary>

Everything is plain-text Markdown instructions — no executables run from the bundle. The installer only copies files into skill directories. Review any `SKILL.md` before use; skills come from reputable sources (Anthropic, Sentry, CodeRabbit, Trail of Bits, matt pocock, ECC).
</details>

<details>
<summary><b>Which language/binary formats are covered?</b></summary>

Rust, C/C++, C#, Python, JavaScript/TypeScript, Go, .NET assemblies, WASM modules, Android APKs (JADX/Apktool), and native ELF/Mach-O/PE binaries (Ghidra, DWARF).
</details>

<details>
<summary><b>Does reverse engineering work without Docker?</b></summary>

The REA skill's containerized toolchain (JADX/Ghidra) needs Docker. The analysis methodology, CTF skills, and all source-level skills work anywhere.
</details>

<details>
<summary><b>How do I uninstall?</b></summary>

Delete the skill folders: `rm -rf ~/.claude/skills/* ~/.cursor/skills/*` (or the equivalent for your IDE), and `./skills` in your project.
</details>

---

##  Contributing

PRs welcome! To add a skill: create a folder with a `SKILL.md` (frontmatter: `name` + `description`), add it to `bundle/`, and register it in the manifest arrays in `bin/cli.js` / `prime-skills.sh`.

##  Ethics & Legal

Analyze only software you own or are authorized to examine. No DRM, license-check, or anti-cheat bypass. CTF skills are for sanctioned challenges only.

##  License

MIT — skill contents retain their upstream licenses (ECC: MIT · Trail of Bits: MIT · others per source repos).

---

<div align="center">

**ponytail secured — go build something.**

 Star this repo if it saved you hours of setup!

</div>
