return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  enabled = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "mocha",
        dark = "mocha",
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.surface0, blend = 100 },
          CursorLineNr = { fg = colors.peach, style = { "bold" } },
          LineNr = { fg = colors.overlay0 },
        }
      end,
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
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
        -- functions = {},
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
      default_integrations = false,
      integrations = {
        diffview = true,
        cmp = false,
        gitsigns = true,
        grug_far = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = false,
          indentscope_color = "",
        },
        mason = true,
        fzf = false,
        fidget = true,
        harpoon = true,
        markdown = true,
        neogit = true,
        noice = true,
        neotree = false,
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
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        lsp_trouble = false,
        which_key = true,
        snacks = true,
        blink_cmp = true,
      },
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
