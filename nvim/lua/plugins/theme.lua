return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
}
