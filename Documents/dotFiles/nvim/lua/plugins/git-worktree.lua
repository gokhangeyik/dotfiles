return {
  -- "ThePrimeagen/git-worktree.nvim",
  "awerebea/git-worktree.nvim",
  branch = "handle_changes_in_telescope_api",
  -- branch = "master",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>gws",
      '<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<cr>',
      desc = "Show Git Worktrees",
    },
    {
      "<leader>gwc",
      '<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<cr>',
      desc = "Create New Git Worktree",
    },
  },
  config = function()
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")
  end,
}
