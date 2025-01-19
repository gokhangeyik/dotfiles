local lsp = {
  -- bashls = {
  --   -- cmd = {...},
  --   filetypes = { "sh", "bash" },
  --   -- capabilities = {},
  --   settings = {},
  -- },
}

local tools = {}

local treesitter = {
  "markdown",
  "markdown_inline",
}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {

    {
      "OXY2DEV/markview.nvim",
      lazy = true, -- Recommended
      ft = { "markdown", "codecompanion", "Avante" }, -- If you decide to lazy-load anyway
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        -- "nvim-tree/nvim-web-devicons"
      },
    },
  },
}
