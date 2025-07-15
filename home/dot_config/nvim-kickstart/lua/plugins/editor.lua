return {
  {
    "folke/snacks.nvim",
    opts = { explorer = {} },
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
