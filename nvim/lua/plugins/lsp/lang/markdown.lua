local lsp = {
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
  },
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
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        code = {
          sign = false,
          width = "full",
          right_pad = 1,
        },
        heading = {
          sign = true,
          icons = {},
        },
        checkbox = {
          enabled = true,
        },
      },
      ft = { "markdown", "norg", "rmd", "org", "codecompanion", "Avante" },
      config = function(_, opts)
        require("render-markdown").setup(opts)
        Snacks.toggle({
          name = "Render Markdown",
          get = function()
            return require("render-markdown.state").enabled
          end,
          set = function(enabled)
            local m = require("render-markdown")
            if enabled then
              m.enable()
            else
              m.disable()
            end
          end,
        }):map("<leader>um")
      end,
    },
  },
}
