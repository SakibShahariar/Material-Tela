#!/usr/bin/env bash
set -euo pipefail
theme="$(cd "$(dirname "$0")" && pwd)"
target="$HOME/.icons/Material-Tela"

if [ -L "$HOME/.icons" ]; then
  echo "warning: ~/.icons is a symlink into a dotfiles repo; installing next to it would duplicate the theme."
fi

mkdir -p "$HOME/.icons"
if [ -e "$target" ] && [ "$(readlink -f "$target")" != "$theme" ]; then
  echo "error: $target already exists" >&2
  exit 1
fi

ln -sfn "$theme" "$target"
gtk-update-icon-cache -f -t "$target" 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme Material-Tela 2>/dev/null || true
echo "installed Material-Tela -> $target"