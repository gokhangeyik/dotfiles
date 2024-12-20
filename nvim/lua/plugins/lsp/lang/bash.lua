local lsp = {
  bashls = {
    -- cmd = {...},
    filetypes = { "sh", "bash" },
    -- capabilities = {},
    settings = {},
  },
}

local tools = {
  "shfmt",
}

local treesitter = {
  "bash",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {},
}
