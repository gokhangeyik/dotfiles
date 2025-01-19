return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true,
  lazy = true,
  config = function()
    local colors = require("tokyonight.colors").setup()
    local custom_tokyonight = {
      normal = {
        a = { bg = colors.blue, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.blue },
        c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
      },
      insert = {
        a = { bg = colors.green, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.green },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.yellow },
      },
      visual = {
        a = { bg = colors.magenta, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.magenta },
      },
      replace = {
        a = { bg = colors.red, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.red },
      },
      terminal = {
        a = { bg = colors.green1, fg = colors.black },
        b = { bg = colors.bg_dark1, fg = colors.green1 },
      },
      inactive = {
        a = { bg = colors.bg_statusline, fg = colors.blue },
        b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
        c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
      },
    }
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
        theme = custom_tokyonight,
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
        lualine_x = {},
        lualine_y = { diagnostics, "encoding", "filetype" },
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
