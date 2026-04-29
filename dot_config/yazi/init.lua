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

require("recycle-bin"):setup()
require("duckdb"):setup({
  mode = "summarized",            -- Default: "summarized"
  cache_size = 1000,                          -- Default: 500
  row_id = "dynamic",             -- Default: false
  minmax_column_width = 21,                  -- Default: 21
  column_fit_factor = 10,                  -- Default: 10.0
})
