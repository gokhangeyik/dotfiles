return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  priority = 800,
  enabled = true,
  lazy = true,
  -- dependencies = {
  --   "folke/tokyonight.nvim",
  -- },
  config = function()
    local branch = { "branch", icon = "" }
    local mode = { "mode", icon = "" }
    local diagnostics =
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " }, colored = true }
    local filetype = { "filetype", icon_only = true, colored = true, separator = "", padding = { left = 1, right = 0 } }
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
      -- for other components. (terrible name, any suggestions?)
      symbols = {
        modified = " ", -- Text to show when the file is modified.
        readonly = " ", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[No Name]", -- Text to show for unnamed buffers.
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
      diff_color = {
        added = "GitSignsAdd", -- Changes the diff's added color
        modified = "GitSignsChange", -- Changes the diff's modified color
        removed = "GitSignsDelete", -- Changes the diff's removed color you
      },
      symbols = { added = "󰐖 ", modified = "󰏬 ", removed = "󰍵 " }, -- Changes the symbols used by the diff.
      source = nil, -- A function that works as a data source for diff.
      separator = {},
    }
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight",
        disabled_filetypes = { "Avante" },
        -- section_separators = { left = "🬗", right = "🬤" },
        -- component_separators = { left = "🬗", right = "🬤" },
        -- section_separators = { right = "🮕", left = "🮖" },
        -- component_separators = { right = "🮕", left = "🮖" },
        section_separators = { left = "🬗", right = "🬤" },
        component_separators = { left = "🬗", right = "🬤" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { filetype, filename },
        lualine_x = {},
        lualine_y = { diff, diagnostics },
        lualine_z = { "progress", "location", harpoon },
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
