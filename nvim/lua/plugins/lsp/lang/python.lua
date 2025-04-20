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
  --   cmd_env = { RUFF_TRACE = "messages" },
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
        disableOrganizeImports = false,
        analysis = {
          autoSearchPaths = true,
          -- diagnosticMode = "openFilesOnly",
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
local lang_plugins = {
  {
    "benomahony/uv.nvim",
    ft = { "python" },
    -- event = "VeryLazy",
    opts = {
      -- Auto-activate virtual environments when found
      auto_activate_venv = true,

      -- Auto commands for directory changes
      auto_commands = true,

      -- Integration with snacks picker
      picker_integration = true,

      -- Keymaps to register (set to false to disable)
      keymaps = {
        prefix = "<leader>x", -- Main prefix for uv commands
        commands = true, -- Show uv commands menu (<leader>x)
        run_file = true, -- Run current file (<leader>xr)
        run_selection = true, -- Run selected code (<leader>xs)
        run_function = true, -- Run function (<leader>xf)
        venv = true, -- Environment management (<leader>xe)
        init = true, -- Initialize uv project (<leader>xi)
        add = true, -- Add a package (<leader>xa)
        remove = true, -- Remove a package (<leader>xd)
        sync = true, -- Sync packages (<leader>xc)
      },

      -- Execution options
      execution = {
        -- Python run command template
        run_command = "uv run python",

        -- Show output in notifications
        notify_output = true,

        -- Notification timeout in ms
        notification_timeout = 10000,
      },
    },
  },
}
-- Language specific plugins
return {
  lsp = lsp or {},
  lsp_overrides = lsp_overrides or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = lang_plugins or {},
}
