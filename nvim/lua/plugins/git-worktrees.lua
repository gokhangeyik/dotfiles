return {
  "Juksuu/worktrees.nvim",
  enabled = true,
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    {
      "<leader>gws",
      function()
        Snacks.picker.worktrees()
      end,
      desc = "Switch gitworktree",
    },
    {
      "<leader>gwn",
      function()
        Snacks.picker.worktrees_new()
      end,
      desc = "Switch gitworktree",
    },
  },
}
