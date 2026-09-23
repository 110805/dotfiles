-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

Snacks.toggle.zoom():map("<leader>wf"):map("<leader>uZ")

Snacks.toggle.option("list", { name = "Whitespace" }):map("<leader>uW")
