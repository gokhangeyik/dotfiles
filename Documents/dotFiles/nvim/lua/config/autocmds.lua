-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local gokko = augroup("gokko", {})
local autocmd = vim.api.nvim_create_autocmd

-- Cleanup trailing whitespaces
autocmd({ "BufWritePre" }, {
  group = gokko,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Keep one empty line at EOF
autocmd({ "BufWritePre" }, {
  group = gokko,
  pattern = "*",
  callback = function()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank <= n_lines then
      vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" })
    end
  end,
})

--[[
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.b.autoformat = false
  end,
})
]]
