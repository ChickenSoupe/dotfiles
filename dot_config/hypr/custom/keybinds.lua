hl.bind(
	"CTRL+SUPER+ALT+Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
	{ description = "Edit user keybinds" }
)

-- hl.bind("")
-- Unbinds
hl.unbind("SUPER +G")

-- Group
hl.bind("SUPER + G", hl.dsp.group.toggle(), { description = "Toggle Group" })
hl.bind("SUPER + TAB", hl.dsp.group.next(), { description = "Next in Group" })
hl.bind("SUPER + SHIFT + TAB", hl.dsp.group.prev(), { description = "Previous in Group" })

-- Overlay
hl.bind("SUPER + Escape", hl.dsp.global("quickshell:overlayToggle"), { description = "Toggle widget overlay" })
