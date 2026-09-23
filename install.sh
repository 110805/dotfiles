#!/bin/sh
# Symlink tracked dotfiles into $HOME.
#
#   ./install.sh            refuses to overwrite existing files (safe default)
#   ./install.sh --adopt    moves existing files aside into a backup dir first
#
# Machine-local settings and secrets stay out of this repo; see README.md.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
adopt=0
[ "$1" = "--adopt" ] && adopt=1
errors=0

link() {
    src="$DOTFILES_DIR/$1"
    dst="$HOME/$1"

    if [ ! -e "$src" ]; then
        printf 'skip     %s (not in repo)\n' "$dst"
        return
    fi

    if [ -L "$dst" ]; then
        if [ "$(readlink "$dst")" = "$src" ]; then
            printf 'ok       %s\n' "$dst"
            return
        fi
        printf 'conflict %s (symlink to %s)\n' "$dst" "$(readlink "$dst")"
        errors=$((errors + 1))
        return
    fi

    if [ -e "$dst" ]; then
        if [ "$adopt" -eq 0 ]; then
            printf 'conflict %s (exists; --adopt to back up and replace)\n' "$dst"
            errors=$((errors + 1))
            return
        fi
        mkdir -p "$(dirname "$BACKUP_DIR/$1")"
        mv "$dst" "$BACKUP_DIR/$1" || { errors=$((errors + 1)); return; }
        printf 'backup   %s -> %s\n' "$dst" "$BACKUP_DIR/$1"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    printf 'link     %s -> %s\n' "$dst" "$src"
}

link .zshrc
link .zshenv
link .gitconfig
link .zsh/completions
link .claude/settings.json
link .claude/statusline-command.sh
link .claude/CLAUDE.md
link .config/nvim
link .config/git
link .config/atuin
link .config/lazygit
link .config/zellij
link .config/yazi

# Untracked machine-local files the tracked configs source.
for f in .zshrc.local .gitconfig.local; do
    if [ ! -e "$HOME/$f" ]; then
        printf '# %s: machine-local settings and secrets, not tracked.\n' "$f" > "$HOME/$f"
        chmod 600 "$HOME/$f"
        printf 'create   %s (empty; add machine-local secrets here)\n' "$HOME/$f"
    fi
done

if [ "$errors" -gt 0 ]; then
    printf '\n%d conflict(s); resolve and re-run.\n' "$errors" >&2
    exit 1
fi
printf '\nDone.\n'
