#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config/waybar"

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

info()  { echo -e "${GREEN}[✓]${RESET} $*"; }
warn()  { echo -e "${YELLOW}[!]${RESET} $*"; }
error() { echo -e "${RED}[✗]${RESET} $*"; exit 1; }

# --- dependency check ---
check_deps() {
  local missing=()

  command -v bb   &>/dev/null || missing+=("babashka-bin")
  command -v sass &>/dev/null || missing+=("dart-sass")

  if (( ${#missing[@]} )); then
    warn "Missing packages: ${missing[*]}"
    read -rp "Install with pacman? [Y/n] " ans
    if [[ "${ans,,}" != "n" ]]; then
      sudo pacman -S --needed "${missing[@]}"
    else
      error "Cannot proceed without: ${missing[*]}"
    fi
  fi
}

# --- backup existing config ---
backup() {
  if [[ -d "$TARGET_DIR" ]]; then
    local backup="${TARGET_DIR}.bak.$(date +%s)"
    warn "Backing up existing config → $backup"
    cp -r "$TARGET_DIR" "$backup"
  fi
}

# --- install files ---
install_config() {
  mkdir -p "$TARGET_DIR/includes" "$TARGET_DIR/scripts"

  info "Installing config"
  cp "$SCRIPT_DIR/config" "$TARGET_DIR/config"

  info "Installing module includes"
  cp "$SCRIPT_DIR"/includes/*.json "$TARGET_DIR/includes/"

  info "Installing scripts"
  cp "$SCRIPT_DIR"/scripts/*.clj "$TARGET_DIR/scripts/"
  cp "$SCRIPT_DIR"/scripts/*.sh "$TARGET_DIR/scripts/"
  cp "$SCRIPT_DIR"/scripts/*.conf "$TARGET_DIR/scripts/"
  chmod +x "$TARGET_DIR"/scripts/*.clj "$TARGET_DIR"/scripts/*.sh

  info "Installing SCSS source"
  cp "$SCRIPT_DIR/style.scss" "$TARGET_DIR/style.scss"
}

# --- compile scss ---
compile_scss() {
  info "Compiling style.scss → style.css"
  sass --no-source-map "$TARGET_DIR/style.scss" "$TARGET_DIR/style.css"
}

# --- ensure cache dir for weather ---
setup_cache() {
  mkdir -p "$HOME/.cache/waybar"
  info "Ensured cache directory: ~/.cache/waybar"
}

# --- restart waybar ---
restart_waybar() {
  if pgrep -x waybar &>/dev/null; then
    info "Restarting waybar"
    pkill -x waybar || true
    sleep 0.5
  fi
  nohup waybar &>/dev/null &
  disown
  info "Waybar started (PID: $!)"
}

# --- main ---
main() {
  echo ""
  echo "  waybar installer"
  echo "  ────────────────"
  echo ""

  check_deps
  backup
  install_config
  compile_scss
  setup_cache
  restart_waybar

  echo ""
  info "Done! Config installed to $TARGET_DIR"
}

main "$@"
