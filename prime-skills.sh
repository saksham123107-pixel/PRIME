#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
#  PRIME SKILLS — ONE COMMAND. EVERY SKILL. EVERY AI. EVERY IDE.
#  Reverse Engineering | Security | Project Review | Testing | Web | Clone
#  Android/Rust/C++/C#/Python/JS | and the PONYTAIL to tie it together.
#
#  Usage:
#    bash prime-skills.sh                 # install everything (local ./skills)
#    bash prime-skills.sh --ponytail      # verbose + rainbow flair
#    bash prime-skills.sh --all-agents    # also copy into every AI/IDE dir
#    PRIME_SKILLS_DIR=/path bash prime-skills.sh
# ═══════════════════════════════════════════════════════════════════════════
set -u
PONYTAIL=0; ALL_AGENTS=0
for a in "$@"; do case "$a" in --ponytail) PONYTAIL=1;; --all-agents) ALL_AGENTS=1;; esac; done
DEST="${PRIME_SKILLS_DIR:-$PWD/skills}"; mkdir -p "$DEST"

# --- ponytail mascot -----------------------------------------------------
pony() { [ "$PONYTAIL" -eq 1 ] || return 0; cat <<'EOF'
        \_\
      (( \ \,   PONYTAIL MODE ENGAGED
       \\ \.\\  installing PRIME skills...
        \`\  (\)
         `-->
EOF
}
rainbow() { [ "$PONYTAIL" -eq 1 ] || { echo "$*"; return; }; local c=36; echo -e "\033[${c}m$*\033[0m"; }

# offline bundle ships next to this script (zero-network install path)
BUNDLE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)/bundle"
[ -d "$BUNDLE" ] || BUNDLE=""

# offline bundle ships next to this script (zero-network install path)
BUNDLE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)/bundle"
[ -d "$BUNDLE" ] || BUNDLE=""

cat <<'BAN'
   ┌──────────────────────────────────────────────────────────┐
   │  P R I M E   S K I L L S   I N S T A L L E R  │
   │  one command · every skill · every AI · every IDE         │
   └──────────────────────────────────────────────────────────┘
BAN
pony

# --- skill manifest: "clawhub-name|github-tarball-fallback(optional)|subpath(optional)
MANIFEST=(
  "reverse-engineer-anything|"
  "reverse-engineering-agent|"
  "reverse-engineering|"
  "clone-website|"
  "ctf-reverse|"
  "ctf-web-reverse-audit|"
  "apk-teardown-research|"
  "protocol-reverse-engineering|https://codeload.github.com/wshobson/agents/tar.gz/refs/heads/main|agents-main/plugins/reverse-engineering/skills/protocol-reverse-engineering"
  "binary-analysis-patterns|https://codeload.github.com/wshobson/agents/tar.gz/refs/heads/main|agents-main/plugins/reverse-engineering/skills/binary-analysis-patterns"
  "dwarf-expert|https://codeload.github.com/trailofbits/skills/tar.gz/refs/heads/main|skills-main/plugins/dwarf-expert/skills/dwarf-expert"
  "security-scanner|"
  "code-security-audit|"
  "security-audit-owasp|"
  "3mper0rr-red-team-adversarial-testing|"
  "li-python-sec-check|"
  "smart-code-review|"
  "code-review|"
  "e2e-testing-patterns|"
  "testing-patterns|"
  "afrexai-qa-testing-engine|"
  "web-development|"
  "python-executor|"
  # ---- POPULAR TIER (highest-installed skills on skills.sh) ----
  "code-review-matt|https://codeload.github.com/mattpocock/skills/tar.gz/refs/heads/main|skills-main/skills/engineering/code-review"
  "codebase-design|https://codeload.github.com/mattpocock/skills/tar.gz/refs/heads/main|skills-main/skills/engineering/codebase-design"
  "diagnosing-bugs|https://codeload.github.com/mattpocock/skills/tar.gz/refs/heads/main|skills-main/skills/engineering/diagnosing-bugs"
  "extract-design-system|https://codeload.github.com/arvindrk/extract-design-system/tar.gz/refs/heads/main|extract-design-system-main/skills/extract-design-system"
  "code-review-sentry|https://codeload.github.com/getsentry/skills/tar.gz/refs/heads/main|skills-main/skills/code-review"
  "code-review-anthropics|https://codeload.github.com/anthropics/knowledge-work-plugins/tar.gz/refs/heads/main|knowledge-work-plugins-main/engineering/skills/code-review"
  "testing-strategy|https://codeload.github.com/anthropics/knowledge-work-plugins/tar.gz/refs/heads/main|knowledge-work-plugins-main/engineering/skills/testing-strategy"
  "code-review-coderabbit|https://codeload.github.com/coderabbitai/skills/tar.gz/refs/heads/main|skills-main/skills/code-review"
  "autofix|https://codeload.github.com/coderabbitai/skills/tar.gz/refs/heads/main|skills-main/skills/autofix"
  "react-native-testing|https://codeload.github.com/callstack/react-native-testing-library/tar.gz/refs/heads/main|react-native-testing-library-main/skills/react-native-testing"
  "codeql|https://codeload.github.com/trailofbits/skills/tar.gz/refs/heads/main|skills-main/plugins/static-analysis/skills/codeql"
  "constant-time-testing|https://codeload.github.com/trailofbits/skills/tar.gz/refs/heads/main|skills-main/plugins/testing-handbook-skills/skills/constant-time-testing"
  "testing-handbook-generator|https://codeload.github.com/trailofbits/skills/tar.gz/refs/heads/main|skills-main/plugins/testing-handbook-skills/skills/testing-handbook-generator"
  "angular-component|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-component"
  "angular-di|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-di"
  "angular-directives|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-directives"
  "angular-forms|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-forms"
  "angular-http|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-http"
  "angular-routing|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-routing"
  "angular-signals|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-signals"
  "angular-ssr|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-ssr"
  "angular-testing|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-testing"
  "angular-tooling|https://codeload.github.com/analogjs/angular-skills/tar.gz/refs/heads/main|angular-skills-main/skills/angular-tooling"
  "ctf-crypto|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-crypto"
  "ctf-forensics|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-forensics"
  "ctf-malware|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-malware"
  "ctf-osint|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-osint"
  "ctf-pwn|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-pwn"
  "ctf-web|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-web"
  "ctf-writeup|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/ctf-writeup"
  "solve-challenge|https://codeload.github.com/ljagiello/ctf-skills/tar.gz/refs/heads/main|ctf-skills-main/solve-challenge"
  # ---- ECC (github.com/affaan-m/ECC) — 46 skills in one shot ----
  "ecc-suite|https://codeload.github.com/affaan-m/ECC/tar.gz/refs/heads/main|ECC-main/.agents/skills"
)
rainbow "manifest: ${#MANIFEST[@]} skills loaded"

have() { command -v "$1" >/dev/null 2>&1; }
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
OK=0; FAIL=(); GH_TGZ=""

install_gh() { # url subpath [flatten] -> copies dir into $DEST
  local url="$1" sub="$2" flat="${3:-}" dir
  [ -n "$GH_TGZ" ] || { GH_TGZ="$TMP/$(basename "${url%%\?*}").tgz"; curl -sL --max-time 120 -o "$GH_TGZ" "$url"; }
  dir=$(tar tzf "$GH_TGZ" 2>/dev/null | rg -m1 "^${sub}/$" || echo "")
  [ -n "$dir" ] || { tar tzf "$GH_TGZ" 2>/dev/null | head -1 >/dev/null || return 1; dir="$sub"; }
  tar xzf "$GH_TGZ" -C "$TMP" "$dir" 2>/dev/null || return 1
  if [ "$flat" = "flatten" ]; then mkdir -p "$DEST"; cp -r "$TMP/$dir"/. "$DEST/"; else cp -r "$TMP/$dir" "$DEST/" 2>/dev/null || cp -r "$TMP/${sub}" "$DEST/" || return 1; fi
  return 0
}

i=0
for row in "${MANIFEST[@]}"; do
  i=$((i+1)); name="${row%%|*}"; rest="${row#*|}"; gh="${rest%%|*}"; sub="${rest#*|}"
  [ "$sub" = "$gh" ] && sub=""
  printf "[%02d/%02d] %-42s" "$i" "${#MANIFEST[@]}" "$name"
  if [ -n "$BUNDLE" ] && [ -d "$BUNDLE/$name" ]; then
    if [ -f "$BUNDLE/$name/SKILL.md" ]; then
      cp -r "$BUNDLE/$name" "$DEST/" && echo " bundle(offline)"; OK=$((OK+1)); continue
    elif ls "$BUNDLE/$name"/*/SKILL.md >/dev/null 2>&1; then # suite dir (e.g. ecc-suite)
      mkdir -p "$DEST"; cp -r "$BUNDLE/$name"/. "$DEST/" && echo " bundle(offline suite)"; OK=$((OK+1)); continue
    fi
  fi
  if [ -z "$gh" ]; then # pure clawhub entries: retry with backoff
    for attempt in 1 2 3; do
      if have clawhub && clawhub install "$name" >/dev/null 2>&1 && [ -e "$DEST/$name/SKILL.md" ]; then
        echo " clawhub"; OK=$((OK+1)); break
      fi
      [ "$attempt" -lt 3 ] && sleep 20
    done
    [ -e "$DEST/$name/SKILL.md" ] && continue
  else # github-backed entries: single clawhub shot, then fast fallback
    if have clawhub && clawhub install "$name" >/dev/null 2>&1 && [ -e "$DEST/$name/SKILL.md" ]; then
      echo " clawhub"; OK=$((OK+1)); continue
    fi
  fi
  if [ -n "$gh" ] && install_gh "$gh" "$sub" "$([ "$name" = ecc-suite ] && echo flatten)"; then echo " github"; OK=$((OK+1)); continue
  elif [ -n "$gh" ] && [ "$name" != ecc-suite ] && install_gh "$gh" "$(basename "$sub")"; then echo " github"; OK=$((OK+1)); continue; fi
  # last resort: npx skills (slow but universal)
  if have npx; then
    owner="${gh#*github.com/}"; owner="${owner%/tar.gz*}"; owner="${owner%/archive*}"
    if [ -n "$owner" ] && timeout 90 npx -y skills add "https://github.com/$owner" --skill "$(basename "${sub:-$name}")" >/dev/null 2>&1; then
      echo " npx"; OK=$((OK+1)); continue
    fi
  fi
  echo " skipped"; FAIL+=("$name")
done

# --- ECC full harness (optional, best-effort) -------------------------------
if [ "$SKIP_ECC" != 1 ] && have npx; then
  echo; rainbow "ECC full harness (agents+commands+hooks) — best effort..."
  timeout 150 npx -y ecc-universal@2.2.3 setup >/dev/null 2>&1 \
    && echo "   ECC harness installed via ecc-universal" \
    || echo "  ℹ  ECC skills bundled ; full harness later: npx ecc-universal@2.2.3 setup"
fi

# --- distribute to every AI / IDE ------------------------------------------
AGENTS=(
  "$HOME/.claude/skills|Claude Code"
  "$HOME/.codex/skills|Codex CLI"
  "$HOME/.gemini/skills|Gemini CLI"
  "$HOME/.cursor/skills|Cursor"
  "$HOME/.windsurf/skills|Windsurf"
  "$HOME/.qoder/skills|Qoder"
  "$HOME/.opencode/skills|OpenCode"
  "$HOME/.goose/skills|Goose"
  "$HOME/.config/opencode/skills|OpenCode(alt)"
  "$PWD/.qoder/skills|Qoder(project)"
  "$PWD/.claude/skills|Claude(project)"
  "$PWD/.cursor/skills|Cursor(project)"
)
if [ "$ALL_AGENTS" -eq 1 ]; then
  echo; rainbow "distributing to every AI + IDE..."
  for a in "${AGENTS[@]}"; do d="${a%%|*}"; n="${a#*|}"
    mkdir -p "$d" && cp -rf "$DEST"/. "$d"/ && echo "   $n -> $d"
  done
else
  echo; echo "ℹ  add --all-agents to mirror skills into Claude/Codex/Gemini/Cursor/Windsurf/OpenCode/Goose"
fi

echo
echo "════════════════════════════════════════"
[ -n "$BUNDLE" ] && echo "offline bundle detected — zero network needed"
echo "PRIME SKILLS: $OK/${#MANIFEST[@]} installed -> $DEST"
[ "${#FAIL[@]}" -gt 0 ] && echo "     retry later: ${FAIL[*]}"
echo "ponytail secured. go build something."
echo "════════════════════════════════════════"
