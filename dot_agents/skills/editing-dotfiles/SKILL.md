---
name: editing-dotfiles
description: "Edit, add, and manage dotfiles through chezmoi. Use when asked to modify shell config, terminal settings, editor config, git config, or any dotfile. Ensures changes go through chezmoi source state so they are tracked and portable."
---

# Editing Dotfiles via Chezmoi

## Overview

This user manages dotfiles with [chezmoi](https://www.chezmoi.io/). All dotfile edits MUST go through chezmoi's source state so changes are tracked in version control and can be applied across machines.

## Key paths

| Concept | Path |
|---------|------|
| Source directory | `~/.local/share/chezmoi/` |
| Config | `~/.config/chezmoi/chezmoi.toml` |
| Config template | `~/.chezmoi.toml.tmpl` |

## Critical rules

1. **NEVER edit dotfiles directly in `~/`**. Always edit the source state in `~/.local/share/chezmoi/`.
2. After editing source files, run `chezmoi apply` to deploy changes to the home directory.
3. Respect chezmoi's naming conventions (see below).

## Chezmoi naming conventions

Chezmoi uses special prefixes/suffixes in source file names to control behavior:

| Source name | Target |
|-------------|--------|
| `dot_gitconfig` | `~/.gitconfig` |
| `dot_config/fish/config.fish` | `~/.config/fish/config.fish` |
| `private_dot_ssh/config` | `~/.ssh/config` (with private permissions) |
| `empty_starship.toml` | `~/.config/starship.toml` (empty if missing) |
| `*.tmpl` suffix | Processed as a Go template |

Key prefix mappings:
- `dot_` → `.` (leading dot)
- `private_` → file permissions set to private (0600)
- `readonly_` → file permissions set to read-only
- `executable_` → file made executable (0755)
- `empty_` → create file even if empty
- `symlink_` → create a symlink
- `create_` → create file only if it doesn't exist

## Workflow for editing an existing managed file

1. Determine the source path: `chezmoi source-path <target>`
   - Example: `chezmoi source-path ~/.config/fish/config.fish` → `~/.local/share/chezmoi/dot_config/fish/config.fish`
2. Read and edit the **source** file (the one in `~/.local/share/chezmoi/`)
3. Run `chezmoi diff` to preview changes
4. Run `chezmoi apply` to deploy

## Workflow for adding a new dotfile

1. If the file already exists in `~/`, use: `chezmoi add <target-path>`
   - Example: `chezmoi add ~/.config/wezterm/wezterm.lua`
   - This copies the file into the source directory with correct naming
2. If creating a brand new file, create it in the source directory using chezmoi naming conventions, then run `chezmoi apply`

## Workflow for removing a managed file

1. `chezmoi forget <target-path>` — removes from source state but keeps the deployed file
2. `chezmoi destroy <target-path>` — removes from source state AND deletes the deployed file

## Currently managed files

Run `chezmoi managed --include=files` to see all managed files. Key configs include:
- Fish shell: `~/.config/fish/config.fish` and functions in `~/.config/fish/functions/`
- Ghostty terminal: `~/.config/ghostty/config`
- Helix editor: `~/.config/helix/config.toml`, `~/.config/helix/languages.toml`
- Starship prompt: `~/.config/starship.toml`
- Zellij multiplexer: `~/.config/zellij/config.kdl`
- Git: `~/.gitconfig`
- Agent skills: `~/.config/agents/skills/`

## Template files

Files ending in `.tmpl` are Go templates processed by chezmoi. Use `chezmoi cat <target>` to see the rendered output. When editing templates, use `chezmoi execute-template` to test rendering.

## Git integration

The source directory is a git repo. After making changes:
1. `chezmoi apply` to deploy
2. `chezmoi git -- add -A` to stage
3. `chezmoi git -- commit -m "message"` to commit
4. `chezmoi git -- push` to push

Only run git commands when explicitly asked by the user.

## Useful commands reference

| Command | Purpose |
|---------|---------|
| `chezmoi managed` | List all managed entries |
| `chezmoi unmanaged` | List unmanaged files in home |
| `chezmoi diff` | Show pending changes |
| `chezmoi apply` | Deploy source state to home |
| `chezmoi apply --dry-run` | Preview what apply would do |
| `chezmoi status` | Show which files differ |
| `chezmoi cat <file>` | Print rendered target contents |
| `chezmoi source-path <file>` | Get source path for a target |
| `chezmoi re-add` | Re-add modified files (target → source) |
