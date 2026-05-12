return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-nvim",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "auto", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true, -- disables setting the background color.
			float = {
				transparent = true, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			integrations = {
				lualine = {
					all = function(colors)
						return {
							insert = {
								a = { bg = "{{ colors.secondary.default.hex }}", fg = colors.base, gui = "bold" },
								b = {
									bg = "{{ colors.on_secondary.default.hex }}",
									fg = "{{ colors.secondary.default.hex }}",
								},
							},
							terminal = {
								a = { bg = "{{ colors.secondary.default.hex }}", fg = colors.base, gui = "bold" },
								b = {
									bg = "{{ colors.on_secondary.default.hex }}",
									fg = "{{ colors.secondary.default.hex }}",
								},
							},
							visual = {
								a = { bg = "{{ colors.tertiary.default.hex }}", fg = colors.base, gui = "bold" },
								b = {
									bg = "{{ colors.on_tertiary.default.hex }}",
									fg = "{{ colors.tertiary.default.hex }}",
								},
							},
							command = {
								a = {
									bg = "{{ colors.primary_container.default.hex }}",
									fg = colors.base,
									gui = "bold",
								},
								b = {
									bg = "{{ colors.on_primary_container.default.hex }}",
									fg = "{{ colors.primary_container.default.hex }}",
								},
							},
						}
					end,
				},
				blink_cmp = {
					style = "bordered",
				},
			},
			color_overrides = {
				mocha = {
					rosewater = '{{ "#C394C2" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					flamingo = '{{ "#C394C2" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					mauve = '{{ "#A19DD4" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					pink = "{{ {{ colors.primary.default.hex }} | lighten: -22.0 }}",
					red = '{{ "#DF8BA0" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					maroon = '{{ "#DF8BA0" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					peach = '{{ "#C79A76" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					yellow = '{{ "#C7B96F" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					green = '{{ "#75B087" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					teal = '{{ "#5EB1AF" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					sky = '{{ "#5EB1AF" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					sapphire = '{{ "#5EB1AF" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					blue = "{{colors.primary.default.hex }}",
					lavender = '{{ "#7AA8CE" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 50.0, "hsl" }}',
					text = "{{ colors.secondary.default.hex }}",
					subtext1 = '{{ "#878794" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					subtext0 = '{{ "#878794" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					overlay2 = "{{ {{ base16.base03.default.hex }} | lighten: 20.0 }}",
					overlay1 = '{{ "#808084" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					overlay0 = '{{ "#84848C" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					surface2 = "{{ colors.outline.default.hex }}",
					surface1 = '{{ "#37363E" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 0.5 }}',
					surface0 = "{{colors.on_primary.default.hex}}",
					base = '{{ "#191724" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					mantle = '{{ colors.surface_container_low.default.hex | saturate: 5.0, "hsl" | auto_lightness: 4.0 }}',
					crust = '{{ colors.surface_container_low.default.hex | saturate: 5.0, "hsl" | auto_lightness: 4.0 }}',
				},
				latte = {

					rosewater = '{{ "#A352A0" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					flamingo = '{{ "#A352A0" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					mauve = '{{ "#6A67B4" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					pink = "{{ {{ colors.primary.default.hex }} | lighten: 22.0 }}",
					red = '{{ "#C34165" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					maroon = '{{ "#C34165" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					peach = '{{ "#AC591C" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					yellow = '{{ "#8A7400" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					green = '{{ "#288043" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					teal = '{{ "#007E7D" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					sky = '{{ "#007E7D" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					sapphire = '{{ "#007E7D" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 40.0, "hsl" }}',
					blue = "{{colors.primary.default.hex }}",
					lavender = '{{ "#1675AB" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 50.0, "hsl" }}',
					text = "{{ colors.secondary.default.hex }}",
					subtext1 = '{{ "#757480" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					subtext0 = '{{ "#757480" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					overlay2 = "{{ {{ base16.base03.default.hex }} | lighten: -20.0 }}",
					overlay1 = '{{ "#7E7D8A" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					overlay0 = '{{ "#84828F" | to_color | harmonize: {{ colors.primary.default.hex }} }}',
					surface2 = "{{ colors.outline.default.hex }}",
					surface1 = '{{ "#EBDFD3" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 0.5 }}',
					surface0 = "{{colors.on_primary.default.hex}}",
					base = '{{ "#FAF4ED" | to_color | harmonize: {{ colors.primary.default.hex }} | saturate: 20.0, "hsl" }}',
					mantle = '{{ colors.surface_container_low.default.hex | saturate: 5.0, "hsl" | auto_lightness: 4.0 }}',
					crust = '{{ colors.surface_container_low.default.hex | saturate: 5.0, "hsl" | auto_lightness: 4.0 }}',
				},
			},
			highlight_overrides = {
				all = function(colors)
					return {
						CursorLine = {
							bg = "{{ {{ colors.background.default.hex }} | auto_lightness: 4.0 }}",
						},
						LineNr = {
							fg = "{{ colors.primary.default.hex }}",
						},
						-- Diff highlights (GitHub dark style)
						DiffAdd = { bg = "#0d4a23" },
						DiffDelete = { bg = "#4a0d11" },
						DiffChange = { bg = "#1c2c3f" },
						DiffText = { bg = "#1f4a7a" },
						DiffTextAdd = { link = "DiffText" },
					}
				end,
			},
		},
	},
}
