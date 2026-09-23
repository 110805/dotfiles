# dotfiles

Configs for zsh, neovim, yazi, zellij, claude, git, lazygit, atuin.

## Install

```sh
git clone git@github.com-110805:110805/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh            # symlinks into $HOME; refuses to clobber existing files
./install.sh --adopt    # ...or move existing files to ~/.dotfiles-backup-<stamp> first
```

## Machine-local settings and secrets

Never committed. `install.sh` creates them empty if missing:

- `~/.zshrc.local` — sourced at the end of `.zshrc`
- `~/.gitconfig.local` — pulled in via `[include]` in `.gitconfig`

Currently held there: the Claude telemetry `OTEL_EXPORTER_OTLP_HEADERS` bearer token,
and `sendemail.smtpPass`.

## Binaries these configs expect

Not installed by this repo. Install to `~/.local/bin` (already on `PATH` via `.zshrc`).

Required:

| Tool | Notes |
|---|---|
| zsh + oh-my-zsh | theme `amuse`, plugins `colored-man-pages` `zoxide` |
| neovim | `.config/nvim` is LazyVim; plugins self-install on first launch |
| yazi (+ `ya`) | |
| zellij | |
| claude | `curl -fsSL https://claude.ai/install.sh \| bash` |
| atuin | `.zshrc` sources it; Claude hooks call `atuin hook claude-code` |
| jq | required by the zellij hook and the Claude statusline |
| zoxide | oh-my-zsh `zoxide` plugin |
| delta | `.gitconfig` sets it as pager; git diff fails without it |

Optional: fzf, lazygit, difft, rg, fd, bat, node.

`.zshrc` guards `cargo`/`atuin` sourcing and the Andes toolchain `PATH`, so a shell
still starts cleanly when those are absent.

## After install on a new machine

```sh
claude login           # ~/.claude/.credentials.json is not tracked
atuin login            # syncs history rather than copying ~/.local/share/atuin
```

Then add the secrets listed above to `~/.zshrc.local` and `~/.gitconfig.local`.
