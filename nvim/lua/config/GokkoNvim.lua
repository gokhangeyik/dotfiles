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
  -- vim.api.nvim_create_user_command("MasonInstallAll", function()
  --   local packages = table.concat(_GokkoNvim.tools, " ")
  --   vim.cmd("MasonInstall " .. packages)
  -- end, {})
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

_GokkoNvim.get_conda_envs = function()
  local conda_envs = {}
  local home = os.getenv("HOME")
  local conda_path = home .. "/.conda/envs"
  local ok, _ = vim.loop.fs_stat(conda_path)
  if not ok then
    return conda_envs
  end
  local env_names = vim.fn.readdir(conda_path)
  for _, env_name in ipairs(env_names) do
    local python_path = conda_path .. "/" .. env_name .. "/bin/python"
    local ok, _ = vim.loop.fs_stat(python_path)
    if ok then
      conda_envs[env_name] = conda_path .. "/" .. env_name
    end
  end
  return conda_envs
end

_GokkoNvim.get_pyenv_venvs = function()
  local venvs = {}
  local handle = io.popen("command -v pyenv")
  if not handle then
    return venvs
  end
  local result = handle:read("*a")
  handle:close()
  if result == "" then
    return venvs
  end
  local handle = io.popen("pyenv virtualenvs --bare --skip-aliases")
  if not handle then
    return venvs
  end
  local output = handle:read("*a")
  handle:close()
  for venv in output:gmatch("[^\r\n]+") do
    local clean_venv = venv:gsub("envs/", "")
    local pyenv_path = os.getenv("HOME") .. "/.pyenv/versions/" .. venv
    venvs[clean_venv] = pyenv_path
  end
  return venvs
end

_GokkoNvim.run_conda = function(env_name)
  env_name = env_name or nil
  if env_name ~= nil then
    local conda_envs = _GokkoNvim.get_conda_envs()
    local python_path = conda_envs[env_name] .. "/bin/python"
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == "basedpyright" then
        vim.notify("Activating Conda Venv: " .. env_name, vim.log.levels.INFO)
        client.config.settings = client.config.settings or {}
        client.config.settings.python = client.config.settings.python or {}
        client.config.settings.python.pythonPath = python_path
        vim.cmd("LspRestart " .. client.id)
        vim.notify("Activated Conda Venv: " .. env_name, vim.log.levels.INFO)
        return
      end
    end
    vim.notify("Basedpyright LSP client not found!", vim.log.levels.WARN)
  end
end

_GokkoNvim.activate_pyenv = function(env_name)
  env_name = env_name or nil
  if env_name ~= nil then
    local pyenv_envs = _GokkoNvim.get_pyenv_venvs()
    local python_path = pyenv_envs[env_name] .. "/bin/python"
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == "basedpyright" then
        vim.notify("Activating Pyenv Venv: " .. env_name, vim.log.levels.INFO)
        client.config.settings = client.config.settings or {}
        client.config.settings.python = client.config.settings.python or {}
        client.config.settings.python.pythonPath = python_path
        vim.cmd("LspRestart " .. client.id)
        vim.notify("Activated Pyenv Venv: " .. env_name, vim.log.levels.INFO)
        return
      end
    end
    vim.notify("Basedpyright LSP client not found!", vim.log.levels.WARN)
  end
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
