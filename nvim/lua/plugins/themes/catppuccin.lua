return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  enabled = true,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      -- background = { -- :h background
      --   light = "mocha",
      --   dark = "mocha",
      -- },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.surface0, blend = 10 },
          CursorLineNr = { fg = colors.peach, style = { "bold" } },
          LineNr = { fg = colors.overlay0 },
          NormalFloat = { bg = colors.mantle },
          FloatTitle = { bg = colors.peach, fg = colors.mantle, bold = true },
          FloatBorder = { bg = colors.mantle, fg = colors.mantle },
          BlinkCmpMenu = { bg = colors.mantle },
          markdownCode = { bg = colors.mantle },
          markdownCodeBlock = { bg = colors.mantle },
        }
      end,
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.95, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        -- keywords = {},
        -- strings = {},
        -- variables = {},
        -- numbers = {},
        -- booleans = {},
        -- properties = {},
        -- types = {},
        -- operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {
        -- all = {
        --   base = "#181825",
        -- },
      },
      default_integrations = true,
      integrations = {
        blink_cmp = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        harpoon = true,
        mason = true,
        mini = {
          enabled = true,
        },
        neotree = true,
        noice = true,
        notifier = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        notify = true,
        treesitter = true,
        ufo = true,
        render_markdown = true,
        snacks = true,
        lsp_trouble = false,
        which_key = false,
      },
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
