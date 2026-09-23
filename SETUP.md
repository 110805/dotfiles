# New machine setup

Instructions for Claude Code to bring a fresh Linux machine up to this dotfiles setup.
The human has only installed Claude Code; this repo is cloned to `~/dotfiles`. Do everything else.
Everything goes under `$HOME`. When a command needs root or the human's password, give them the exact `! <command>` to type and wait.

## Sources

| Tool | Source | Needed by |
|---|---|---|
| oh-my-zsh | https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | `.zshrc` (theme `amuse`, plugins `colored-man-pages` `zoxide`) |
| atuin | https://setup.atuin.sh | `.zshrc`, Claude hooks (`atuin hook claude-code`) |
| zoxide | https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | oh-my-zsh `zoxide` plugin |
| delta | dandavison/delta | `.gitconfig` pager; `git diff` fails without it |
| jq | jqlang/jq | zellij hook, Claude statusline |
| nvim | neovim/neovim | `.config/nvim` (LazyVim) |
| yazi, ya | sxyazi/yazi | `.config/yazi`, `y` in `.zshrc` |
| zellij | zellij-org/zellij | `.config/zellij` |
| lazygit | jesseduffield/lazygit | `.config/lazygit` |
| fd | sharkdp/fd | yazi search, LazyVim |
| rg | BurntSushi/ripgrep | yazi search, LazyVim |
| fzf | junegunn/fzf | |
| bat | sharkdp/bat | |
| difft | Wilfred/difftastic | |

To add a tool, add a row. A source is either an installer URL or a GitHub `owner/repo`.

## Fetching

**Installer URL**: run it non-interactively (`curl -fsSL <url> | sh`), with whatever flag or variable the script offers to skip prompts and leave `~/.zshrc` alone; read the script to find them.

**GitHub repo**: download the latest release from `https://api.github.com/repos/<repo>/releases/latest`.
- Match the machine's architecture (`uname -m`) and Linux.
- Prefer the **static build**: a `musl` asset, or a Go project's plain `linux` asset. Static builds run on any glibc; `gnu` builds fail on older distros with `GLIBC_2.xx not found`.
- A single-binary asset goes to `~/.local/bin/<tool>`. An archive that is only binaries: copy them to `~/.local/bin`. An archive with `bin/`, `lib/`, `share/`: extract to `~/.local/opt/<tool>` and symlink its `bin/` entries into `~/.local/bin`.

Work in a temporary directory and remove it afterwards.
If downloads hang, the office network needs the proxy in `.gitconfig` `[http] proxy`; export it as `https_proxy`.

## Steps

### 1. Prerequisites

Run `command -v zsh git curl tar unzip`.

Done when all five resolve. The missing ones need the human's package manager (root).

### 2. Link the dotfiles

Run `~/dotfiles/install.sh`. A fresh machine usually has stock files such as `~/.zshrc`; re-run with `--adopt`, which moves them to `~/.dotfiles-backup-<stamp>`.

Done when the output ends in `Done.` with no `conflict` lines.

### 3. Install every source

Install each row of the Sources table, following Fetching. Linking comes first so that any edit an installer makes to a tracked file shows up in git.

Done when every tool in the table runs with `--version` (oh-my-zsh: `~/.oh-my-zsh/oh-my-zsh.sh` exists) and `git -C ~/dotfiles status --short` is empty. Revert installer edits with `git -C ~/dotfiles checkout -- <file>`: the tracked configs already wire every tool up.

### 4. Verify the shell

Run `zsh -i -c 'command -v <every tool in the table>'` and read stderr.

Done when every tool resolves and stderr is empty.

### 5. Finish with the human

Walk the human through these one at a time, giving each command as `! <command>`:

- `chsh -s "$(command -v zsh)"` when their login shell is not zsh.
- `atuin login` to sync shell history.
- Secrets, into the untracked files `install.sh` created: `~/.zshrc.local` (Claude telemetry `OTEL_EXPORTER_OTLP_HEADERS` token) and `~/.gitconfig.local` (`sendemail.smtpPass`). The human types these in with an editor, so the values stay out of the conversation.

First `nvim` launch installs LazyVim plugins; it needs a C compiler for treesitter, so check `command -v cc` and mention it when missing.

Report each tool with its installed version, and anything skipped with the reason.
