local bin_name = "marksman"
local cmd = { bin_name, "server" }

local lsp = {
  marksman = {
    cmd = cmd,
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
  },
}

local tools = { "marksman" }

local treesitter = {
  "markdown",
  "markdown_inline",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
