require("bunny"):setup({
  hops = {
    { key = { "h", "h" }, path = "~", desc = "Home" },
    { key = { "h", "m" }, path = "~/Music", desc = "Music" },
    { key = { "h", "d" }, path = "~/Documents", desc = "Documents" },
    { key = { "h", "k" }, path = "~/Desktop", desc = "Desktop" },
    { key = "c", path = "~/.config", desc = "Config files" },
    { key = { "l", "s" }, path = "~/.local/share", desc = "Local share" },
    { key = { "l", "b" }, path = "~/.local/bin", desc = "Local bin" },
    { key = { "l", "t" }, path = "~/.local/state", desc = "Local state" },
    { key = "m", path = "/run/media/chickensoupe", desc = "External Media" },
    { key = "q", path ="/etc/xdg", desc = "root config location"},
  },
  desc_strategy = "filename",
  tabs = false,
  ephemeral = false,
  notify = true, -- notify after hopping, default is false
  fuzzy_cmd = "fzf",
})

Header:children_add(function(self)
  return "YAZI"
end, 1000, Header.RIGHT)

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}
require("starship"):setup({
    -- Hide flags (such as filter, find and search). This is recommended for starship themes which
    -- are intended to go across the entire width of the terminal.
    hide_flags = false, -- Default: false
    -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
    flags_after_prompt = true, -- Default: true
    -- Custom starship configuration file to use
    config_file = "~/.config/starship.toml", -- Default: nil
})
