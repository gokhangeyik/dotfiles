local lsp = {
  helm_ls = {
    filetypes = { "helm" },
  },
}

local tools = {
}

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
      ft = { "helkm" },
    },
  },
}
