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

_GokkoNvim.async = function(func, timeout)
  vim.defer_fn(func, timeout)
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
        _GokkoNvim.lang_plugins = vim.list_extend(_GokkoNvim.lang_plugins or {}, lang_module.lang_plugins or {})
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

-- Borrowed from: https://github.com/adibhanna/nvim/blob/main/lua/core/lsp.lua
local restart_lsp = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd("edit")
  end, 100)
end

-- Borrowed from: https://github.com/adibhanna/nvim/blob/main/lua/core/lsp.lua
local lsp_status = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    print("󰅚 No LSP clients attached")
    return
  end

  print("󰒋 LSP Status for buffer " .. bufnr .. ":")
  print("─────────────────────────────────")

  for i, client in ipairs(clients) do
    print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
    print("  Root: " .. (client.config.root_dir or "N/A"))
    ---@diagnostic disable-next-line: undefined-field
    print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps ~= nil then
      if caps.completionProvider then
        table.insert(features, "completion")
      end
      if caps.hoverProvider then
        table.insert(features, "hover")
      end
      if caps.definitionProvider then
        table.insert(features, "definition")
      end
      if caps.referencesProvider then
        table.insert(features, "references")
      end
      if caps.renameProvider then
        table.insert(features, "rename")
      end
      if caps.codeActionProvider then
        table.insert(features, "code_action")
      end
      if caps.documentFormattingProvider then
        table.insert(features, "formatting")
      end
    end

    print("  Features: " .. table.concat(features, ", "))
    print("")
  end
end

_GokkoNvim.lsp_utils = function()
  vim.api.nvim_create_user_command("LspRestart", function()
    restart_lsp()
  end, {})
  vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })
end

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
    vim.cmd("MasonUpdate")
    vim.defer_fn(function()
      vim.notify("GokkoNvim: First-time setup complete! Please restart Neovim!")
    end, 3000)
  else
    _GokkoNvim.async(_GokkoNvim.lsp_config, 1000)
    _GokkoNvim.async(_GokkoNvim.lsp_utils, 2000)
    _GokkoNvim.async(_GokkoNvim.mason_auto_installer, 3000)
  end
end

return _GokkoNvim
