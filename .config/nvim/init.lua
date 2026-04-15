-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"c", "cpp"},
	callback = function()
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.expandtab = false
		vim.opt_local.colorcolumn = {80, 100}
	end,
})

-- Define a "Write-Only" OSC 52 provider to prevent timeouts
vim.g.clipboard = {
  name = 'osc52-write-only',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    -- Return empty results for paste to prevent the "Waiting for OSC 52" hang
    ['+'] = function() return { {}, '' } end,
    ['*'] = function() return { {}, '' } end,
  },
}

vim.cmd('colorscheme github_dark_dimmed')
