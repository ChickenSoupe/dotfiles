-- Flutter/Dart development tools
return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      fvm = true,
      flutter_path = os.getenv("HOME") .. "/fvm/default/bin/flutter",
    })
  end,
}
