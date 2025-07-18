return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {},
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = { preset = "dropdown" },
          },
        },
      },
    },
    keys = {
      {
        "\\",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
      },
    },
  },
}
