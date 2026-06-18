return {
  "saghen/blink.cmp",
  dependencies = { "milanglacier/minuet-ai.nvim" },
  opts = function(_, opts)
    opts.keymap["<C-l>"] = { "show", "show_documentation", "hide_documentation" }
    opts.keymap["<A-y>"] = require("minuet").make_blink_map()

    table.insert(opts.sources.default, "minuet")
    opts.sources.providers.minuet = {
      name = "minuet",
      module = "minuet.blink",
      async = true,
      timeout_ms = 3000,
      score_offset = 50,
    }
  end,
}
