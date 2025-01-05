local lsp = {
  lua_ls = {
    -- cmd = {...},
    filetypes = { "lua" },
    -- capabilities = {},
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = "Replace",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = true,
          paramType = true,
          -- paramName = "Disable",
          -- semicolon = "Disable",
          -- arrayIndex = "Disable",
        },
      },
    },
  },
}

local tools = {
  "stylua",
}

local treesitter = {
  "lua",
}

-- language spesific plugins
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},

  lang_plugins = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { -- optional blink completion source for require statements and module annotations
      "saghen/blink.cmp",
      opts = {
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          -- completion = {
          --   enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
          -- },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
          -- providers = {
          --   -- dont show LuaLS require statements when lazydev has items
          --   lsp = { fallback_for = { "lazydev" } },
          --   lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
          -- },
        },
      },
    },
    { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
  },
}
