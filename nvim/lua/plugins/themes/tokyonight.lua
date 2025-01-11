return {
  "folke/tokyonight.nvim",
  -- event = "VeryLazy",
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      ---@class tokyonight.Config
      ---@field on_colors fun(colors: ColorScheme)
      ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)

      style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "normal", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      dim_inactive = false, -- dims inactive windows
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        local prompt = "#2d3149"
        -- highlights.FloatBorder = { bg = colors.bg_dark, fg = colors.bg_dark }
        local titles = {
          Yeet = { fg = colors.orange, bg = colors.bg_dark },
          Harpoon = { fg = colors.orange, bg = colors.bg_dark },
        }

        _GokkoNvim.flat_floats(colors, titles)
        highlights.CursorLine = { bg = colors.bg_dark, blend = 1 }

        highlights.TelescopeNormal = {
          bg = colors.bg_dark,
          fg = colors.fg_dark,
        }
        highlights.TelescopeBorder = {
          bg = colors.bg_dark,
          fg = colors.bg_dark,
        }
        highlights.TelescopePromptNormal = {
          bg = prompt,
        }
        highlights.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        highlights.TelescopePromptTitle = {
          bg = colors.teal,
          fg = colors.bg_dark,
        }
        highlights.TelescopePreviewTitle = {
          bg = colors.magenta2,
          fg = colors.bg_dark,
        }
        highlights.TelescopeResultsTitle = {
          bg = colors.green,
          fg = colors.bg_dark,
        }
      end,

      cache = false, -- When set to true, the theme will be cached for better performance

      ---@type table<string, boolean|{enabled:boolean}>
      plugins = {
        -- enable all plugins when not using lazy.nvim
        -- set to false to manually enable/disable plugins
        all = package.loaded.lazy == nil,
        -- uses your plugin manager to automatically enable needed plugins
        -- currently only lazy.nvim is supported
        auto = true,
        -- add any plugins here that you want to enable
        -- for all possible plugins, see:
        --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
        -- telescope = true,
      },
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
