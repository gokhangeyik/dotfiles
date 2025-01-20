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
