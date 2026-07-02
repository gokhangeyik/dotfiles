return {
  enabled = true,
  ft = { "markdown", "norg", "rmd", "org", "codecompanion", "Avante" },
  dependencies = {},
  pack = { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
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
    },
  },

  config = function(opts)
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
}
