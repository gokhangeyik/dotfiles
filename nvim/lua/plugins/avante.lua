return {
  "yetone/avante.nvim",
  -- event = "BufEnter",
  enabled = true,
  event = "VeryLazy",
  version = false, -- set this if you want to always pull the latest change
  opts = {
    openai = {
      hide_in_model_selector = true,
    },
    ["openai-gpt-4o-mini"] = {
      hide_in_model_selector = true,
    },
    cohere = {
      hide_in_model_selector = true,
    },
    -- claude = {
    --   hide_in_model_selector = true,
    -- },
    ["claude-opus"] = {
      hide_in_model_selector = true,
    },
    ["claude-haiku"] = {
      hide_in_model_selector = true,
    },
    -- gemini = {
    --   hide_in_model_selector = true,
    -- },
    vertex = {
      hide_in_model_selector = true,
    },
    vertex_claude = {
      hide_in_model_selector = true,
    },
    bedrock = {
      hide_in_model_selector = true,
    },
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
    provider = "cp_sonnet_37",
    hints = { enabled = false },
    auto_suggestion_provider = "copilot",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = false, -- Whether to remove unchanged lines when applying a code block
    },
    vendors = {
      -- cp_gpt4o = {
      --   __inherited_from = "copilot",
      --   timeout = 30000, -- Timeout in milliseconds
      --   temperature = 0,
      --   -- max_tokens = 4096,
      -- },
      cp_sonnet_35 = {
        __inherited_from = "copilot",
        model = "claude-3.5-sonnet",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        -- max_tokens = 4096,
      },
      cp_sonnet_37 = {
        __inherited_from = "copilot",
        model = "claude-3.7-sonnet",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        -- max_tokens = 4096,
      },
      cp_claude_thinking = {
        __inherited_from = "copilot",
        model = "claude-3.7-sonnet-thought",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        -- max_tokens = 4096,
      },
      -- Available
      copilot_o1 = {
        __inherited_from = "copilot",
        model = "o1",
      },
      -- Available
      copilot_o3_mini = {
        __inherited_from = "copilot",
        model = "o3-mini",
      },
      -- Unavailable
      copilot_gemini = {
        __inherited_from = "copilot",
        model = "gemini-2.0-flash-001",
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
