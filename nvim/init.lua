vim.g._start_time = vim.fn.reltime()
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("vim._core.ui2").enable({
  enable = true,
})

_GokkoNvim = require("core.GokkoNvim")
require("config.options")
require("config.diagnostics")
require("config.keymaps")
require("config.autocmds")

_GokkoNvim.load_dependencies()

require("core.GokkoPack").setup({
  sources = {
    "lua/plugins",
  },
})

_GokkoNvim.init()
