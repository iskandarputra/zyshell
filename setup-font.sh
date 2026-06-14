#!/bin/bash
# zy font setup
#
# Installs MesloLGL Nerd Font (the wide variant — better readability for the
# pill icons in zy's prompt) and configures every detected terminal + VS Code
# to use `MesloLGL Nerd Font Bold 13`.
#
# Backups: every modified config file gets a `<file>.zy.bak` sibling on
# first run, so users can revert if anything looks off.
#
# Idempotent: safe to run multiple times; no-ops when the right config is
# already in place.

set -e

FONT_FAMILY="MesloLGL Nerd Font"
FONT_WEIGHT="Bold"
FONT_SIZE=12
FONT_PACK="Meslo"          # Nerd-Fonts repo includes S/M/L in one tarball
FONT_PACK_VERSION="v3.3.0"
FONT_DIR="$HOME/.local/share/fonts"

echo -e "\n\033[1;36m╭─────────────────────────────────────────────────────────╮\033[0m"
echo -e "\033[1;36m│\033[0m  \033[1;35mzy font setup\033[0m  \033[2m→\033[0m \033[1;37m${FONT_FAMILY} ${FONT_WEIGHT} ${FONT_SIZE}\033[0m"
echo -e "\033[1;36m╰─────────────────────────────────────────────────────────╯\033[0m\n"

# ── Step 1: install the font ──────────────────────────────────────────
if fc-list 2>/dev/null | grep -qi "MesloLGL.*Nerd"; then
    echo -e "\033[32m✔\033[0m ${FONT_FAMILY} already installed."
else
    echo -e "\033[33m→\033[0m Installing ${FONT_FAMILY}..."
    mkdir -p "$FONT_DIR"
    cd "$FONT_DIR"
    if ! curl -fsSL --retry 2 -o Meslo.zip \
            "https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_PACK_VERSION}/${FONT_PACK}.zip"; then
        echo -e "\033[31m✘\033[0m Font download failed. Skipping config — install manually from"
        echo -e "    \033[2mhttps://github.com/ryanoasis/nerd-fonts/releases\033[0m"
        exit 1
    fi
    unzip -qo Meslo.zip -d Meslo 2>/dev/null || unzip -qo Meslo.zip
    rm -f Meslo.zip
    fc-cache -f >/dev/null 2>&1 || true
    cd - >/dev/null
    echo -e "\033[32m✔\033[0m Font installed."
fi
echo ""

# ── Backup helper ─────────────────────────────────────────────────────
backup() {
    local f="$1"
    [ -f "$f" ] && [ ! -f "$f.zy.bak" ] && cp "$f" "$f.zy.bak"
}
note() { echo -e "  \033[32m✔\033[0m \033[2m$1\033[0m"; }
skip() { echo -e "  \033[2m·\033[0m \033[2m$1\033[0m"; }

# ── GNOME Terminal ────────────────────────────────────────────────────
configure_gnome_terminal() {
    command -v gsettings >/dev/null 2>&1 || return 1
    local profile
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default 2>/dev/null | tr -d "'") || return 1
    [ -n "$profile" ] || return 1
    local key="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/"
    gsettings set "$key" use-system-font false
    gsettings set "$key" font "${FONT_FAMILY} ${FONT_WEIGHT} ${FONT_SIZE}"
    note "GNOME Terminal"
}

# ── Konsole (KDE) ─────────────────────────────────────────────────────
configure_konsole() {
    local d="$HOME/.local/share/konsole"
    command -v konsole >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local p
    p=$(ls "$d"/*.profile 2>/dev/null | head -1)
    if [ -z "$p" ]; then
        p="$d/zy.profile"
        cat > "$p" <<PROFILE
[Appearance]
Font=${FONT_FAMILY},${FONT_SIZE},-1,5,75,0,0,0,0,0

[General]
Name=zy
Parent=FALLBACK/
PROFILE
    else
        backup "$p"
        if grep -q "^Font=" "$p"; then
            sed -i "s|^Font=.*|Font=${FONT_FAMILY},${FONT_SIZE},-1,5,75,0,0,0,0,0|" "$p"
        else
            printf "[Appearance]\nFont=%s,%d,-1,5,75,0,0,0,0,0\n" "$FONT_FAMILY" "$FONT_SIZE" >> "$p"
        fi
    fi
    note "Konsole"
}

# ── Alacritty ─────────────────────────────────────────────────────────
configure_alacritty() {
    local d="$HOME/.config/alacritty"
    command -v alacritty >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local f="$d/alacritty.toml"
    backup "$f"
    cat > "$f" <<TOML
# zy: managed by setup-font.sh — edit freely; \`.zy.bak\` is the original.
[font]
size = ${FONT_SIZE}.0

[font.normal]
family = "${FONT_FAMILY}"
style  = "${FONT_WEIGHT}"

[font.bold]
family = "${FONT_FAMILY}"
style  = "${FONT_WEIGHT}"
TOML
    note "Alacritty"
}

# ── kitty ─────────────────────────────────────────────────────────────
configure_kitty() {
    local d="$HOME/.config/kitty"
    command -v kitty >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local f="$d/kitty.conf"
    backup "$f"
    # Rewrite font_family / bold_font / font_size lines (or append).
    if [ -f "$f" ]; then
        sed -i '/^font_family\|^bold_font\|^font_size/d' "$f"
    fi
    cat >> "$f" <<KITTY
# zy: managed by setup-font.sh
font_family ${FONT_FAMILY} ${FONT_WEIGHT}
bold_font   ${FONT_FAMILY} ${FONT_WEIGHT}
font_size   ${FONT_SIZE}.0
KITTY
    note "kitty"
}

# ── WezTerm ───────────────────────────────────────────────────────────
configure_wezterm() {
    local d="$HOME/.config/wezterm"
    command -v wezterm >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local f="$d/wezterm.lua"
    backup "$f"
    if [ -f "$f" ] && grep -q 'zy: managed' "$f"; then
        # Already ours — overwrite cleanly.
        :
    elif [ -f "$f" ]; then
        # User has their own config — write a sibling file they can `require`.
        f="$d/zy-font.lua"
        echo "-- Add to your wezterm.lua: require('zy-font').apply(config)" > "$f.note"
    fi
    cat > "$f" <<LUA
-- zy: managed by setup-font.sh
local wezterm = require 'wezterm'
local config  = wezterm.config_builder and wezterm.config_builder() or {}
config.font            = wezterm.font('${FONT_FAMILY}', { weight = '${FONT_WEIGHT}' })
config.font_size       = ${FONT_SIZE}.0
config.cell_width      = 1.0
return config
LUA
    note "WezTerm"
}

# ── foot ──────────────────────────────────────────────────────────────
configure_foot() {
    local d="$HOME/.config/foot"
    command -v foot >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local f="$d/foot.ini"
    backup "$f"
    if [ -f "$f" ]; then
        sed -i '/^font=/d' "$f"
    fi
    echo "# zy: managed by setup-font.sh" >> "$f"
    echo "font=${FONT_FAMILY}:weight=${FONT_WEIGHT,,}:size=${FONT_SIZE}" >> "$f"
    note "foot"
}

# ── XFCE Terminal ─────────────────────────────────────────────────────
configure_xfce_terminal() {
    local d="$HOME/.config/xfce4/terminal"
    command -v xfce4-terminal >/dev/null 2>&1 || [ -d "$d" ] || return 1
    mkdir -p "$d"
    local f="$d/terminalrc"
    backup "$f"
    if [ -f "$f" ]; then
        sed -i '/^FontName=/d' "$f"
    else
        echo "[Configuration]" > "$f"
    fi
    echo "FontName=${FONT_FAMILY} ${FONT_WEIGHT} ${FONT_SIZE}" >> "$f"
    note "XFCE Terminal"
}

# ── Tilix ─────────────────────────────────────────────────────────────
configure_tilix() {
    command -v tilix >/dev/null 2>&1 && command -v dconf >/dev/null 2>&1 || return 1
    local p
    p=$(dconf list /com/gexperts/Tilix/profiles/ 2>/dev/null | head -1)
    [ -n "$p" ] || return 1
    dconf write "/com/gexperts/Tilix/profiles/${p}use-system-font" false
    dconf write "/com/gexperts/Tilix/profiles/${p}font" "'${FONT_FAMILY} ${FONT_WEIGHT} ${FONT_SIZE}'"
    note "Tilix"
}

# ── VS Code (integrated terminal + editor) ────────────────────────────
configure_vscode() {
    local cfg_dirs=(
        "$HOME/.config/Code/User"             # Linux
        "$HOME/.config/Code - Insiders/User"  # VS Code Insiders
        "$HOME/.config/VSCodium/User"         # VSCodium
        "$HOME/Library/Application Support/Code/User"  # macOS
    )
    local touched=0
    for d in "${cfg_dirs[@]}"; do
        [ -d "$d" ] || continue
        local f="$d/settings.json"
        backup "$f"
        # Use python (likely available) for safe JSON merge; fall back to a
        # blunt regex replace if python isn't there.
        if command -v python3 >/dev/null 2>&1; then
            python3 - "$f" "$FONT_FAMILY" "$FONT_WEIGHT" "$FONT_SIZE" <<'PY'
import json, re, sys, os
path, family, weight, size = sys.argv[1:]
data = {}
if os.path.exists(path):
    try:
        with open(path) as fp:
            txt = fp.read()
        # Strip // line comments and /* block comments — VS Code accepts JSONC.
        txt = re.sub(r'//[^\n]*', '', txt)
        txt = re.sub(r'/\*.*?\*/', '', txt, flags=re.S)
        txt = re.sub(r',\s*([}\]])', r'\1', txt)  # trailing commas
        data = json.loads(txt) if txt.strip() else {}
    except Exception:
        data = {}
data["terminal.integrated.fontFamily"] = family
data["terminal.integrated.fontSize"]   = int(size)
data["terminal.integrated.fontWeight"] = weight.lower()
data["terminal.integrated.fontWeightBold"] = weight.lower()
data["editor.fontFamily"]              = family
data["editor.fontSize"]                = int(size)
# Use zy as the integrated-terminal shell if /usr/bin/zy exists.
if os.path.exists("/usr/bin/zy"):
    data["terminal.integrated.defaultProfile.linux"] = "zy"
    profiles = data.get("terminal.integrated.profiles.linux", {})
    profiles["zy"] = {"path": "/usr/bin/zy"}
    data["terminal.integrated.profiles.linux"] = profiles
with open(path, "w") as fp:
    json.dump(data, fp, indent=2)
    fp.write("\n")
PY
            touched=1
            note "VS Code  ($(basename "$(dirname "$d")"))"
        else
            # No python — append a hint instead of trying to surgically edit JSON.
            skip "VS Code at $d (python3 missing; edit settings.json manually)"
        fi
    done
    [ "$touched" = "1" ]
}

# ── Run all detectors ─────────────────────────────────────────────────
echo -e "\033[33m→\033[0m Configuring detected terminals + editors..."
ANY=0
configure_gnome_terminal && ANY=1 || true
configure_konsole       && ANY=1 || true
configure_alacritty     && ANY=1 || true
configure_kitty         && ANY=1 || true
configure_wezterm       && ANY=1 || true
configure_foot          && ANY=1 || true
configure_xfce_terminal && ANY=1 || true
configure_tilix         && ANY=1 || true
configure_vscode        && ANY=1 || true

if [ "$ANY" = "0" ]; then
    echo -e "\n\033[33m⚠\033[0m  No supported terminal or editor detected."
    echo -e "   Configure manually:  Font family = \033[1m${FONT_FAMILY}\033[0m, weight = \033[1m${FONT_WEIGHT}\033[0m, size = \033[1m${FONT_SIZE}\033[0m"
fi

echo ""
echo -e "\033[1;36m╭─────────────────────────────────────────────────────────╮\033[0m"
echo -e "\033[1;36m│\033[0m  \033[1;32m✔ Done.\033[0m \033[2mRestart your terminal for the font to take effect.\033[0m  \033[1;36m│\033[0m"
echo -e "\033[1;36m╰─────────────────────────────────────────────────────────╯\033[0m"
echo -e "\n  \033[2mPrompt test (Nerd Font glyphs):\033[0m  \033[35m\033[0m \033[36m\033[0m \033[32m\033[0m \033[33m\033[0m \033[31m\033[0m"
echo ""
