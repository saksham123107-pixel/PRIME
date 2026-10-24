---
name: prime-skills
description: "PRIME SKILLS — one command installs 99 elite skills into every AI CLI & IDE (Claude Code, Codex, Gemini CLI, Cursor, Windsurf, Qoder, OpenCode, Goose): full ECC harness suite (46 skills), reverse engineering (APK/Android, Rust, C++, C#, Python, JS, .NET, WASM, Ghidra/JADX), CTF suite (crypto/forensics/malware/osint/pwn/web/writeup), security audit (OWASP, red team, CodeQL), project review (Matt Pocock, Sentry, Anthropic, CodeRabbit), testing (E2E, patterns, QA, react-native, angular), web development, design-system extraction, and website cloning. Offline-first from a bundled zero-network pack, then clawhub -> GitHub -> npx fallbacks. Trigger words: 'install all skills', 'prime skills', 'ultimate skills', full toolkit, single command. ponytail included."
license: MIT
user-invocable: true
metadata:
  mascot: "ponytail"
  version: "2.0.0"
  repository: "https://github.com/saksham123107-pixel/PRIME"
---

# PRIME SKILLS

One command (`npx prime-skills`). 99 skills. Every AI. Every IDE. Works offline.

## Quick start

**Anywhere with Node (the npx way — recommended):**
```bash
npx prime-skills --all-agents           # once published to npm
# or from this repo, no publish needed:
npx github:saksham123107-pixel/PRIME --all-agents
# or from a local clone:
npx . --all-agents
```
Flags: `--all-agents` (every AI/IDE) · `--ponytail` (verbose) · `--skip-ecc` · `--dest=PATH`

**Windows (CMD / double-click):**
```bat
prime-skills.bat                        :: -> .\skills (offline bundle, instant)
prime-skills.bat --all-agents           :: also mirrors into every AI/IDE skills dir
prime-skills.bat --all-agents --ponytail
```
Or in PowerShell: `powershell -ExecutionPolicy Bypass -File prime-skills.ps1 --all-agents`

**Linux / macOS / Git Bash / WSL:**
```bash
bash prime-skills.sh                    # -> ./skills (offline bundle, instant)
bash prime-skills.sh --all-agents       # also mirrors into every AI/IDE skills dir
bash prime-skills.sh --ponytail         # verbose rainbow mode
SKIP_ECC=1 bash prime-skills.sh         # skip the optional ECC harness step
PRIME_SKILLS_DIR=~/.claude/skills bash prime-skills.sh
```

## What's inside (99 skills via 54 manifest entries)

| Category | Skills |
|---|---|
|  ECC Suite (46) | api-design, backend-patterns, tdd-workflow, frontend-patterns, deep-research, security-review, mcp-server-patterns + 39 more from github.com/affaan-m/ECC |
|  Reverse Engineering (7) | reverse-engineer-anything (REA), reverse-engineering-agent, reverse-engineering, protocol-reverse-engineering, binary-analysis-patterns, dwarf-expert, apk-teardown-research |
|  CTF (10) | ctf-reverse, ctf-crypto, ctf-forensics, ctf-malware, ctf-osint, ctf-pwn, ctf-web, ctf-writeup, solve-challenge, ctf-web-reverse-audit |
|  Security (6) | security-scanner, code-security-audit, security-audit-owasp, red-team-adversarial-testing, li-python-sec-check, codeql |
|  Project Review (8) | smart-code-review, code-review, code-review-matt (778k installs), code-review-sentry, code-review-anthropics, code-review-coderabbit, codebase-design, diagnosing-bugs |
|  Testing (8) | e2e-testing-patterns, testing-patterns, afrexai-qa-testing-engine, testing-strategy (Anthropic), constant-time-testing, testing-handbook-generator, react-native-testing, angular-testing |
|  Web & Design (13) | web-development, clone-website, python-executor, extract-design-system (130k installs), angular suite (component/di/directives/forms/http/routing/signals/ssr/tooling), autofix |

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
