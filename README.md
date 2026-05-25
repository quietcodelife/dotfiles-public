# dotfiles-public

Public dotfiles for my daily macOS development setup.

Inspired by craftzdog's dotfiles approach: keep the important configuration in one public repo, make it easy to inspect, copy and restore on a fresh machine.

## Included

- `nvim` - LazyVim based Neovim setup for development and DevOps work
- `wezterm` - terminal configuration with fish as the default shell
- `fish` - shell config and Fisher plugin list

## Structure

```text
.config/
  fish/
    config.fish
    fish_plugins
  nvim/
    init.lua
    lua/
    snippets/
  wezterm/
    wezterm.lua
install.sh
```

## Install

Clone the repo:

```bash
git clone https://github.com/quietcodelife/dotfiles-public.git ~/dotfiles-public
cd ~/dotfiles-public
```

Run the installer:

```bash
./install.sh
```

The installer creates symlinks:

- `~/.config/nvim` -> repo `.config/nvim`
- `~/.config/wezterm` -> repo `.config/wezterm`
- `~/.config/fish/config.fish` -> repo `.config/fish/config.fish`
- `~/.config/fish/fish_plugins` -> repo `.config/fish/fish_plugins`

Existing files are moved to:

```text
~/.dotfiles-backup/YYYYMMDD-HHMMSS/
```

## Neovim

Main features:

- LazyVim based setup
- Dev/DevOps extras for Docker, Terraform, Helm, Ansible, YAML, JSON, Python, TypeScript and Markdown
- formatting and linting with Mason tools
- testing through Neotest
- debugging through nvim-dap
- Git workflow with Gitsigns, Diffview and Snacks picker
- custom snippets for Dockerfile, YAML, Terraform and shell
- Overseer task templates for common devops commands

After installing, open Nvim and sync plugins:

```vim
:Lazy sync
```

Install external tools through Mason:

```vim
:Mason
```

## Fish

Fish plugins are managed by Fisher.

Current plugin list:

```text
jorgebucaran/fisher
ilancosman/tide@v5
```

Install Fisher and plugins on a fresh machine:

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher update
```

This repo intentionally does not include `fish_variables`, because it is machine-local state and can contain private or noisy values.

## WezTerm

WezTerm uses:

- Hack Nerd Font Mono
- Tokyo Night color scheme
- fish as default shell
- split pane keybindings
- bottom tab bar

## Notes

This is a public repo. Do not commit:

- API keys
- tokens
- private SSH keys
- `fish_variables`
- local caches
- machine-specific secrets
