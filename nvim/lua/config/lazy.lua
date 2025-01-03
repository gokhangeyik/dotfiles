-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local lang_plugins = {}
local config_path = vim.fn.stdpath("config")
local scandir = vim.loop.fs_scandir(config_path .. "/lua/plugins/lsp/lang")
if scandir then
  while true do
    local file, t = vim.loop.fs_scandir_next(scandir)
    if not file then
      break
    end
    if t == "file" and file:match("%.lua$") then
      local module_name = file:sub(1, -5) -- Remove the .lua extension
      local lang_module = require("plugins.lsp.lang." .. module_name)
      lang_plugins = vim.list_extend(lang_plugins or {}, lang_module.lang_plugins or {})
    end
  end
end
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = {
    -- import your plugins
    { import = "plugins.themes" },
    { import = "plugins" },
    { import = "plugins.lsp" },
    lang_plugins,
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  change_detection = {
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
