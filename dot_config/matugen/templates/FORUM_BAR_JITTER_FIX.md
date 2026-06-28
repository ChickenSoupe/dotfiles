# Forum Bar Jitter Fix

## Problem

Opening a forum post and scrolling caused the follow/reaction/copylink bar (`.container__34c2c`) to jitter.

## Root Cause

The theme applied `inset-block-start: 8px` only when `.header__34c2c` was active (sticky state). Discord's base CSS positions it at `top: 0`. When scrolling toggled the class, the bar jumped between `top: 0` and `top: 8px`, causing visible jitter.

## Changes

**File:** `Material-Discord2.css`, lines 6603-6617

### Before

```css
.container__34c2c {
  --button-height: 26px;
  --button-padding-start: 10px;
  --button-padding-end: 10px;
  margin: 16px 10px 0 16px;
  padding: 8px;
  background-color: var(--card-color-filled);
  border-radius: 21px;
  border-block-start: none;
  box-shadow: none;
}
.container__34c2c.header__34c2c {
  inset-block-start: 8px;
  box-shadow: var(--shadow-medium);
}
```

### After

```css
.container__34c2c {
  --button-height: 26px;
  --button-padding-start: 10px;
  --button-padding-end: 10px;
  inset-block-start: 8px;
  margin: 16px 10px 0 16px;
  padding: 8px;
  background-color: var(--card-color-filled);
  border-radius: 21px;
  border-block-start: none;
  box-shadow: none;
}
.container__34c2c.header__34c2c {
  box-shadow: var(--shadow-medium);
}
```

## What Changed

1. **Moved** `inset-block-start: 8px` from `.header__34c2c` to the base `.container__34c2c` — constant offset, no toggling.
2. **Removed** `inset-block-start` from `.header__34c2c` — class only adds box-shadow now.

## Why It Works

No positional change between base and sticky states → no jitter. If Discord has `position: sticky; top: 0`, the theme consistently overrides to `top: 8px`. If not, `inset-block-start` on a static element is a no-op.
