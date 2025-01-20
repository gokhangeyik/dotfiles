return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true,
  lazy = true,
  dependencies = { "yavorski/lualine-macro-recording.nvim" },
  config = function()
    -- local colors = require("tokyonight.colors").setup()
    -- local custom_tokyonight = {
    --   normal = {
    --     a = { bg = colors.blue, fg = colors.bg },
    --     b = { bg = colors.bg_highlight, fg = colors.blue },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    --   insert = {
    --     a = { bg = colors.green, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg_highlight, fg = colors.green },
    --   },
    --   command = {
    --     a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg_highlight, fg = colors.yellow },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    --   visual = {
    --     a = { bg = colors.magenta, fg = colors.bg, gui = "bold,italic" },
    --     b = { bg = colors.bg_highlight, fg = colors.magenta },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    --   replace = {
    --     a = { bg = colors.red, fg = colors.bg },
    --     b = { bg = colors.bg_highlight, fg = colors.red },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    --   terminal = {
    --     a = { bg = colors.green1, fg = colors.bg },
    --     b = { bg = colors.bg_highlight, fg = colors.green1 },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    --   inactive = {
    --     a = { bg = colors.bg_statusline, fg = colors.blue },
    --     b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
    --     c = { bg = colors.bg, fg = colors.dark5 },
    --     x = { bg = colors.blue, fg = colors.bg },
    --     y = { bg = colors.bg_highlight, fg = colors.blue },
    --     z = { bg = colors.blue, fg = colors.bg },
    --   },
    -- }
    local branch = { "branch", icon = "", separator = { right = "", left = "" } }
    local mode = { "mode", icon = "", separator = { right = "", left = "" } }
    -- local location = { "location", icon = "" }
    local diagnostics = {
      "diagnostics",
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
    }
    -- local filetype = { "filetype", icon_only = true, colored = true, separator = "", padding = { left = 1, right = 0 } }
    local filename = {
      "filename",
      file_status = true, -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 1,
      -- 0: Just the filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory
      -- 4: Filename and parent dir, with tilde as the home directory
      shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      symbols = {
        modified = "", -- Text to show when the file is modified.
        readonly = "", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "Untitled", -- Text to show for unnamed buffers.
        newfile = " ", -- Text to show for newly created file before first write
      },
    }
    local harpoon = {
      "harpoon2",
      icon = " ",
      indicators = { "1", "2", "3", "4", "5" },
      active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]" },
    }
    local diff = {
      "diff",
      colored = true,
      symbols = { added = "󰐖 ", modified = "󰏬 ", removed = "󰍵 " }, -- Changes the symbols used by the diff.
    }
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        disabled_filetypes = { "Avante" },
        -- section_separators = { left = "🬗", right = "🬤" },
        -- component_separators = { left = "🬗", right = "🬤" },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { filename },
        lualine_x = { "macro_recording" },
        lualine_y = { diagnostics, "encoding" },
        lualine_z = { "location", "progress", harpoon },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    })
  end,
}
