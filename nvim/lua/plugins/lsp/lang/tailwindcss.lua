local lsp = {
  tailwindcss = {
    filetypes_exclude = { "markdown" },
    -- add additional filetypes to the default_config
    filetypes_include = {},
    -- to fully override the default_config, change the below
    -- filetypes = {}
  },
}

local tools = {}

local treesitter = {}

-- Language spesific plugins
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {},
}
