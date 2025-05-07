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
      _GokkoNvim.async(_GokkoNvim.init_deps)
      if not _GokkoNvim.lsp then
        _GokkoNvim.init_deps()
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }
      local ensure_installed = vim.tbl_deep_extend("force", vim.tbl_keys(_GokkoNvim.lsp), {})
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = ensure_installed,
      })
      _GokkoNvim.async(_GokkoNvim.mason_tools_installer)
    end,
  },
}
