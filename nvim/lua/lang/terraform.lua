local lsp = {
  terraform_lsp = {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "hcl", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
  },
}

local tools = {
  "terraform-ls",
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
