local lsp = {
  dockerls = {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile" },
    root_markers = { "Dockerfile" },
  },
  docker_compose_language_service = {
    cmd = { "docker-compose-langserver", "start", "--stdio" },
    filetypes = { "yaml.docker-compose" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
    settings = {},
  },
}

local tools = {
  "docker-language-server",
  "docker-compose-language-service",
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
