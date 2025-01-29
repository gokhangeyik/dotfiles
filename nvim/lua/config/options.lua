vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_perl_provider = 0

local opt = vim.opt
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = false -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
-- opt.foldlevel = 1
-- opt.foldcolumn = "1"
-- opt.foldlevelstart = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = "eob: " -- Hide end of buffer character `~`
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 10 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 10 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true --
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.termguicolors = true -- True color support
-- opt.guicursor
--   "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.timeoutlen = 700 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 50
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 500 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

vim.diagnostic.config({
  virtual_text = false, -- floating text next to code is too noisy.

  -- virtual_text = {
  --   spacing = 4,
  --   source = "if_many",
  --   prefix = "●",
  --   -- prefix = " ",
  -- },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
vim.g.git_worktree = {
  change_directory_command = "cd",
  update_on_change = true,
  update_on_change_command = "e .",
  clearjumps_on_change = true,
  confirm_telescope_deletions = true,
  autopush = false,
}
