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

-- Properly close LSP before quitting Neovim
autocmd("VimLeavePre", {
  group = gokko,
  callback = function()
    -- Stop all LSP clients
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      pcall(function()
        vim.lsp.stop_client(client.id, true)
      end)
    end

    -- Free up resources
    collectgarbage("collect")
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
