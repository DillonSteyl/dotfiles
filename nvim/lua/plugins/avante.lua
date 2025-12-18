return {
  "yetone/avante.nvim",
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "codex",
    model = "gpt-5.1-codex-max",
    selection = {
      enabled = true,
      hint_display = "delayed",
    },
    behaviour = {
      auto_set_keymaps = true,
    },
  },
}
