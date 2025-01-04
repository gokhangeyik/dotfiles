return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = "VeryLazy",
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ot", mode = { "n" }, "<cmd>ObsidianToday<cr>", desc = "Today" },
    { "<leader>oT", mode = { "n" }, "<cmd>ObsidianToday +1<cr>", desc = "Tomorrow" },
    { "<leader>oY", mode = { "n" }, "<cmd>ObsidianToday -1<cr>", desc = "Yesterday" },
    { "<leader>oN", mode = { "n" }, "<cmd>ObsidianNewFromTemplate<cr>", desc = "New Note From Template" },
    {
      "<leader>os",
      mode = { "n" },
      function()
        vim.ui.input({ prompt = "Obsidian Search: " }, function(input)
          if input then
            vim.cmd("ObsidianSearch " .. input)
          end
        end)
      end,
      desc = "Obsidian Search",
    },
  },
  opts = {
    templates = {
      folder = "Templates",
      date_format = "%d-%m-%Y",
      time_format = "%H:%M",
    },
    notes_subdir = "Notes",
    new_notes_location = "notes_subdir",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Notes/Dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%d-%m-%Y",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    note_id_func = function(title)
      return title
    end,
    workspaces = {},
  },
}
