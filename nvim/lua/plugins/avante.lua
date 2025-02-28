return {
  "yetone/avante.nvim",
  -- event = "BufEnter",
  enabled = true,
  event = "VeryLazy",
  version = false, -- set this if you want to always pull the latest change
  opts = {
    windows = {
      sidebar_header = {
        rounded = false,
      },
      input = {
        height = 3,
      },
      ask = {
        floating = false,
        border = "none",
      },
    },
    file_selector = {
      provider = "snacks",
    },
    provider = "copilot_sonnet",
    hints = { enabled = false },
    auto_suggestion_provider = "copilot_gpt4o",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = false, -- Whether to remove unchanged lines when applying a code block
    },
    -- copilot = {
    --   endpoint = "https://api.githubcopilot.com",
    --   model = "claude-3.5-sonnet",
    --   proxy = nil, -- [protocol://]host[:port] Use this proxy
    --   allow_insecure = false, -- Allow insecure server connections
    --   timeout = 30000, -- Timeout in milliseconds
    --   temperature = 0.2,
    --   max_tokens = 4096,
    -- },
    vendors = {
      copilot_gpt4o = {
        __inherited_from = "copilot",
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-08-06",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      copilot_sonnet = {
        __inherited_from = "copilot",
        endpoint = "https://api.githubcopilot.com",
        model = "claude-3.7-sonnet",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          panels = { enabled = false },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
              accept = "<C-M-y>",
              accept_word = false,
              accept_line = false,
              next = "<C-M-n>",
              prev = "<C-M-p>",
              dismiss = "<C-Esc>",
            },
          },
          filetypes = {
            ["*"] = false,
          },
        })
      end,
    },
    -- {
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    -- "MeanderingProgrammer/render-markdown.nvim",
    -- lazy = false,
    -- opts = {
    --   file_types = { "Avante" },
    -- },
    -- },
  },
  keys = {
    {
      "<leader>aA",
      function()
        vim.cmd("Copilot! attach")
        vim.notify("Copilot attached", vim.log.levels.INFO, { title = "avante" })
      end,
      desc = "avante: attach Copilot",
    },
    {
      "<leader>aD",
      function()
        vim.cmd("Copilot! detach")
        vim.notify("Copilot detached", vim.log.levels.INFO, { title = "avante" })
      end,
      desc = "avante: detach Copilot",
    },
  },
}
