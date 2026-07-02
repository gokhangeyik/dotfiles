local lsp = {
  bashls = {
    cmd = { "bash-language-server", "start" },
    settings = {
      bashIde = {

        globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
      },
    },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
  },
}

local tools = {
  "bash-language-server",
  "shfmt",
}

local treesitter = {
  "bash",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
