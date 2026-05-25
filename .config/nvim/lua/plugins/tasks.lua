local function run_task(name)
  return function()
    require("overseer").run_task({ name = name })
  end
end

return {
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>od", run_task("devops: docker compose up -d"), desc = "Docker compose up -d" },
      { "<leader>oD", run_task("devops: docker compose down"), desc = "Docker compose down" },
      { "<leader>ol", run_task("devops: docker compose logs"), desc = "Docker compose logs" },
      { "<leader>ok", run_task("devops: kubectl get pods -A"), desc = "Kubectl pods" },
      { "<leader>oh", run_task("devops: helm list -A"), desc = "Helm list" },
      { "<leader>oi", run_task("devops: terraform init"), desc = "Terraform init" },
      { "<leader>op", run_task("devops: terraform plan"), desc = "Terraform plan" },
      { "<leader>ov", run_task("devops: terraform validate"), desc = "Terraform validate" },
      { "<leader>oa", run_task("quality: actionlint"), desc = "Actionlint" },
      { "<leader>os", run_task("quality: shellcheck all sh"), desc = "Shellcheck" },
    },
  },
}
