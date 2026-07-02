local lsp = {
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true,
    },
    root_markers = { ".git" },
    settings = {
      json = {
        format = {
          enable = false,
        },
        validate = { enable = true },
      },
    },
  },
}

local tools = { "json-lsp" }

local treesitter = {
  "json5",
  "json",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
