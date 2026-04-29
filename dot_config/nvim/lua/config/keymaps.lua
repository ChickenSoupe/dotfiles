-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>sA", require("aerial").fzf_lua_picker, { desc = "Aerial (FzfLua)" })
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Hoverz" })
