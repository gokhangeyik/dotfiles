return {
  "NeogitOrg/neogit",
  lazy = true,
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
    -- "echasnovski/mini.pick", -- optional
  },
  opts = {
    graph_style = "kitty",
    kind = "floating",
  },
  keys = {
    {
      "<leader>gn",
      function()
        require("neogit").open()
      end,
      desc = "Neogit",
    },
  },
}
