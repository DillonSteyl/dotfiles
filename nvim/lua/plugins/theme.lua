return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine", opts = { disable_background = true } },
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon", transparent = true },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  -- Configure default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka-vivid",
    },
  },
}
