local lsp = {}

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
      lazy = true,
      ft = { "markdown", "codecompanion", "Avante" }, -- If you decide to lazy-load anyway
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion", "Avante" },
          buf_ignore = {},
        },
      },
    },
    -- {
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   lazy = false,
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    -- },
  },
}
