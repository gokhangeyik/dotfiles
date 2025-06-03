local lsp = {
  helm_ls = {
    cmd = { "helm_ls", "serve" },
    root_markers = { "Chart.yaml" },
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
    filetypes = { "helm" },
  },
}

local tools = { "helm-ls" }

local treesitter = {
  "helm",
}

-- Language spesific plugins
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {
    {
      "towolf/vim-helm",
      ft = { "helm" },
    },
  },
}
