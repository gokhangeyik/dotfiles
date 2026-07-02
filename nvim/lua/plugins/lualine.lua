local location = { "location", separator = "" }
local branch = { "branch", icon = "", separator = "" }
local mode = {
  "mode",
  icon = " ",
  separator = { right = "", left = "" },
}
local diagnostics = {
  "diagnostics",
  symbols = { error = "  ", warn = "  ", info = "  ", hint = " " },
  colored = true,
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
  file_status = true,
  newfile_status = false,
  path = 1,
  shorting_target = 40,
  color = { fg = "#9399b2", bg = "#1F1F28" },
  separator = { right = "", left = "" },
  symbols = {
    modified = "",
    readonly = "",
    unnamed = "Untitled",
    newfile = " ",
  },
}
local diff = {
  "diff",
  colored = true,
  symbols = { added = "󰐖 ", modified = "󰏬 ", removed = "󰍵 " },
  separator = "",
}
return {
  enabled = true,
  event = "LazyGokko",
  dependencies = { { src = "https://github.com/yavorski/lualine-macro-recording.nvim" } },
  pack = { src = "https://github.com/nvim-lualine/lualine.nvim" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      disabled_filetypes = { "Avante", "snacks_dashboard" },
      section_separators = { left = "", right = "" },
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
  },
}
