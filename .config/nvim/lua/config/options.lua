-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.autoformat = false

-- LazyVim turns this off; vim's default is on.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Diagnostics off at startup, toggled with <leader>ud.
vim.diagnostic.enable(false)

-- Whitespace rendering, off by default and toggled with <leader>uW.
-- Tabs show as »; leading spaces show as · (so 8 leading spaces look
-- different from one leading tab). Spaces mid-line stay blank.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", lead = "·", trail = "·", nbsp = "␣" }
