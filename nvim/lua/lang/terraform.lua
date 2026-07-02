local lsp = {
  tofu_ls = {
    cmd = { "tofu-ls", "serve" },
    filetypes = { "terraform", "hcl", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
  },
}

local tools = {
  "tofu-ls",
  "tflint",
}

local treesitter = {
  "terraform",
  "hcl",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
