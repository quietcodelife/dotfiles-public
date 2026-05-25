return {
  { import = "lazyvim.plugins.extras.dap.core" },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "debugpy",
        "js-debug-adapter",
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dL",
        function()
          require("dap.ext.vscode").load_launchjs()
        end,
        desc = "Load launch.json",
      },
    },
  },
}
