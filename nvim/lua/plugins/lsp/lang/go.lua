local lsp = {
  golangci_lint_ls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
}

local tools = {
  "goimports",
  "gofumpt",
  "gomodifytags",
  "impl",
  "delve",
  "golanci-lint",
  "djlint",
}

local treesitter = {
  "go",
  "gomod",
  "gowork",
  "gosum",
  "gotmpl",
}

local lsp_overrides = {
  -- gopls = function(client)
  --   local semantic = client.config.capabilities.textDocument.semanticTokens or {}
  --   client.server_capabilities.semanticTokensProvider = {
  --     full = true,
  --     legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
  --     range = true,
  --   }
  --   return client
  -- end,
}
-- Language spesific plugins
return {
  lsp = lsp or {},
  lsp_overrides = lsp_overrides or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {},
}
