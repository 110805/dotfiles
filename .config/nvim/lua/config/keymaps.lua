-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader><left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader><down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader><up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader><right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

Snacks.toggle.zoom():map("<leader>wf"):map("<leader>uZ")
