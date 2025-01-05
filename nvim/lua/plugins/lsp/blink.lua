return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  -- lazy = false, -- lazy loading handled internally
  dependencies = {
    "rafamadriz/friendly-snippets",
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
        default = { "lsp", "path", "buffer", "snippets" },
        -- optionally disable cmdline completions
        -- cmdline = {},
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
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
      },
      signature = { enabled = true },
    })
  end,
  -- opts_extend = { "sources.default" },
}
