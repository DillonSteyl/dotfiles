return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine", opts = { disable_background = true } },
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon", transparent = true },
  },
  -- Configure default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
