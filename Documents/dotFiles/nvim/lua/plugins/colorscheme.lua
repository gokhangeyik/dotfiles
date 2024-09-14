return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    lazy = true,
    opts = {
      floating_border = "on",
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.base },
          CursorLineNr = { fg = colors.peach, style = { "bold" } },
          LineNr = { fg = colors.overlay0 },
        }
      end,
      flavour = "mocha",
      transparent_background = true,
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        harpoon = true,
        indent_blankline = {
          enabled = true,
          scope_color = "peach", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = true,
        },
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   opts = {
  --     transparent = true,
  --     dimInactive = true,
  --     theme = "lotus",
  --   },
  -- },
  -- {
  --   "rose-pine/neovim",
  --   as = "rose-pine",
  --   lazy = false,
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "main",
  --       styles = {
  --         bold = true,
  --         italic = true,
  --         transparency = true,
  --       },
  --     })
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
