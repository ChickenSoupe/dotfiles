-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.showtabline = 0 -- 0: never, 1: only if >1 tab, 2: always
vim.opt.scrolloff = 100 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keep the cursor centered.
vim.opt.sidescrolloff = 8 -- Same but for side scrolling.
vim.opt.guicursor = "n:blinkon200-blinkoff200,i-ci-ve:ver25-blinkon200-blinkoff200" -- Enable cursor blink.
vim.opt.title = true
vim.opt.winborder = "rounded"
vim.opt.wrap = true
vim.opt.diffopt = {
  "internal",
  "filler",
  -- "closeoff",
  -- "indent-heuristic",
  -- "algorithm:histogram",
  -- "linematch:60",
  -- "vertical",
  -- "context:3",
}
