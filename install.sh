#!/bin/sh
# Symlink tracked dotfiles into $HOME.
# Safe: refuses to overwrite existing files. Resolve conflicts manually and re-run.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
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
        printf 'conflict %s (exists; move or delete to resolve)\n' "$dst"
        errors=$((errors + 1))
        return
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    printf 'link     %s -> %s\n' "$dst" "$src"
}

link .zshrc
link .gitconfig
link .claude/settings.json
link .claude/statusline-command.sh
link .config/nvim
link .config/git
link .config/lazygit
link .config/zellij
link .config/yazi

if [ "$errors" -gt 0 ]; then
    printf '\n%d conflict(s); resolve and re-run.\n' "$errors" >&2
    exit 1
fi
printf '\nDone.\n'
