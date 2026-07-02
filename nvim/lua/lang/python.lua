local lsp = {
  ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
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
      local venv_ruff = root_dir .. "/.venv/bin/ruff"
      if vim.fn.executable(venv_ruff) == 1 then
        config.cmd = { venv_ruff, "server" }
      else
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
        disableOrganizeImports = true,
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "standard",
        },
      },
    },
    on_new_config = function(config, root_dir)
      local venv_basedpyright = root_dir .. "/.venv/bin/basedpyright-langserver"
      if vim.fn.executable(venv_basedpyright) == 1 then
        config.cmd = { venv_basedpyright, "--stdio" }
      else
        config.cmd = { "basedpyright-langserver", "--stdio" }
      end
    end,
  },
}

local lsp_overrides = {
  basedpyright = function(client)
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
return {
  lsp = lsp or {},
  lsp_overrides = lsp_overrides or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
