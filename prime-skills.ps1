# ═══════════════════════════════════════════════════════════════════════════
#  PRIME SKILLS for WINDOWS — ONE COMMAND. EVERY SKILL. EVERY AI. EVERY IDE.
#  Usage:
#    powershell -ExecutionPolicy Bypass -File prime-skills.ps1
#    powershell -ExecutionPolicy Bypass -File prime-skills.ps1 -AllAgents
#    powershell -ExecutionPolicy Bypass -File prime-skills.ps1 -Ponytail
# ═══════════════════════════════════════════════════════════════════════════
param(
  [switch]$AllAgents,
  [switch]$Ponytail,
  [string]$Dest = ""
)
$ErrorActionPreference = "SilentlyContinue"
[Console]::OutputEncoding = [Text.Encoding]::UTF8

$Root   = Split-Path -Parent $MyInvocation.MyCommand.Path
$Bundle = Join-Path $Root "bundle"
if (-not $Dest) { $Dest = Join-Path (Get-Location) "skills" }

Write-Host ""
Write-Host "   ==========================================================" -ForegroundColor Magenta
Write-Host "    P R I M E   S K I L L S   I N S T A L L E R  (Win)" -ForegroundColor Magenta
Write-Host "    one command - every skill - every AI - every IDE" -ForegroundColor Magenta
Write-Host "   ==========================================================" -ForegroundColor Magenta
if ($Ponytail) {
Write-Host @"

        \_\
      (( \ \,   PONYTAIL MODE ENGAGED
       \\ \.\\  installing PRIME skills...
        ``  (\)
         `-->
"@ -ForegroundColor Yellow
}

if (-not (Test-Path $Bundle)) {
  Write-Host " [!] bundle/ not found next to script - offline install unavailable" -ForegroundColor Red
  Write-Host "     re-download the full prime-skills folder (with bundle)" -ForegroundColor Red
  exit 1
}

# --- 1. offline bundle install (zero network) --------------------------------
New-Item -ItemType Directory -Force -Path $Dest | Out-Null
$items = Get-ChildItem -Path $Bundle -Directory
$n = 0
foreach ($s in $items) {
  $n++
  Write-Host ("  [{0:d2}/{1:d2}] {2,-42}" -f $n, $items.Count, $s.Name) -NoNewline
  $target = Join-Path $Dest $s.Name
  if ($s.Name -eq "ecc-suite") {
    Get-ChildItem -Path $s.FullName -Directory | ForEach-Object {
      Copy-Item $_.FullName -Destination $Dest -Recurse -Force
    }
    Write-Host "OK bundle(offline suite)" -ForegroundColor Green
  } else {
    Copy-Item $s.FullName -Destination $Dest -Recurse -Force
    Write-Host "OK bundle(offline)" -ForegroundColor Green
  }
}

# --- 2. distribute to every AI / IDE -----------------------------------------
$agents = [ordered]@{
  "Claude Code"    = "$env:USERPROFILE\.claude\skills"
  "Codex CLI"      = "$env:USERPROFILE\.codex\skills"
  "Universal"      = "$env:USERPROFILE\.agents\skills"
  "Gemini CLI"     = "$env:USERPROFILE\.gemini\skills"
  "Cursor"         = "$env:USERPROFILE\.cursor\skills"
  "Windsurf"       = "$env:USERPROFILE\.windsurf\skills"
  "Qoder"          = "$env:USERPROFILE\.qoder\skills"
  "Qoder(project)" = (Join-Path (Get-Location) ".qoder\skills")
  "OpenCode"       = "$env:USERPROFILE\.config\opencode\skill"
  "OpenCode(alt)"  = "$env:USERPROFILE\.opencode\skills"
  "Factory Droid"  = "$env:USERPROFILE\.factory\skills"
  "GitHub Copilot" = "$env:USERPROFILE\.copilot\skills"
  "Goose"          = "$env:USERPROFILE\.goose\skills"
  "Claude(project)"= (Join-Path (Get-Location) ".claude\skills")
  "Cursor(project)"= (Join-Path (Get-Location) ".cursor\skills")
}
if ($AllAgents) {
  Write-Host ""
  Write-Host " PONYTAIL distributing to every AI + IDE..." -ForegroundColor Yellow
  foreach ($k in $agents.Keys) {
    $d = $agents[$k]
    New-Item -ItemType Directory -Force -Path $d | Out-Null
    Copy-Item (Join-Path $Dest "*") -Destination $d -Recurse -Force
    Write-Host ("   OK {0,-16} -> {1}" -f $k, $d) -ForegroundColor Green
  }
} else {
  Write-Host ""
  Write-Host " [i] add -AllAgents to mirror skills into Claude/Codex/Gemini/Cursor/Windsurf/OpenCode/Goose" -ForegroundColor Cyan
}

# --- 3. summary ----------------------------------------------------------------
$count = (Get-ChildItem -Path $Dest -Directory | Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") }).Count
Write-Host ""
Write-Host " ========================================================" -ForegroundColor Magenta
Write-Host "  PRIME SKILLS: $count skills installed -> $Dest" -ForegroundColor Magenta
Write-Host "  ponytail secured. go build something." -ForegroundColor Yellow
Write-Host " ========================================================" -ForegroundColor Magenta
