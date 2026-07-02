local map = vim.keymap.set
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Clear hlsearch" })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

map("n", "<leader>od", function()
  require("notesidian").create_daily_note()
end, { desc = "Create or edit daily note (Today)" })

map("n", "<leader>oy", function()
  require("notesidian").create_daily_note(-1)
end, { desc = "Create or edit daily note (Yesterday)" })

map("n", "<leader>ot", function()
  require("notesidian").create_daily_note(1)
end, { desc = "Create or edit daily note (Tomorrow)" })

map("n", "<leader>ol", function()
  require("notesidian").create_todo_list()
end, { desc = "Create or edit Todo List" })

map("n", "<leader>oc", function()
  require("notesidian").toggle_checkbox()
end, { desc = "Toggle Checkbox" })

map("n", "<leader>of", function()
  require("notesidian").find_notes()
end, { desc = "Search Notes" })

map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

local keys = {
  {
    "<leader>sR",
    function()
      local grug = require("grug-far")
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      grug.open({
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        },
      })
    end,
    mode = { "n", "v" },
    desc = "Search and Replace",
  },
}
for _, map in ipairs(keys) do
  local opts = { desc = map.desc }
  if map.silent ~= nil then
    opts.silent = map.silent
  end
  if map.noremap ~= nil then
    opts.noremap = map.noremap
  else
    opts.noremap = true
  end
  if map.expr ~= nil then
    opts.expr = map.expr
  end

  local mode = map.mode or "n"
  vim.keymap.set(mode, map[1], map[2], opts)
end
