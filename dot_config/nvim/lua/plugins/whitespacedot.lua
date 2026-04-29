-- Visual whitespace highlighter
return {
  "mcauley-penney/visual-whitespace.nvim",
  event = "ModeChanged *:[vV\x16]",
  opts = {
    enabled = true,
    highlight = { link = "Visual", default = true },
    match_types = {
      space = true,
      tab = true,
      nbsp = true,
      lead = false,
      trail = false,
    },
    list_chars = {
      space = "·",
      tab = "↦",
      nbsp = "␣",
      lead = "‹",
      trail = "›",
    },
    fileformat_chars = {
      unix = "↲",
      mac = "←",
      dos = "↙",
    },
    ignore = { filetypes = {}, buftypes = {} },
  },
}
