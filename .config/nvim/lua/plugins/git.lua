return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local on_attach = opts.on_attach

      opts.current_line_blame = false
      opts.current_line_blame_opts = {
        delay = 400,
        ignore_whitespace = true,
      }
      opts.preview_config = {
        border = "rounded",
      }

      opts.on_attach = function(buffer)
        if on_attach then
          on_attach(buffer)
        end

        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc, silent = true })
        end

        map("n", "<leader>ghl", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk Popup")
        map("n", "<leader>ghn", function()
          gs.nav_hunk("next")
        end, "Next Hunk")
        map("n", "<leader>ghN", function()
          gs.nav_hunk("prev")
        end, "Prev Hunk")
      end
    end,
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Commits",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git File Log",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Line Log",
      },
      {
        "<leader>go",
        function()
          Snacks.picker.git_diff({ base = "origin", group = true })
        end,
        desc = "Git Diff Origin",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Working Tree" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File" },
      { "<leader>gM", "<cmd>DiffviewOpen<cr>", desc = "Diffview Merge Conflicts" },
      { "<leader>gQ", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>gh", group = "hunks" },
      },
    },
  },
}
