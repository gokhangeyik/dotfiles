local lsp = {
  dockerls = {
    -- cmd = {...},
    filetypes = { "dockerfile" },
    -- capabilities = {},
    settings = {},
  },
  docker_compose_language_service = {
    -- cmd = {...},
    filetypes = { "yaml.docker-compose" },
    -- capabilities = {},
    settings = {},
  },
}

local tools = {
  "hadolint",
}

local treesitter = { "dockerfile" }
vim.filetype.add({
filename = {
["docker-compose.yml"] = "yaml.docker-compose",
["docker-compose.yaml"] = "yaml.docker-compose",
["compose.yml"] = "yaml.docker-compose",
["compose.yaml"] = "yaml.docker-compose",
},
})
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {},
}
