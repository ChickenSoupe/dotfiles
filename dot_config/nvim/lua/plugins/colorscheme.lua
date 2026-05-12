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
								a = { bg = "#c8c3e3", fg = colors.base, gui = "bold" },
								b = {
									bg = "#302d47",
									fg = "#c8c3e3",
								},
							},
							terminal = {
								a = { bg = "#c8c3e3", fg = colors.base, gui = "bold" },
								b = {
									bg = "#302d47",
									fg = "#c8c3e3",
								},
							},
							visual = {
								a = { bg = "#d9c765", fg = colors.base, gui = "bold" },
								b = {
									bg = "#383100",
									fg = "#d9c765",
								},
							},
							command = {
								a = {
									bg = "#6f68ab",
									fg = colors.base,
									gui = "bold",
								},
								b = {
									bg = "#ffffff",
									fg = "#6f68ab",
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
					mauve = '#8b81f0',
					pink = "#654fff",
					red = '#e67eb5',
					maroon = '#e67eb5',
					peach = '#ef895c',
					yellow = '#e9bb59',
					green = '#3bdfa4',
					teal = '#33cfe9',
					sky = '#33cfe9',
					sapphire = '#33cfe9',
					blue = "#c7bfff",
					lavender = '#5d9dfc',
					text = "#c8c3e3",
					subtext1 = '#888794',
					subtext0 = '#888794',
					overlay2 = "#758ca4",
					overlay1 = '#818084',
					overlay0 = '#85848c',
					surface2 = "#928f9b",
					surface1 = '#37363e',
					surface0 = "#2e2766",
					base = '#15112a',
					mantle = '#25232c',
					crust = '#25232c',
				},
				latte = {

					rosewater = '#a426e4',
					flamingo = '#9c3fcb',
					mauve = '#4538e2',
					pink = "#ffffff",
					red = '#d62889',
					maroon = '#d62889',
					peach = '#df3c09',
					yellow = '#996e00',
					green = '#00805b',
					teal = '#007f8f',
					sky = '#007f8f',
					sapphire = '#007f8f',
					blue = "#c7bfff",
					lavender = '#0069ed',
					text = "#c8c3e3",
					subtext1 = '#767480',
					subtext0 = '#767480',
					overlay2 = "#1f262e",
					overlay1 = '#7f7d8a',
					overlay0 = '#84828f',
					surface2 = "#928f9b",
					surface1 = '#e5dfe7',
					surface0 = "#2e2766",
					base = '#fdf4eb',
					mantle = '#25232c',
					crust = '#25232c',
				},
			},
			highlight_overrides = {
				all = function(colors)
					return {
						CursorLine = {
							bg = "#1e1c22",
						},
						LineNr = {
							fg = "#c7bfff",
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
