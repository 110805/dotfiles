# dotfiles

Configs for zsh, neovim, yazi, zellij, claude, git, lazygit, atuin.

## New machine

Install Claude Code and log in on first launch:

```sh
curl -fsSL https://claude.ai/install.sh | bash
claude
```

Then give it this prompt:

> Set up this machine from my private dotfiles repo `git@github.com:110805/dotfiles.git`.
> Create an SSH key and show me the public key so I can add it on github.com,
> clone the repo to `~/dotfiles`, then follow its SETUP.md.

[SETUP.md](SETUP.md) lists every tool these configs expect and where it comes from,
links the dotfiles, and ends with the steps that need you (`chsh`, `atuin login`, secrets).

## Linking only

```sh
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

Listed in [SETUP.md](SETUP.md), installed to `~/.local/bin` (on `PATH` via `.zshrc`).

`.zshrc` guards `cargo`/`atuin` sourcing and the Andes toolchain `PATH`, so a shell
still starts cleanly when those are absent.
