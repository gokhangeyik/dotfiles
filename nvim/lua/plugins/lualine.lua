return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = true,
  event = "VeryLazy",
  dependencies = { "yavorski/lualine-macro-recording.nvim" },
  config = function()
    local location = { "location", separator = "" }
    local branch = { "branch", icon = "", separator = "" }
    local mode = {
      "mode",
      -- icon = "",
      icon = " ",
      -- icon = " ",
      -- icon = "󱠦 ",
      -- separator = { right = "🬗", left = "" },
      separator = { right = "", left = "" },
    }
    local diagnostics = {
      "diagnostics",
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      -- separator = { left = "🬤", right = "" },
      separator = { left = "", right = "" },
    }
    local filetype = {
      "filetype",
      color = { fg = "#9399b2", bg = "#1F1F28" },
      icon_only = true,
      colored = true,
      separator = "",
      padding = { left = 1, right = 0 },
    }
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
      color = { fg = "#9399b2", bg = "#1F1F28" },
      -- separator = { right = "🬗", left = "" },
      separator = { right = "", left = "" },
      symbols = {
        modified = "", -- Text to show when the file is modified.
        readonly = "", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "Untitled", -- Text to show for unnamed buffers.
        newfile = " ", -- Text to show for newly created file before first write
      },
    }
    local diff = {
      "diff",
      colored = true,
      symbols = { added = "󰐖 ", modified = "󰏬 ", removed = "󰍵 " }, -- Changes the symbols used by the diff.
      separator = "",
    }
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = { "Avante", "snacks_dashboard" },
        -- section_separators = { left = "🬗", right = "🬤" },
        -- component_separators = { left = "🬗", right = "🬤" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- component_separators = { left = "■", right = "■" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { filetype, filename },
        lualine_x = { "macro_recording" },
        lualine_y = { diagnostics },
        lualine_z = { location, "progress" },
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
      extensions = {},
    })
  end,
}
