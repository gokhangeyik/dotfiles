local lsp = {
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_markers = { ".git" },
    settings = {
      redhat = { telemetry = { enabled = false } },
    },
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas =
        vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
  },
}

local tools = {
  "yaml-language-server",
  "prettier",
  "prettierd",
}

local treesitter = {
  "yaml",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
