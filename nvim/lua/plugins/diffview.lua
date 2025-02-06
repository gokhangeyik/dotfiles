return {
  "sindrets/diffview.nvim",
  enabled = true,
  event = "VeryLazy",
  keys = {
    {
      "<leader>gh",
      "<cmd>DiffviewFileHistory %<cr>",
      mode = { "n", "v" },
      desc = "Current File History",
    },
    {
      "<leader>gH",
      "<cmd>DiffviewFileHistory<cr>",
      mode = { "n", "v" },
      desc = "File History",
    },
    {
      "<leader>gq",
      "<cmd>DiffviewClose<cr>",
      mode = { "n", "v" },
      desc = "File History",
    },
  },
}
