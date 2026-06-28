hl.config({
	general = {
		col = {
			active_border = "rgba({{colors.outline_variant.default.hex_stripped}}77)",
			inactive_border = "rgba({{colors.surface_container_low.default.hex_stripped}}33)",
		},
	},
	misc = {
		background_color = "rgba({{colors.surface.dark.hex_stripped}}FF)",
	},
	group = {
		col = {
			border_active = "rgba({{colors.outline_variant.default.hex_stripped}}77)",
			border_inactive = "rgba({{colors.surface_container_low.default.hex_stripped}}33)",
			border_locked_active = "rgba({{colors.outline_variant.default.hex_stripped}}77)",
			border_locked_inactive = "rgba({{colors.surface_container_low.default.hex_stripped}}33)",
		},
		groupbar = {
			height = 14,
			gradient_rounding = 10,
			gradients = true,
			indicator_height = 0,
			col = {
				active = "rgba({{colors.surface_container_high.default.hex_stripped}}FF)",
				inactive = "rgba({{colors.surface_container_lowest.default.hex_stripped}}FF)",
				locked_active = "rgba({{colors.surface_container_low.default.hex_stripped}}FF)",
				locked_inactive = "rgba({{colors.surface_container_high.default.hex_stripped}}FF)",
			},
		},
	},
	-- Old config
	-- col.border_active 			 = rgba(919191AA)
	-- col.border_inactive			 = rgba(474747AA)
	-- col.border_locked_active	 = rgba(919191AA)
	-- col.border_locked_inactive	 = rgba(474747AA)
	-- groupbar {
	-- height = 14
	--
	--    col.active = 0xFF222222
	--    col.inactive =  0xFF555555
	--    # Active/Inactive Locked Backgrounds (Set for completeness)
	--    col.locked_active = 0xFF444444
	--    col.locked_inactive = 0xFF222222
	-- gradient_rounding = 10
	-- gradients = true
	--
	--
	-- indicator_height = 0
	-- }
})

hl.window_rule({
	match = { pin = 1 },
	border_color = "rgba({{colors.primary.default.hex_stripped}}AA) rgba({{colors.primary.default.hex_stripped}}77)",
})
