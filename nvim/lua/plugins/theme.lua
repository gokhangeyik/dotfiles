-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   lazy = false,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "mocha", -- latte, frappe, macchiato, mocha
--       background = { -- :h background
--         light = "mocha",
--         dark = "mocha",
--       },
--       custom_highlights = function(colors)
--         return {
--           CursorLine = { bg = colors.surface0, blend = 100 },
--           CursorLineNr = { fg = colors.peach, style = { "bold" } },
--           LineNr = { fg = colors.overlay0 },
--         }
--       end,
--       transparent_background = false, -- disables setting the background color.
--       show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--       term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--       dim_inactive = {
--         enabled = true, -- dims the background color of inactive window
--         shade = "dark",
--         percentage = 0.95, -- percentage of the shade to apply to the inactive window
--       },
--       no_italic = false, -- Force no italic
--       no_bold = false, -- Force no bold
--       no_underline = false, -- Force no underline
--       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--         comments = { "italic" }, -- Change the style of comments
--         conditionals = { "italic" },
--         loops = { "italic" },
--         -- functions = {},
--         -- keywords = {},
--         -- strings = {},
--         -- variables = {},
--         -- numbers = {},
--         -- booleans = {},
--         -- properties = {},
--         -- types = {},
--         -- operators = {},
--         -- miscs = {}, -- Uncomment to turn off hard-coded styles
--       },
--       color_overrides = {
--         -- all = {
--         --   base = "#181825",
--         -- },
--       },
--       default_integrations = false,
--       integrations = {
--         diffview = true,
--         cmp = false,
--         gitsigns = true,
--         grug_far = true,
--         treesitter = true,
--         notify = true,
--         mini = {
--           enabled = false,
--           indentscope_color = "",
--         },
--         mason = true,
--         fzf = false,
--         fidget = true,
--         harpoon = true,
--         markdown = true,
--         neogit = true,
--         noice = true,
--         neotree = false,
--         native_lsp = {
--           enabled = true,
--           virtual_text = {
--             errors = { "italic" },
--             hints = { "italic" },
--             warnings = { "italic" },
--             information = { "italic" },
--             ok = { "italic" },
--           },
--           underlines = {
--             errors = { "underline" },
--             hints = { "underline" },
--             warnings = { "underline" },
--             information = { "underline" },
--             ok = { "underline" },
--           },
--           inlay_hints = {
--             background = true,
--           },
--         },
--         telescope = {
--           enabled = true,
--           style = "nvchad",
--         },
--         lsp_trouble = false,
--         which_key = true,
--         snacks = true,
--         blink_cmp = true,
--       },
--       compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
--     })
--
--     -- setup must be called before loading
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
return {
  "folke/tokyonight.nvim",
  -- event = "VeryLazy",
  lazy = false,
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
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

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

      cache = true, -- When set to true, the theme will be cached for better performance

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
