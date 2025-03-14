return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    -- lazy = false,
    opts = {
      ui = {
        check_outdated_packages_on_open = true,
        border = "none",
        width = 0.8,
        height = 0.9,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy = false,
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function()
      vim.schedule(function()
        _GokkoNvim.async(_GokkoNvim.init_deps)
        if not _GokkoNvim.lsp then
          _GokkoNvim.init_deps()
        end
      end)
      -- _GokkoNvim.async(_GokkoNvim.init_deps)
      -- if not _GokkoNvim.lsp then
      --   _GokkoNvim.init_deps()
      -- end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local ensure_installed = vim.tbl_deep_extend("force", vim.tbl_keys(_GokkoNvim.lsp), {})
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = _GokkoNvim.lsp[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
      _GokkoNvim.async(_GokkoNvim.mason_tools_installer)
    end,
  },
}
