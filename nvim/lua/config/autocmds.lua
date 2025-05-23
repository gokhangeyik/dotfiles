local augroup = vim.api.nvim_create_augroup
local gokko = augroup("gokko", {})
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.http",
  command = "set filetype=http",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank", {}),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Cleanup trailing whitespaces
autocmd({ "BufWritePre" }, {
  group = gokko,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
-- Show errors and warnings in a floating window
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
  end,
})

-- Run linters
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})
--
-- -- Keep one empty line at EOF
-- autocmd({ "BufWritePost" }, {
--   group = gokko,
--   pattern = "*",
--   callback = function()
--     local n_lines = vim.api.nvim_buf_line_count(0)
--     local last_nonblank = vim.fn.prevnonblank(n_lines)
--     if last_nonblank <= n_lines then
--       vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" })
--     end
--   end,
-- })
