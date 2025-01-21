local lsp = {
  -- pyright = {
  --   filetypes = { "python" },
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         diagnosticMode = "workspace",
  --         useLibraryCodeForTypes = true,
  --         -- ignore = { "*" },
  --       },
  --     },
  --   },
  -- },
  -- ruff = {
  --   filetypes = { "python" },
  --   -- cmd_env = { RUFF_TRACE = "messages" },
  --   init_options = {
  --     lint = {
  --       enable = true,
  --     },
  --     settings = {
  --       logLevel = "error",
  --     },
  --   },
  -- },

  basedpyright = {
    filetypes = { "python" },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "standard",
          -- stubPath = "typings",
          -- ignore = { "*" },
        },
      },
    },
  },
}

local tools = {
  "black",
  "isort",
}

local treesitter = {
  "python",
  "ninja",
  "rst",
}
local lsp_overrides = {
  -- basedpyright = function(client)
  --   client.server_capabilities.renameProvider = false
  --   client.server_capabilities.definitionProvider = false
  --   client.server_capabilities.referencesProvider = true
  --   client.server_capabilities.documentFormattingProvider = false
  --   client.server_capabilities.documentRangeFormattingProvider = false
  --   client.server_capabilities.documentSymbolProvider = false
  --   client.server_capabilities.workspaceSymbolProvider = false
  --   client.server_capabilities.codeActionProvider = false
  --   client.server_capabilities.completionProvider = false
  --   client.server_capabilities.signatureHelpProvider = false
  --   client.server_capabilities.hoverProvider = true
  --   client.handlers["textDocument/publishDiagnostics"] = function() end
  --   return client
  -- end,

  -- ruff = function(client)
  --   -- client.server_capabilities.hoverProvider = false
  --   return client
  -- end,
}
-- Language specific plugins
return {
  lsp = lsp or {},
  lsp_overrides = lsp_overrides or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {
    -- {
    --   "linux-cultist/venv-selector.nvim",
    --   branch = "regexp",
    --   ft = "python",
    --   dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python" },
    --   opts = {},
    --   keys = {
    --     { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Virtualenv Select" },
    --     { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Virtualenv Select from Cached" },
    --   },
    -- },
  },
}
