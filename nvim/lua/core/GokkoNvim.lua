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

_GokkoNvim.register_keymaps = function(keys)
  for _, map in ipairs(keys) do
    local opts = { desc = map.desc }
    if map.silent ~= nil then
      opts.silent = map.silent
    end
    if map.noremap ~= nil then
      opts.noremap = map.noremap
    else
      opts.noremap = true
    end
    if map.expr ~= nil then
      opts.expr = map.expr
    end

    local mode = map.mode or "n"
    vim.keymap.set(mode, map[1], map[2], opts)
  end
end

_GokkoNvim.install_treesitter_parsers = function()
  local ts = require("nvim-treesitter")
  ts.install(_GokkoNvim.treesitter)
  _GokkoNvim.async(ts.update, 500)
end

_GokkoNvim.load_dependencies = function()
  local config_path = vim.fn.stdpath("config")
  local scandir = vim.uv.fs_scandir(config_path .. "/lua/lang")
  if scandir then
    while true do
      local file, t = vim.uv.fs_scandir_next(scandir)
      if not file then
        break
      end
      if t == "file" and file:match("%.lua$") then
        local file_path = config_path .. "/lua/lang/" .. file
        local fp = io.open(file_path, "r")
        if fp then
          local first_line = fp:read("*line")
          fp:close()
          if first_line and first_line:match("^%-%-[%s]*disabled") then
            goto continue
          end
        end
        local module_name = file:sub(1, -5)
        local lang_module = require("lang." .. module_name)
        _GokkoNvim.lsp = vim.tbl_deep_extend("force", _GokkoNvim.lsp or {}, lang_module.lsp or {})
        _GokkoNvim.lsp_overrides =
          vim.tbl_deep_extend("force", _GokkoNvim.lsp_overrides or {}, lang_module.lsp_overrides or {})
        _GokkoNvim.tools = _GokkoNvim.remove_dups(vim.list_extend(_GokkoNvim.tools or {}, lang_module.tools or {}))
        _GokkoNvim.treesitter =
          _GokkoNvim.remove_dups(vim.list_extend(_GokkoNvim.treesitter or {}, lang_module.treesitter or {}))
        ::continue::
      end
    end
  end
end

_GokkoNvim.mason_auto_installer = function()
  local mason_registry = require("mason-registry")
  local to_install = {}

  for _, package_name in ipairs(_GokkoNvim.tools) do
    local ok, pkg = pcall(mason_registry.get_package, package_name)
    if ok then
      if not pkg:is_installed() then
        table.insert(to_install, { name = package_name, pkg = pkg })
      end
    else
      vim.notify("GokkoNvim: Mason package '" .. package_name .. "' not found in registry", vim.log.levels.WARN)
    end
  end

  if #to_install > 0 then
    vim.notify("GokkoNvim: Installing " .. #to_install .. " Mason package(s)...", vim.log.levels.INFO)

    for _, item in ipairs(to_install) do
      local install_ok, install_err = pcall(function()
        item.pkg:install()
      end)

      if install_ok then
        item.pkg:once("install:success", function()
          vim.notify("GokkoNvim: Successfully installed '" .. item.name .. "'", vim.log.levels.INFO)
        end)

        item.pkg:once("install:failed", function()
          vim.notify("GokkoNvim: Failed to install '" .. item.name .. "'", vim.log.levels.ERROR)
        end)
      else
        vim.notify(
          "GokkoNvim: Failed to install Mason package '" .. item.name .. "': " .. (install_err or "Unknown error"),
          vim.log.levels.ERROR
        )
      end
    end
  end
end

_GokkoNvim.lsp_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
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

      local client = vim.lsp.get_client_by_id(event.data.client_id) or {}
      if _GokkoNvim.func_exist(_GokkoNvim.lsp_overrides[client.name]) then
        local func = _GokkoNvim.lsp_overrides[client.name]
        client = func(client)
      end
    end,
  })
end

_GokkoNvim.is_firstboot = function()
  local data_path = vim.fn.stdpath("data")
  local firstboot_file = data_path .. "/GokkoNvim.firstboot"
  return vim.fn.filereadable(firstboot_file) == 0
end

_GokkoNvim.create_firstboot_marker = function()
  local data_path = vim.fn.stdpath("data")
  local firstboot_file = data_path .. "/GokkoNvim.firstboot"
  local fp = io.open(firstboot_file, "w")
  if fp then
    fp:write("GokkoNvim Firstboot Complete!")
    fp:close()
  end
end

_GokkoNvim.init = function()
  if _GokkoNvim.is_firstboot() then
    _GokkoNvim.treesitter = {}
    _GokkoNvim.lsp = {}
    _GokkoNvim.tools = {}

    vim.defer_fn(function()
      vim.cmd("MasonUpdate")

      _GokkoNvim.create_firstboot_marker()

      vim.notify("First boot is complete, will be restarted in 3 seconds.", vim.log.levels.INFO)
      vim.defer_fn(function()
        vim.cmd("restart +qall!")
      end, 3000)
    end, 1000)
  else
    _GokkoNvim.async(_GokkoNvim.install_treesitter_parsers, 100)
    _GokkoNvim.async(_GokkoNvim.lsp_config, 100)
    _GokkoNvim.async(_GokkoNvim.mason_auto_installer, 400)
  end
end

return _GokkoNvim
