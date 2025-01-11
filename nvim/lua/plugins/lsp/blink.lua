return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  enabled = true,
  -- lazy = false, -- lazy loading handled internally
  dependencies = {
    "rafamadriz/friendly-snippets",
    "moyiz/blink-emoji.nvim",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  version = "v0.*",
  config = function()
    require("blink.cmp").setup({
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      keymap = { preset = "super-tab" },
      sources = {
        default = { "lsp", "path", "buffer", "snippets", "emoji" },
        -- optionally disable cmdline completions
        -- cmdline = {},
        providers = {
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
            min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers falback to the same provider, all of the providers must return 0 items for it to fallback
            fallbacks = {},
            score_offset = 0, -- Boost/penalize the score of the items
            override = nil, -- Override
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
        },
      },
      completion = {
        menu = {
          border = "none",
          winblend = 10,
          scrollbar = false,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          },
        },
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            -- border = "rounded",
            border = "none",
            winblend = 10,
          },
        },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
      },
      signature = { enabled = true },
    })
  end,
  -- opts_extend = { "sources.default" },
}
