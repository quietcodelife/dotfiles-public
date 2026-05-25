local overseer = require("overseer")

local function root(opts)
  if _G.LazyVim and LazyVim.root then
    return LazyVim.root()
  end
  return opts and opts.dir or vim.fn.getcwd()
end

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local function find_up(names, start)
  return vim.fs.find(names, {
    upward = true,
    type = "file",
    path = start or vim.fn.getcwd(),
    limit = 1,
  })[1]
end

local function find_up_dir(names, start)
  return vim.fs.find(names, {
    upward = true,
    type = "directory",
    path = start or vim.fn.getcwd(),
    limit = 1,
  })[1]
end

local function find_any(pattern, start)
  local matches = vim.fn.globpath(start or vim.fn.getcwd(), pattern, false, true)
  return #matches > 0
end

local function task(name, cmd, cwd, tags)
  return {
    name = name,
    tags = tags,
    builder = function()
      return {
        cmd = cmd,
        cwd = cwd,
        components = { "default" },
      }
    end,
  }
end

---@type overseer.TemplateFileProvider
return {
  generator = function(opts)
    local cwd = root(opts)
    local tasks = {}

    if
      executable("docker")
      and find_up({
        "compose.yaml",
        "compose.yml",
        "docker-compose.yaml",
        "docker-compose.yml",
      }, opts.dir)
    then
      vim.list_extend(tasks, {
        task("devops: docker compose ps", { "docker", "compose", "ps" }, cwd, { overseer.TAG.RUN }),
        task("devops: docker compose up", { "docker", "compose", "up" }, cwd, { overseer.TAG.RUN }),
        task("devops: docker compose up -d", { "docker", "compose", "up", "-d" }, cwd, { overseer.TAG.RUN }),
        task("devops: docker compose down", { "docker", "compose", "down" }, cwd, { overseer.TAG.CLEAN }),
        task(
          "devops: docker compose logs",
          { "docker", "compose", "logs", "-f", "--tail=200" },
          cwd,
          { overseer.TAG.RUN }
        ),
      })
    end

    if executable("terraform") and find_any("**/*.tf", cwd) then
      vim.list_extend(tasks, {
        task("devops: terraform init", { "terraform", "init" }, cwd, { overseer.TAG.BUILD }),
        task("devops: terraform fmt", { "terraform", "fmt", "-recursive" }, cwd, { overseer.TAG.BUILD }),
        task("devops: terraform validate", { "terraform", "validate" }, cwd, { overseer.TAG.TEST }),
        task("devops: terraform plan", { "terraform", "plan" }, cwd, { overseer.TAG.TEST }),
      })
    end

    if executable("kubectl") then
      vim.list_extend(tasks, {
        task("devops: kubectl current-context", { "kubectl", "config", "current-context" }, cwd, { overseer.TAG.RUN }),
        task("devops: kubectl get pods -A", { "kubectl", "get", "pods", "-A" }, cwd, { overseer.TAG.RUN }),
        task("devops: kubectl get services -A", { "kubectl", "get", "services", "-A" }, cwd, { overseer.TAG.RUN }),
      })
    end

    if executable("helm") then
      vim.list_extend(tasks, {
        task("devops: helm list -A", { "helm", "list", "-A" }, cwd, { overseer.TAG.RUN }),
        task("devops: helm repo update", { "helm", "repo", "update" }, cwd, { overseer.TAG.BUILD }),
      })
    end

    if executable("actionlint") and find_up_dir({ ".github/workflows", "workflows" }, opts.dir) then
      table.insert(tasks, task("quality: actionlint", { "actionlint" }, cwd, { overseer.TAG.TEST }))
    end

    if
      executable("ansible-lint") and (find_any("**/playbook*.yml", cwd) or find_any("**/roles/**/tasks/*.yml", cwd))
    then
      table.insert(tasks, task("quality: ansible-lint", { "ansible-lint" }, cwd, { overseer.TAG.TEST }))
    end

    if executable("shellcheck") and find_any("**/*.sh", cwd) then
      table.insert(
        tasks,
        task("quality: shellcheck all sh", { "fish", "-lc", "shellcheck **/*.sh" }, cwd, { overseer.TAG.TEST })
      )
    end

    return tasks
  end,
}
