local lsp = {
  terraformls = {
    filetypes = { "terraform", "hcl" },
  },
}

local tools = {
  "tflint",
}

local treesitter = {
  "terraform",
  "hcl",
}

-- Language spesific plugins
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {},
}
