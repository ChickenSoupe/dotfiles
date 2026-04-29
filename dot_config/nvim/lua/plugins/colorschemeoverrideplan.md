# Plan: Override Catppuccin Colors to Match Kitty Terminal Palette

## Overview

Your kitty config uses two palettes depending on light/dark mode:

- **Dark mode** → Gruvbox-inspired colors
- **Light mode** → Monokai Pro-inspired colors

Since catppuccin uses `mocha` for dark and `latte` for light (per your `background` config),
we map each kitty `color1–14` to the catppuccin semantic color roles using `color_overrides`.

---

## How `color_overrides` Works

```lua
color_overrides = {
  all   = { ... },   -- applies to every flavour
  mocha = { ... },   -- dark mode overrides
  latte = { ... },   -- light mode overrides
}
```

Keys are catppuccin palette names (e.g. `red`, `green`, `yellow`, `blue`, `mauve`, `teal`).
Values are hex strings.

---

## Terminal Color → Catppuccin Role Mapping

### Dark (mocha) — Gruvbox palette

| kitty slot | hex       | semantic role    | catppuccin key |
| ---------- | --------- | ---------------- | -------------- |
| color1     | `#CC241D` | red (normal)     | `red`          |
| color2     | `#98971A` | green (normal)   | `green`        |
| color3     | `#D79921` | yellow (normal)  | `yellow`       |
| color4     | `#458588` | blue (normal)    | `blue`         |
| color5     | `#B16286` | magenta (normal) | `mauve`        |
| color6     | `#689D6A` | cyan (normal)    | `teal`         |
| color7     | `#A89984` | white (normal)   | `text`         |
| color8     | `#928374` | bright black     | `overlay1`     |
| color9     | `#FB4934` | red (bright)     | `maroon`       |
| color10    | `#B8BB26` | green (bright)   | `sky`          |
| color11    | `#FABD2F` | yellow (bright)  | `peach`        |
| color12    | `#83A598` | blue (bright)    | `sapphire`     |
| color13    | `#D3869B` | magenta (bright) | `pink`         |
| color14    | `#8EC07C` | cyan (bright)    | `flamingo`     |
| -          | `#D3869B` | warm pink        | `rosewater`    |
| -          | `#B16286` | purple           | `lavender`     |

### Light (latte) — Monokai Pro palette

| kitty slot | hex       | semantic role    | catppuccin key |
| ---------- | --------- | ---------------- | -------------- |
| color1     | `#FF6188` | red (normal)     | `red`          |
| color2     | `#A9DC76` | green (normal)   | `green`        |
| color3     | `#FC9867` | yellow (normal)  | `yellow`       |
| color4     | `#FFD866` | blue (normal)    | `blue`         |
| color5     | `#F47FD4` | magenta (normal) | `mauve`        |
| color6     | `#78DCE8` | cyan (normal)    | `teal`         |
| color7     | `#333034` | white (normal)   | `text`         |
| color8     | `#121212` | bright black     | `overlay1`     |
| color9     | `#FF6188` | red (bright)     | `maroon`       |
| color10    | `#A9DC76` | green (bright)   | `sky`          |
| color11    | `#FC9867` | yellow (bright)  | `peach`        |
| color12    | `#FFD866` | blue (bright)    | `sapphire`     |
| color13    | `#F47FD4` | magenta (bright) | `pink`         |
| color14    | `#78DCE8` | cyan (bright)    | `flamingo`     |
| -          | `#FF6188` | warm pink        | `rosewater`    |
| -          | `#AB9DF2` | soft purple      | `lavender`     |

---

## Implementation

Matugen generates the `color_overrides` block with harmonized colors on each wallpaper change. The output is plain hex strings that go directly into your catppuccin config.

### Template file: `catppuccin-overrides.lua`

This is a **matugen template file** that generates the `color_overrides` Lua table. Matugen applies `harmonize → blend → auto_lightness` to sync colors with your wallpaper accent.

Save to `~/.config/matugen/templates/catppuccin-overrides.lua`:
```
color_overrides = {
  mocha = {
    -- Gruvbox dark palette — harmonized to system accent
    rosewater = "{{ "#D3869B" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 0.7 }}",
    flamingo  = "{{ "#8EC07C" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    mauve     = "{{ "#B16286" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    pink      = "{{ "#D3869B" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    red       = "{{ "#CC241D" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    maroon    = "{{ "#FB4934" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    peach     = "{{ "#FABD2F" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    yellow    = "{{ "#D79921" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    green     = "{{ "#98971A" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    teal      = "{{ "#689D6A" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    sky       = "{{ "#B8BB26" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    sapphire  = "{{ "#83A598" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    blue      = "{{ "#458588" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    lavender  = "{{ "#B16286" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 0.7 }}",
  },
  latte = {
    -- Monokai Pro light palette — harmonized to system accent
    rosewater = "{{ "#FF6188" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    flamingo  = "{{ "#78DCE8" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    mauve     = "{{ "#F47FD4" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    pink      = "{{ "#F47FD4" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    red       = "{{ "#FF6188" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    maroon    = "{{ "#FF6188" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    peach     = "{{ "#FC9867" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    yellow    = "{{ "#FC9867" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    green     = "{{ "#A9DC76" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    teal      = "{{ "#78DCE8" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    sky       = "{{ "#A9DC76" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    sapphire  = "{{ "#FFD866" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    blue      = "{{ "#FFD866" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
    lavender  = "{{ "#AB9DF2" | to_color | harmonize: {{ colors.primary.default.hex }} | blend: {{ colors.primary.default.hex }}, 1.0 | auto_lightness: 15.0 }}",
  },
},
```

### Template file: `custom_highlights.lua`

For CursorLine (runs inside Neovim, not matugen template). Save to `~/.config/matugen/templates/custom_highlights.lua`:
```
CursorLine = { fg = "{{ colors.on_surface.default.hex | blend: {{ colors.primary.default.hex }}, 0.5 | auto_lightness: 70.0 }}", bg = "{{ colors.on_surface.default.hex | blend: {{ colors.primary.default.hex }}, 0.5 | auto_lightness: 70.0 }}" },
```

### Matugen config entry (`config.toml`)

```toml
[templates.catppuccin-overrides]
input_path  = "~/.config/matugen/templates/catppuccin-overrides.lua"
output_path = "path to catppuccin/theme/overrides.lua"

[templates.custom_highlights]
input_path  = "~/.config/matugen/templates/custom_highlights.lua"
output_path = "path to custom_highlights.lua"
```

### Usage in catppuccin config

Paste the matugen-generated content directly into `color_overrides` and `custom_highlights`. The output will be plain hex strings (no matugen syntax).

**Note:** `text`, `subtext0`, `subtext1`, `overlay0-2`, `surface0-2`, `base`, `mantle`, `crust` remain constant (neutral grays) and should stay as their default catppuccin values.

### Custom Highlights via Matugen

Since `custom_highlights` is Lua code (runs inside Neovim, not matugen), it can't use matugen template syntax directly. Create a separate matugen template file:

### Template file: `custom_highlights.lua`

Save to `~/.config/matugen/templates/custom_highlights.lua`:
```
CursorLine = { fg = "{{ colors.on_surface.default.hex | blend: {{ colors.primary.default.hex }}, 0.5 | auto_lightness: 70.0 }}", bg = "{{ colors.on_surface.default.hex | blend: {{ colors.primary.default.hex }}, 0.5 | auto_lightness: 70.0 }}" },
```

### Matugen config entry (`config.toml`)

```toml
[templates.custom_highlights]
input_path  = "~/.config/matugen/templates/custom_highlights.lua"
output_path = "path to custom_highlights.lua"
```

### Usage in catppuccin config

In `catppuccin.lua`, `require` the generated file:
```lua
custom_highlights = function(colors)
  local custom = require("custom_highlights")
  return custom
end,
```

Or paste the generated content directly into `custom_highlights`.

---

## Notes & Caveats

1. **Colors stay in sync automatically** — because the template uses the same
   `harmonize → blend → auto_lightness` pipeline as your kitty config, both
   kitty and nvim will always use the same resolved colors after each matugen
   run.

2. **`latte` blue = `#FFD866` (yellow)** — In Monokai Pro the "blue" terminal
   slot is actually a warm yellow. This is intentional in that palette but
   may look odd in nvim contexts where `blue` is used for UI elements like
   borders. Consider keeping `blue` as catppuccin's default latte blue
   (`#1e66f5`) and only overriding the accent colors.

3. **Deletions / diffs** — catppuccin uses `red` and `green` for diff
   highlights. With the Gruvbox values these will look very close to the
   original Gruvbox diff colors, which is likely what you want.

4. **`term_colors = false`** — your config already has this set, meaning
   catppuccin won't overwrite the terminal palette inside `:terminal`. Good —
   this keeps your kitty colors authoritative for terminal buffers.
