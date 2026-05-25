return {
  { import = "lazyvim.plugins.extras.formatting.black" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "black",
        "taplo",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.bash = { "shfmt" }
      opts.formatters_by_ft.dockerfile = { "trim_whitespace" }
      opts.formatters_by_ft.hcl = { "terraform_fmt" }
      opts.formatters_by_ft.json = { "prettier" }
      opts.formatters_by_ft.jsonc = { "prettier" }
      opts.formatters_by_ft.markdown = { "prettier" }
      opts.formatters_by_ft.python = { "black" }
      opts.formatters_by_ft.sh = { "shfmt" }
      opts.formatters_by_ft.terraform = { "terraform_fmt" }
      opts.formatters_by_ft.terraform_vars = { "terraform_fmt" }
      opts.formatters_by_ft.toml = { "taplo" }
      opts.formatters_by_ft.yaml = { "prettier" }
      opts.formatters_by_ft.zsh = { "shfmt" }

      opts.formatters = opts.formatters or {}
      opts.formatters.shfmt = vim.tbl_deep_extend("force", opts.formatters.shfmt or {}, {
        prepend_args = { "-i", "2", "-ci", "-sr" },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.dockerfile = { "hadolint" }
      opts.linters_by_ft.github_action = { "actionlint" }
      opts.linters_by_ft.markdown = { "markdownlint" }
      opts.linters_by_ft.python = { "ruff" }
      opts.linters_by_ft.sh = { "shellcheck" }
      opts.linters_by_ft.terraform = { "tflint" }
      opts.linters_by_ft.yaml = { "yamllint" }
      opts.linters_by_ft.zsh = { "shellcheck" }
    end,
  },
}
