local wezterm = require 'wezterm'

return {

  initial_rows = 60,
  initial_cols = 300,

  color_schemes = {
    ["CustomKittyTheme"] = {
      foreground = "#2a2b33",
      background = "#f8f8f8",
      cursor_bg = "#bbbbbb",
      cursor_border = "#bbbbbb",
      cursor_fg = "#2a2b33",
      selection_bg = "#e5e5e6",
      selection_fg = "#2a2b33",

      ansi = {
        "#000000", "#de3d35", "#3e953a", "#d2b67b",
        "#2f5af3", "#950095", "#3e953a", "#bbbbbb",
      },

      brights = {
        "#000000", "#de3d35", "#3e953a", "#d2b67b",
        "#2f5af3", "#a00095", "#3e953a", "#ffffff",
      },
    },
  },
  color_scheme = "CustomKittyTheme",
}
