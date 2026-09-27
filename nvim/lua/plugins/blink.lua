return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap.preset = "default"
    opts.keymap["<C-l>"] = { "show", "show_documentation", "hide_documentation" }
  end,
}
