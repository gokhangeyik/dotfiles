return {
  { "L3MON4D3/LuaSnip", keys = {} },
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
    },
    version = "*",
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "luasnip" },
        cmdline = {
          enabled = true,
          keymap = {
            preset = "inherit",
          },
          completion = {
            menu = {
              auto_show = true,
            },
          },
        },
        keymap = { preset = "super-tab" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "avante" },
          providers = {
            avante = {
              module = "blink-cmp-avante",
              name = "Avante",
              opts = {
                -- options for blink-cmp-avante
              },
            },
            lsp = {
              name = "LSP",
              module = "blink.cmp.sources.lsp",
              opts = {}, -- Passed to the source directly, varies by source
              --- NOTE: All of these options may be functions to get dynamic behavior
              --- See the type definitions for more information
              enabled = true, -- Whether or not to enable the provider
              async = true, -- Whether we should wait for the provider to return before showing the completions
              timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
              transform_items = nil, -- Function to transform the items before they're returned
              should_show_items = true, -- Whether or not to show the items
              max_items = nil, -- Maximum number of items to display in the menu
              min_keyword_length = 2, -- Minimum number of characters in the keyword to trigger the provider
              -- If this provider returns 0 items, it will fallback to these providers.
              -- If multiple providers falback to the same provider, all of the providers must return 0 items for it to fallback
              fallbacks = {},
              score_offset = 0, -- Boost/penalize the score of the items
              override = nil, -- Override
            },
          },
        },
        completion = {
          menu = {
            border = nil,
            winblend = 5,
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                -- { "source_name" },
              },
            },
          },
          documentation = {
            auto_show = false,
            treesitter_highlighting = true,
            window = {
              -- border = nil,
              winblend = 10,
              scrollbar = false,
            },
          },
        },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },
        signature = { enabled = false, window = {
          scrollbar = false,
        } },
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    -- opts_extend = { "sources.default" },
  },
}
