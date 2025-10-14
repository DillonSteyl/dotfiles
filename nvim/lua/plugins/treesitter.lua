return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
  },
  -- config = function(_, opts)
  --   require("nvim-treesitter.configs").setup(opts)
  --   vim.filetype.add({
  --     extension = {
  --       mjml = "mjml",
  --     },
  --   })
  --   vim.treesitter.language.register("html", "mjml")
  -- end,
}
