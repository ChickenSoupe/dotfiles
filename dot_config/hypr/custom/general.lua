hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.67",
	bitdepth = 10,
	cm = "auto",
	-- sdr_eotf = "srgb",
})

hl.gesture({
	fingers = 4,
	direction = "swipe",
	action = "move",
})
hl.gesture({
	fingers = 4,
	direction = "pinch",
	action = "fullscreen",
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.config({
	input = {
		kb_layout = "us",
		kb_options = "caps:escape_shifted_capslock",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,

		follow_mouse = 1,
		off_window_axis_events = 2,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
			drag_3fg = 0,
			drag_lock = 1,
		},
		sensitivity = 0.3,
		accel_profile = "adaptive",
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 2,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(foot|kitty|allacritty|Alacritty)",
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		session_lock_xray = true,
		initial_workspace_tracking = false,
		focus_on_activate = true,
	},

	binds = {
		scroll_event_delay = 0,
		hide_special_on_workspace_change = true,
	},

	cursor = {
		zoom_factor = 1,
		zoom_rigid = false,
		zoom_disable_aa = true,
		hotspot_padding = 1,
	},

	xwayland = {
		force_zero_scaling = true,
		use_nearest_neighbor = false,
	},
})
