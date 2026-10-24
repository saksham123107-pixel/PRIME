---
name: ultimate-skills
description: "🦄 ONE-COMMAND mega-installer: 99 skills for every AI CLI and IDE — full ECC harness suite (46 skills), reverse engineering (APK/Android, Rust, C++, C#, Python, JS, .NET, WASM, Ghidra/JADX), CTF suite (crypto/forensics/malware/osint/pwn/web/writeup), security audit (OWASP, red team, scanners, CodeQL), project review (Matt Pocock, Sentry, Anthropic, CodeRabbit), testing (E2E, patterns, QA, react-native, angular), web development, design-system extraction, and website cloning. Installs offline-first from a bundled zero-network pack, then falls back to clawhub → GitHub → npx. Distributes to Claude Code, Codex, Gemini CLI, Cursor, Windsurf, OpenCode, Goose + project-local dirs. Use when the user says 'install all skills', 'ultimate skills', or wants the full toolkit with a single command. 🐴 ponytail included."
license: MIT
user-invocable: true
metadata:
  mascot: "🦄🐴 ponytail"
  version: "2.0.0"
---

# 🦄 Ultimate Skills v2 🐴

Single command (`npx ultimate-skills`). 99 skills. Every AI. Every IDE. Works offline.

## Quick start

**Anywhere with Node (the npx way — recommended):**
```bash
npx ultimate-skills --all-agents        # once published to npm
# or from this folder, no publish needed:
npx ./ultimate-skills --all-agents
# or install the shipped tgz globally:
npm i -g ultimate-skills-1.0.0.tgz && ultimate-skills --all-agents
```
Flags: `--all-agents` (every AI/IDE) · `--ponytail` (🐴 verbose) · `--skip-ecc` · `--dest=PATH`

**Windows (CMD / double-click):**
```bat
ultimate-skills.bat                    :: → .\skills (offline bundle, instant)
ultimate-skills.bat -AllAgents         :: also mirrors into every AI/IDE skills dir
ultimate-skills.bat -AllAgents -Ponytail
```
Or in PowerShell: `powershell -ExecutionPolicy Bypass -File ultimate-skills.ps1 -AllAgents`

**Linux / macOS / Git Bash / WSL:**
```bash
bash ultimate-skills.sh                    # → ./skills (offline bundle, instant)
bash ultimate-skills.sh --all-agents       # also mirrors into every AI/IDE skills dir
bash ultimate-skills.sh --ponytail         # 🐴 verbose rainbow mode
SKIP_ECC=1 bash ultimate-skills.sh         # skip the optional ECC harness step
ULTIMATE_SKILLS_DIR=~/.claude/skills bash ultimate-skills.sh
```

## What's inside (99 skills via 54 manifest entries)

| Category | Skills |
|---|---|
| ⚡ ECC Suite (46) | api-design, backend-patterns, article-writing, agent tooling + 42 more from github.com/affaan-m/ECC |
| 🔬 Reverse Engineering (7) | reverse-engineer-anything (REA), reverse-engineering-agent, reverse-engineering, protocol-reverse-engineering, binary-analysis-patterns, dwarf-expert, apk-teardown-research |
| 🚩 CTF (10) | ctf-reverse, ctf-crypto, ctf-forensics, ctf-malware, ctf-osint, ctf-pwn, ctf-web, ctf-writeup, solve-challenge, ctf-web-reverse-audit |
| 🔐 Security (5) | security-scanner, code-security-audit, security-audit-owasp, red-team-adversarial-testing, li-python-sec-check, codeql |
| 👀 Project Review (7) | smart-code-review, code-review, code-review-matt (778k installs), code-review-sentry, code-review-anthropics, code-review-coderabbit, diagnosing-bugs + codebase-design |
| 🧪 Testing (8) | e2e-testing-patterns, testing-patterns, afrexai-qa-testing-engine, testing-strategy (Anthropic), constant-time-testing, testing-handbook-generator, react-native-testing, angular-testing |
| 🌐 Web & Design (13) | web-development, clone-website, python-executor, extract-design-system (130k installs), angular suite (component/di/directives/forms/http/routing/signals/ssr/tooling), autofix |

Covers: **Rust · C++ · C# · Python · JS/TS · Android APK · .NET · WASM · Go** binaries and source.

## Targets with --all-agents

`~/.claude/skills` (Claude Code) · `~/.codex/skills` (Codex) · `~/.gemini/skills` (Gemini CLI) · `~/.cursor/skills` (Cursor) · `~/.windsurf/skills` (Windsurf) · `~/.qoder/skills` (Qoder) · `~/.opencode/skills` (OpenCode) · `~/.goose/skills` (Goose) · project-local `.qoder/skills` + `.claude/skills` + `.cursor/skills`.

## Install strategy (resilient, in order)

1. **Offline bundle** (`bundle/` ships inside this package) — instant, zero network
2. `clawhub install` — official registry (with retry/backoff for pure entries)
3. Direct GitHub tarball (`codeload.github.com`) — bypasses rate limits and broken proxies
4. `npx skills add` — universal last resort
5. **ECC full harness** (optional, best-effort): `npx ecc-universal@2.2.3 setup` adds agents/commands/hooks/memory on top of the bundled ECC skills

## Ethics

Analyze only software you own or are authorized to examine. No DRM/license/anti-cheat bypass.
