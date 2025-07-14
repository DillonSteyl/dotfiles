return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
        gh_actions_ls = {},
        gdshader_lsp = {},
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off", -- will rely on mypy for type checking. Keeps things consistent
              },
            },
          },
        },
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "",
                languages = { "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
        },
        volar = {},
        tailwindcss = {},
        ember = {},
        eslint = {},
        csharp_ls = {},
        astro = {},
      },
    },
  },
}
