return {
  {
    "MagicDuck/grug-far.nvim",
    enabled = false,
  },
  {
    "ankushbhagats/match.nvim",
    config = true,
    keys = {

      { "<leader>sr", "<cmd>Match<cr>", desc = "SEarch and REplace" },
      -- { "<leader>sR", LazyVim.pick("grep_word"), desc = "Replace Selected word", mode = { "n", "x" } },
      {
        "<leader>sr",
        function()
          -- get the visually selected text
          local _, ls, cs = unpack(vim.fn.getpos("v"))
          local _, le, ce = unpack(vim.fn.getpos("."))
          local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
          local selected = table.concat(lines, "\n")
          -- escape for use in the command
          vim.cmd("Match " .. selected)
        end,
        desc = "Search and Replace selected",
        mode = { "x" },
      },
    },
  },
}
