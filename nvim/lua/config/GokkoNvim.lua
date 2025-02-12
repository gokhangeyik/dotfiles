local _GokkoNvim = _GokkoNvim or {}
_GokkoNvim.remove_dups = function(list)
  local hash = {}
  local res = {}
  for _, v in ipairs(list) do
    if not hash[v] then
      res[#res + 1] = v
      hash[v] = true
    end
  end
  return res
end

function _GokkoNvim.func_exist(func)
  return type(func) == "function"
end

_GokkoNvim.init_deps = function()
  local config_path = vim.fn.stdpath("config")
  local scandir = vim.uv.fs_scandir(config_path .. "/lua/plugins/lsp/lang")
  if scandir then
    while true do
      local file, t = vim.uv.fs_scandir_next(scandir)
      if not file then
        break
      end
      if t == "file" and file:match("%.lua$") then
        local module_name = file:sub(1, -5)
        local lang_module = require("plugins.lsp.lang." .. module_name)
        _GokkoNvim.lsp = vim.tbl_deep_extend("force", _GokkoNvim.lsp or {}, lang_module.lsp or {})
        _GokkoNvim.lsp_overrides =
          vim.tbl_deep_extend("force", _GokkoNvim.lsp_overrides or {}, lang_module.lsp_overrides or {})
        _GokkoNvim.tools = _GokkoNvim.remove_dups(vim.list_extend(_GokkoNvim.tools or {}, lang_module.tools or {}))
        _GokkoNvim.treesitter =
          _GokkoNvim.remove_dups(vim.list_extend(_GokkoNvim.treesitter or {}, lang_module.treesitter or {}))
      end
    end
  end
end

_GokkoNvim.mason_tools_installer = function()
  local mason_registry = require("mason-registry")
  for _, tool_name in ipairs(_GokkoNvim.tools) do
    local ok, tool = pcall(mason_registry.get_package, tool_name)
    if ok then
      if not tool:is_installed() then
        tool:install()
      end
    end
  end
end

_GokkoNvim.async = function(func)
  vim.defer_fn(func, 0)
end

_GokkoNvim.get_python_envs = function()
  local envs = {}

  local home = os.getenv("HOME")
  local conda_path = home .. "/.conda/envs"
  local conda_ok, _ = vim.loop.fs_stat(conda_path)
  if conda_ok then
    local env_names = vim.fn.readdir(conda_path)
    for _, env_name in ipairs(env_names) do
      local python_path = conda_path .. "/" .. env_name .. "/bin/python"
      local ok, _ = vim.loop.fs_stat(python_path)
      if ok then
        envs[env_name] = {
          type = "conda",
          path = conda_path .. "/" .. env_name,
          python_path = python_path,
        }
      end
    end
  end

  local handle = io.popen("command -v pyenv")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result ~= "" then
      local pyenv_handle = io.popen("pyenv virtualenvs --bare --skip-aliases")
      if pyenv_handle then
        local output = pyenv_handle:read("*a")
        pyenv_handle:close()
        for venv in output:gmatch("[^\r\n]+") do
          local clean_venv = venv:gsub("envs/", "")
          local pyenv_path = home .. "/.pyenv/versions/" .. venv
          local python_path = pyenv_path .. "/bin/python"
          envs[clean_venv] = {
            type = "pyenv",
            path = pyenv_path,
            python_path = python_path,
          }
        end
      end
    end
  end

  return envs
end
_GokkoNvim.activate_python_env = function(env_name)
  if not env_name then
    return
  end

  local envs = _GokkoNvim.get_python_envs()
  local env = envs[env_name]

  if not env then
    vim.notify("Environment not found: " .. env_name, vim.log.levels.ERROR)
    return
  end

  -- Update basedpyright
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == "basedpyright" then
      client.config.settings = client.config.settings or {}
      client.config.settings.python = client.config.settings.python or {}
      client.config.settings.python.pythonPath = env.python_path
      vim.cmd("LspRestart " .. client.id)
      break
    end
  end

  -- Update neotest-python
  local neotest = require("neotest")
  local neotest_python = require("neotest-python")
  neotest.setup({
    adapters = {
      neotest_python({
        dap = { justMyCode = false },
        runner = "pytest",
        python = env.python_path,
      }),
    },
  })

  vim.notify(string.format("Activated %s environment: %s", env.type, env_name), vim.log.levels.INFO)
end

_GokkoNvim.float_styler = function()
  vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
      local win_id = vim.api.nvim_get_current_win()
      local win_conf = vim.api.nvim_win_get_config(win_id)

      if win_conf.relative ~= "" then
        local title = win_conf.title
        if title and type(title) == "table" and title[1] and title[1][1] then
          local window_title = title[1][1]

          local config = vim.api.nvim_win_get_config(win_id)
          config.title_pos = "center"
          config.title = { { " " .. window_title .. " ", "FloatTitle" } }
          -- config.relative = "editor"
          vim.api.nvim_win_set_config(win_id, config)
        end
      end
    end,
  })
end
_GokkoNvim.float_styler()

return _GokkoNvim
