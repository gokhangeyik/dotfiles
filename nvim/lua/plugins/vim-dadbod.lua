return {
  "kristijanhusak/vim-dadbod-ui",
  enabled = true,
  lazy = true,
  -- event = "VeryLazy",
  dependencies = {
    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  -- init = function()
  --   -- Your DBUI configuration
  --   vim.g.db_ui_use_nerd_fonts = 1
  -- end,
}
