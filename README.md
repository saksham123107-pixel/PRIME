# 🦄 Ultimate Skills

**One command. 99 skills. Every AI. Every IDE. Zero dependencies. Works offline.**

```bash
npx github:YOUR-USERNAME/ultimate-skills --all-agents
```

A cross-platform installer that drops **99 production-grade skills** into every AI coding harness — Claude Code, Codex CLI, Gemini CLI, Cursor, Windsurf, **Qoder**, OpenCode, and Goose — plus project-local skill dirs.

## What's inside (99 skills)

| Category | Skills |
|---|---|
| ⚡ ECC Suite (46) | api-design, backend-patterns, tdd-workflow, frontend-patterns, deep-research, security-review, mcp-server-patterns + 39 more from [affaan-m/ECC](https://github.com/affaan-m/ECC) |
| 🔬 Reverse Engineering (7) | reverse-engineer-anything (REA), reverse-engineering-agent, reverse-engineering, protocol-reverse-engineering, binary-analysis-patterns, dwarf-expert, apk-teardown-research |
| 🚩 CTF (10) | ctf-reverse, ctf-crypto, ctf-forensics, ctf-malware, ctf-osint, ctf-pwn, ctf-web, ctf-writeup, solve-challenge, ctf-web-reverse-audit |
| 🔐 Security (6) | security-scanner, code-security-audit, security-audit-owasp, red-team-adversarial-testing, li-python-sec-check, codeql |
| 👀 Project Review (8) | smart-code-review, code-review, code-review-matt, code-review-sentry, code-review-anthropics, code-review-coderabbit, codebase-design, diagnosing-bugs |
| 🧪 Testing (8) | e2e-testing-patterns, testing-patterns, afrexai-qa-testing-engine, testing-strategy, constant-time-testing, testing-handbook-generator, react-native-testing, angular-testing |
| 🌐 Web & Design (13) | web-development, clone-website, python-executor, extract-design-system, angular suite (component/di/directives/forms/http/routing/signals/ssr/tooling), autofix |

Language coverage: **Rust · C++ · C# · Python · JS/TS · Android APK · .NET · WASM · Go**

## Install

### The npx way (no install)
```bash
npx github:YOUR-USERNAME/ultimate-skills --all-agents     # every AI + IDE
npx github:YOUR-USERNAME/ultimate-skills                  # current project only
```

### From npm (if published)
```bash
npx ultimate-skills --all-agents
```

### From source
```bash
git clone https://github.com/YOUR-USERNAME/ultimate-skills
cd ultimate-skills
node bin/cli.js --all-agents        # Windows: node bin\cli.js --all-agents
```

### Windows one-click
Double-click `ultimate-skills.bat`

## Flags

| Flag | Effect |
|---|---|
| `--all-agents` / `-a` | Mirror skills into every detected AI/IDE skills dir |
| `--ponytail` | 🐴 verbose rainbow mode |
| `--skip-ecc` | Skip the optional ECC full-harness step |
| `--dest=PATH` | Custom install directory |

## Install strategy (resilient, in order)

1. **Offline bundle** (`bundle/` ships in this repo) — instant, zero network
2. `clawhub install` — official registry, retry with backoff
3. Direct GitHub tarball (`codeload.github.com`) — bypasses rate limits
4. `npx skills add` — universal last resort
5. Optional: ECC full harness via `npx ecc-universal@2.2.3 setup` (agents + commands + hooks + memory)

## Targets (`--all-agents`)

`~/.claude/skills` · `~/.codex/skills` · `~/.gemini/skills` · `~/.cursor/skills` · `~/.windsurf/skills` · `~/.qoder/skills` · `~/.opencode/skills` · `~/.goose/skills` · project-local `.qoder/skills`, `.claude/skills`, `.cursor/skills`

## How it works

Every skill is a folder with a `SKILL.md` (name + description + instructions). AI harnesses scan these dirs and auto-load matching skills when a task needs them. This installer just puts the right folders in the right places — nothing else is modified.

## Ethics

Analyze only software you own or are authorized to examine. No DRM/license/anti-cheat bypass. CTF skills are for sanctioned challenges.

## License

MIT — skill contents retain their upstream licenses (ECC: MIT, trailofbits: MIT, others per source repos).
