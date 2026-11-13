return {
  -- Color scheme options
  { "craftzdog/solarized-osaka.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "folke/tokyonight.nvim", opts = { style = "moon" } },
  -- Configure default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
