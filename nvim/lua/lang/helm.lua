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
    filetypes = { "helm", "yaml.helm-values" },
  },
}

local tools = { "helm-ls" }

local treesitter = {}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
