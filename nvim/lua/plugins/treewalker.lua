return {
  "aaronik/treewalker.nvim",
  enabled = true,
  -- lazy = false,
  event = "VeryLazy",
  -- The following options are the defaults.
  -- Treewalker aims for sane defaults, so these are each individually optional,
  -- and setup() does not need to be called, so the whole opts block is optional as well.
  keys = {
    { "<C-M-K>", mode = { "n", "v" }, "<cmd>Treewalker Up<cr>" },
    { "<C-M-J>", mode = { "n", "v" }, "<cmd>Treewalker Down<cr>" },
    { "<C-M-H>", mode = { "n", "v" }, "<cmd>Treewalker Left<cr>" },
    { "<C-M-L>", mode = { "n", "v" }, "<cmd>Treewalker Right<cr>" },

    { "<M-S-K>", mode = { "n", "v" }, "<cmd>Treewalker SwapUp<cr>" },
    { "<M-S-J>", mode = { "n", "v" }, "<cmd>Treewalker SwapDown<cr>" },
    { "<M-S-H>", mode = { "n", "v" }, "<cmd>Treewalker SwapLeft<cr>" },
    { "<M-S-L>", mode = { "n", "v" }, "<cmd>Treewalker SwapRight<cr>" },
  },
  opts = {
    -- Whether to briefly highlight the node after jumping to it
    highlight = true,
    -- How long should above highlight last (in ms)
    highlight_duration = 250,
    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = "CursorLine",
  },
}
