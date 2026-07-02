vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("explorer_focus_refresh", { clear = true }),
  callback = function()
    local explorers = Snacks.picker.get({ source = "explorer" })
    for _, picker in ipairs(explorers) do
      picker:action("explorer_update")
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "helm", "gotmpl" },
  callback = function()
    vim.bo.commentstring = "{{/* %s */}}"
    vim.treesitter.start(0, "gotmpl")
  end,
})
local augroup = vim.api.nvim_create_augroup
local gokko = augroup("gokko", {})
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank", {}),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

autocmd({ "BufWritePre" }, {
  group = gokko,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\r//ge]],
})

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
        vim.api.nvim_win_set_config(win_id, config)
      end
    end
  end,
})
