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
  lang_plugins = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        render_modes = { "n", "c", "t" },
        anti_conceal = {
          enabled = false,
        },
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
          unchecked = { icon = "󰄰 " },
          checked = { icon = "󰄴 " },
          -- custom = { todo = { rendered = "◯ " } },
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
