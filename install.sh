#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
backup_dir="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_path() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    local current
    current="$(readlink "$target")"
    if [ "$current" = "$source" ]; then
      echo "ok: $target"
      return
    fi
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$backup_dir"
    mv "$target" "$backup_dir/"
    echo "backup: $target -> $backup_dir/"
  fi

  ln -s "$source" "$target"
  echo "link: $target -> $source"
}

link_path "$repo_dir/.config/nvim" "$HOME/.config/nvim"
link_path "$repo_dir/.config/wezterm" "$HOME/.config/wezterm"
link_path "$repo_dir/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
link_path "$repo_dir/.config/fish/fish_plugins" "$HOME/.config/fish/fish_plugins"

echo
echo "Done."
echo "Next steps:"
echo "  nvim +Lazy sync"
echo "  fish -lc 'fisher update'"
