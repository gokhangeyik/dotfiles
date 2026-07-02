return {
  enabled = true,
  version = vim.version.range("1.*"),
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {},
  pack = { src = "https://github.com/saghen/blink.cmp" },
  opts = {
    snippets = { preset = "default" },
    fuzzy = {
      prebuilt_binaries = {
        force_version = "v1.*",
      },
    },
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
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          opts = {},
          --- NOTE: All of these options may be functions to get dynamic behavior
          --- See the type definitions for more information
          enabled = true,
          async = true,
          timeout_ms = 2000,
          transform_items = nil,
          should_show_items = true,
          max_items = nil,
          min_keyword_length = 2,
          fallbacks = {},
          score_offset = 0,
          override = nil,
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
          },
        },
      },
      documentation = {
        auto_show = false,
        treesitter_highlighting = true,
        window = {
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
  },
}
