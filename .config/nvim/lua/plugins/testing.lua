return {
  { import = "lazyvim.plugins.extras.test.core" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-jest"] = opts.adapters["neotest-jest"] or {}
      opts.adapters["neotest-vitest"] = opts.adapters["neotest-vitest"] or {}
    end,
  },
}
