local augroup = vim.api.nvim_create_augroup
local gokko = augroup("gokko", {})
local autocmd = vim.api.nvim_create_autocmd

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
-- Cleanup MS EOL marks
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\r//ge]],
})
-- -- Show errors and warnings in a floating window
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
--   end,
-- })

vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    local win_id = vim.api.nvim_get_current_win()
    local win_conf = vim.api.nvim_win_get_config(win_id)

    if win_conf.relative ~= "" then
      local title = win_conf.title
      if title and type(title) == "table" and title[1] and title[1][1] then
        local window_title = title[1][1]

        local config = vim.api.nvim_win_get_config(win_id)
        config.title_pos = "center"
        config.title = { { " " .. window_title .. " ", "FloatTitle" } }
        -- config.relative = "editor"
        vim.api.nvim_win_set_config(win_id, config)
      end
    end
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
