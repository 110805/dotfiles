-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Give `listchars` whitespace glyphs a distinct color so they stand out.
local function set_whitespace_hl()
	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#d29922" })
end

-- Reapply on every ColorScheme change (colorschemes reset highlights)...
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_whitespace_hl })

-- ...and apply once now. This file loads on VeryLazy, after init.lua has
-- already set the colorscheme at startup, so the autocmd above misses that
-- first load. Calling it here makes the glyphs colored without a manual
-- `:colorscheme` after reopening.
set_whitespace_hl()
