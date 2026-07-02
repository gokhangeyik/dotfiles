return {
  enabled = true,
  event = "LazyGokko",
  dependencies = {},
  pack = { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
  opts = {
    disable_when_zoomed = true,
  },
  keys = {
    {
      "<C-h>",
      "<Cmd>NvimTmuxNavigateLeft<CR>",
      mode = { "n" },
      desc = "Nvim/Tmux Navigate Left",
    },

    {
      "<C-j>",
      "<Cmd>NvimTmuxNavigateDown<CR>",
      mode = { "n" },
      desc = "Nvim/Tmux Navigate Down",
    },

    {
      "<C-k>",
      "<Cmd>NvimTmuxNavigateUp<CR>",
      mode = { "n" },
      desc = "Nvim/Tmux Navigate Up",
    },

    {
      "<C-l>",
      "<Cmd>NvimTmuxNavigateRight<CR>",
      mode = { "n" },
      desc = "Nvim/Tmux Navigate Right",
    },
  },
}
