-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

LazyVim.on_load("which-key.nvim", function()
  require("which-key").add({
    { "<leader>i", group = "infra/devops" },
  })
end)

local function project_terminal(cmd)
  return function()
    Snacks.terminal(cmd, { cwd = LazyVim.root() })
  end
end

-- Fast project navigation aliases.
map("n", "<leader><space>", function()
  Snacks.picker.files({ cwd = LazyVim.root() })
end, { desc = "Find Files" })

map("n", "<leader>/", function()
  Snacks.picker.grep({ cwd = LazyVim.root() })
end, { desc = "Grep Project" })

map("n", "<leader>fs", function()
  Snacks.picker.smart()
end, { desc = "Smart Find" })

map("n", "<leader>fw", function()
  Snacks.picker.grep_word({ cwd = LazyVim.root() })
end, { desc = "Find Word" })

map("x", "<leader>fw", function()
  Snacks.picker.grep_word({ cwd = LazyVim.root() })
end, { desc = "Find Selection" })

map("n", "<leader>fo", function()
  Snacks.picker.recent({ filter = { cwd = true } })
end, { desc = "Recent Files" })

map("n", "<leader>fd", function()
  Snacks.picker.diagnostics()
end, { desc = "Find Diagnostics" })

map("n", "<leader>fx", "<cmd>TodoTelescope<cr>", { desc = "Find TODO" })
map("n", "<leader>fX", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Find TODO/FIX/FIXME" })

-- Diagnostics and quickfix helpers.
map("n", "<leader>xa", function()
  vim.diagnostic.setqflist({ open = true })
end, { desc = "All Diagnostics to Quickfix" })

map("n", "<leader>xE", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = true })
end, { desc = "Errors to Quickfix" })

map("n", "<leader>xW", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN, open = true })
end, { desc = "Warnings to Quickfix" })

-- Git review flow.
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
map("n", "<leader>gF", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo File History" })

-- Session aliases that read naturally in day-to-day use.
map("n", "<leader>qr", function()
  require("persistence").load()
end, { desc = "Restore Session" })

map("n", "<leader>qR", function()
  require("persistence").load({ last = true })
end, { desc = "Restore Last Session" })

-- DevOps commands in a project-root terminal.
map("n", "<leader>ic", project_terminal({ "docker", "compose", "ps" }), { desc = "Docker Compose PS" })
map("n", "<leader>iu", project_terminal({ "docker", "compose", "up" }), { desc = "Docker Compose Up" })
map("n", "<leader>iU", project_terminal({ "docker", "compose", "up", "-d" }), { desc = "Docker Compose Up Detached" })
map("n", "<leader>id", project_terminal({ "docker", "compose", "down" }), { desc = "Docker Compose Down" })
map("n", "<leader>ik", project_terminal({ "kubectl", "get", "pods", "-A" }), { desc = "Kubernetes Pods" })
map("n", "<leader>ih", project_terminal({ "helm", "list", "-A" }), { desc = "Helm Releases" })
map("n", "<leader>ii", project_terminal({ "terraform", "init" }), { desc = "Terraform Init" })
map("n", "<leader>it", project_terminal({ "terraform", "plan" }), { desc = "Terraform Plan" })
map("n", "<leader>il", project_terminal({ "ansible-lint" }), { desc = "Ansible Lint" })
map("n", "<leader>ig", project_terminal({ "actionlint" }), { desc = "GitHub Actions Lint" })
