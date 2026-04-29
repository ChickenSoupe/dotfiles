return {
  -- File manager: Yazi
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  init = function()
    -- Prevent netrw from loading (required for open_for_directories=true)
    -- https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    open_for_directories = true,
    floating_window_scaling_factor = 0.71,
    keymaps = {
      show_help = "<f1>",
    },
  },
  keys = {
    {
      "<leader>r",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Yazi",
    },
  },
}
-- file browsers ------------------------------------
-- <f1>: show the help menu
-- <c-v>: open the selected file(s) in vertical splits
-- <c-x>: open the selected file(s) in horizontal splits
-- <c-t>: open the selected file(s) in new tabs
-- <c-q>: send the selected file(s) to the quickfix list
-- There are also integrations to other plugins, which you need to install separately:
--
--     <c-s>: search in the current yazi directory using telescope's live_grep, if available. Optionally you can use fzf-lua.nvim, snacks.picker or provide your own implementation - see the instructions in the configuration section for more info.
--         if multiple files/directories are selected in yazi, the search and replace will only be done in the selected files/directories
--     <c-g>: search and replace in the current yazi directory using grug-far, if available
--         if multiple files/directories are selected in yazi, the operation is limited to those only
--     <c-y>: copy the relative path of the selected file(s) to the clipboard. Requires GNU realpath or grealpath on OSX
--         also available for the snacks.nvim picker, see documentation/copy-relative-path-to-files.md for more information
--     <tab>: make yazi jump to the open buffers in Neovim. See #232 for more information
--
--
