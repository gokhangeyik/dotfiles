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

_GokkoNvim.async = function(func)
  vim.defer_fn(func, 1500)
end

_GokkoNvim.load_dependencies = function()
  local config_path = vim.fn.stdpath("config")
  local scandir = vim.uv.fs_scandir(config_path .. "/lua/plugins/lang")
  if scandir then
    while true do
      local file, t = vim.uv.fs_scandir_next(scandir)
      if not file then
        break
      end
      if t == "file" and file:match("%.lua$") then
        local module_name = file:sub(1, -5)
        local lang_module = require("plugins.lang." .. module_name)
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

_GokkoNvim.mason_auto_installer = function()
  local mason_registry = require("mason-registry")
  for _, package_name in ipairs(_GokkoNvim.tools) do
    local ok, pkg = pcall(mason_registry.get_package, package_name)
    if ok then
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end
end

_GokkoNvim.lsp_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

  for lsp_name, _ in pairs(_GokkoNvim.lsp) do
    _GokkoNvim.lsp[lsp_name]["capabilities"] =
      vim.tbl_deep_extend("force", capabilities, _GokkoNvim.lsp[lsp_name]["capabilities"] or {})
    vim.lsp.config(lsp_name, _GokkoNvim.lsp[lsp_name])
  end
  vim.lsp.enable(vim.tbl_keys(_GokkoNvim.lsp))

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("gokko-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end
      map("<leader>lr", vim.lsp.buf.rename, "Rename")
      map("<leader>ca", vim.lsp.buf.code_action, "Code Actions", { "n", "x" })

      -- LSP Config Exceptions
      local client = vim.lsp.get_client_by_id(event.data.client_id) or {}
      if _GokkoNvim.func_exist(_GokkoNvim.lsp_overrides[client.name]) then
        local func = _GokkoNvim.lsp_overrides[client.name]
        client = func(client)
      end
      -- /LSP Config Exceptions
    end,
  })
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

_GokkoNvim.firstboot = function()
  local data_path = vim.fn.stdpath("data")
  local firstboot_file = data_path .. "/GokkoNvim.firstboot"
  if vim.fn.filereadable(firstboot_file) == 0 then
    local fp = io.open(firstboot_file, "w")
    if fp then
      fp:write("GokkoNvim Firstboot Complete!")
      fp:close()
    end
    return true
  else
    return false
  end
end

_GokkoNvim.init = function()
  if _GokkoNvim.firstboot() then
    vim.notify("GokkoNvim: Please wait while first-time setup completes...")
    vim.defer_fn(function()
      vim.cmd("MasonUpdate")
      vim.notify("GokkoNvim: First-time setup complete! Please restart Neovim!")
    end, 10000)
  else
    _GokkoNvim.async(_GokkoNvim.mason_auto_installer)
    _GokkoNvim.async(_GokkoNvim.lsp_config)
  end
end

return _GokkoNvim
