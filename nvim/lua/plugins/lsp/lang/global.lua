local treesitter = {
  "bash",
  "regex",
  "c",
  "diff",
  "html",
  "css",
  "lua",
  "luadoc",
  "query",
  "vim",
  "vimdoc",
  "toml",
  "gitignore",
  "gitcommit",
  "git_config",
  "http",
  "graphql",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
