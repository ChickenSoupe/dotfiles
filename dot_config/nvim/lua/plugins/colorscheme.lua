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
								a = { bg = "#b7c6ee", fg = colors.base, gui = "bold" },
								b = {
									bg = "#203050",
									fg = "#b7c6ee",
								},
							},
							terminal = {
								a = { bg = "#b7c6ee", fg = colors.base, gui = "bold" },
								b = {
									bg = "#203050",
									fg = "#b7c6ee",
								},
							},
							visual = {
								a = { bg = "#ffb77e", fg = colors.base, gui = "bold" },
								b = {
									bg = "#4d2600",
									fg = "#ffb77e",
								},
							},
							command = {
								a = {
									bg = "#3665bb",
									fg = colors.base,
									gui = "bold",
								},
								b = {
									bg = "#ffffff",
									fg = "#3665bb",
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
					rosewater = '#bd78eb',
					flamingo = '#ba87dc',
					mauve = '#7a8bf2',
					pink = "#3e77ff",
					red = '#e67eb5',
					maroon = '#e67eb5',
					peach = '#ef895c',
					yellow = '#c8d164',
					green = '#3bdfa4',
					teal = '#33cfe9',
					sky = '#33cfe9',
					sapphire = '#33cfe9',
					blue = "#aec6ff",
					lavender = '#599ffc',
					text = "#b7c6ee",
					subtext1 = '#868794',
					subtext0 = '#868794',
					overlay2 = "#a09b75",
					overlay1 = '#808084',
					overlay0 = '#84848c',
					surface2 = "#8d909d",
					surface1 = '#34363e',
					surface0 = "#002e6b",
					base = '#10142a',
					mantle = '#21232e',
					crust = '#21232e',
				},
				latte = {

					rosewater = '#a426e4',
					flamingo = '#9c3fcb',
					mauve = '#2d4ce4',
					pink = "#ffffff",
					red = '#d62889',
					maroon = '#d62889',
					peach = '#df3c09',
					yellow = '#868808',
					green = '#00805b',
					teal = '#007f8f',
					sky = '#007f8f',
					sapphire = '#007f8f',
					blue = "#aec6ff",
					lavender = '#006fe6',
					text = "#b7c6ee",
					subtext1 = '#737480',
					subtext0 = '#737480',
					overlay2 = "#2b2a1e",
					overlay1 = '#7c7e8a',
					overlay0 = '#82838f',
					surface2 = "#8d909d",
					surface1 = '#e1e0e7',
					surface0 = "#002e6b",
					base = '#fbf4ec',
					mantle = '#21232e',
					crust = '#21232e',
				},
			},
			highlight_overrides = {
				all = function(colors)
					return {
						CursorLine = {
							bg = "#191c25",
						},
						LineNr = {
							fg = "#aec6ff",
						},
					}
				end,
			},
		},
	},
}
