return {
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = { ["neotest-jest"] = { env = { NODE_OPTIONS = "--experimental-vm-modules" } }, "neotest-python" },
    },
  },
}
