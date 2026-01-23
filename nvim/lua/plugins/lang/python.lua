local lsp = {
  ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      lint = {
        enable = false,
      },
      settings = {
        lint = {
          select = { "ALL" },
          ignore = {},
          fixable = { "ALL" },
          unfixable = {},
        },
        logLevel = "error",
        configurationPreference = "filesystemFirst",
        lineLength = 100,
      },
    },
    on_new_config = function(config, root_dir)
      -- Try to find ruff in virtual environment first
      local venv_ruff = root_dir .. "/.venv/bin/ruff"
      if vim.fn.executable(venv_ruff) == 1 then
        config.cmd = { venv_ruff, "server" }
      else
        -- Fallback to system ruff (from PATH)
        config.cmd = { "ruff", "server" }
      end
    end,
  },
  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git",
    },
    settings = {
      basedpyright = {
        disableOrganizeImports = true, -- Let ruff handle imports
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "standard",
          -- Focus only on type checking
          -- diagnosticSeverityOverrides = {
          --   -- Lower severity for style issues which ruff will handle
          --   reportMissingImports = "warning",
          --   reportUnusedImport = "none",
          --   reportUnusedVariable = "none",
          --   reportGeneralTypeIssues = "error",
          --   -- reportMissingTypeStubs = "none",
          -- },
        },
      },
    },
    on_new_config = function(config, root_dir)
      -- Try to find basedpyright in virtual environment first
      local venv_basedpyright = root_dir .. "/.venv/bin/basedpyright-langserver"
      if vim.fn.executable(venv_basedpyright) == 1 then
        config.cmd = { venv_basedpyright, "--stdio" }
      else
        -- Fallback to system basedpyright (from PATH)
        config.cmd = { "basedpyright-langserver", "--stdio" }
      end
    end,
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
    client.server_capabilities.codeActionProvider = true
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

local tools = { "basedpyright", "ruff", "bandit", "pyproject-fmt", "debugpy" }

local treesitter = {
  "python",
  "ninja",
  "rst",
}
local lang_plugins = {
  {
    "benomahony/uv.nvim",
    -- ft = { "python" },
    event = "VeryLazy",
    -- lazy = true,
    opts = {
      auto_activate_venv = true,
      auto_commands = true,
      picker_integration = true,
      keymaps = {
        prefix = "<leader>ve", -- Main prefix for uv commands
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
      execution = {
        run_command = "uv run python",
        notify_output = true,
        notification_timeout = 10000,
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-python").setup("python3")
    end,
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
