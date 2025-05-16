local lsp = {
  ruff = {
    filetypes = { "python" },
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      lint = {
        enable = false,
      },
      settings = {
        lint = {
          select = { "ALL" },
          ignore = {
            -- D203 and D211 conflict, pick D211
            "D203",
            -- D212 and D213 conflict, pick D212
            "D213",
            -- Possbile conflict with formatter
            "COM812",
          },
        },
        logLevel = "error",
        configurationPreference = "filesystemFirst",
        lineLength = 100,
      },
    },
  },
  basedpyright = {
    filetypes = { "python" },
    settings = {
      basedpyright = {
        disableOrganizeImports = true, -- Let ruff handle imports
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "standard",
          -- Focus only on type checking
          diagnosticSeverityOverrides = {
            -- Lower severity for style issues which ruff will handle
            reportMissingImports = "warning",
            reportUnusedImport = "none",
            reportUnusedVariable = "none",
            reportGeneralTypeIssues = "error",
          },
        },
      },
    },
  },
}

local lsp_overrides = {
  basedpyright = function(client)
    -- Limit basedpyright to just type checking capabilities
    client.server_capabilities.renameProvider = true
    client.server_capabilities.definitionProvider = true
    client.server_capabilities.referencesProvider = true
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.server_capabilities.codeActionProvider = false
    client.server_capabilities.hoverProvider = true
    return client
  end,

  ruff = function(client)
    -- Enable all linting features in ruff
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.codeActionProvider = true
    client.server_capabilities.documentFormattingProvider = true
    return client
  end,
}

local tools = {}

local treesitter = {
  "python",
  "ninja",
  "rst",
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
