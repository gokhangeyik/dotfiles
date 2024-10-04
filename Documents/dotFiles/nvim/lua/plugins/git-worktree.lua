-- return {
--   -- "ThePrimeagen/git-worktree.nvim",
--   "awerebea/git-worktree.nvim",
--   branch = "handle_changes_in_telescope_api",
--   -- branch = "master",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   keys = {
--     {
--       "<leader>gws",
--       '<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<cr>',
--       desc = "Show Git Worktrees",
--     },
--     {
--       "<leader>gwc",
--       '<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<cr>',
--       desc = "Create New Git Worktree",
--     },
--   },
--   config = function()
--     require("git-worktree").setup()
--     require("telescope").load_extension("git_worktree")
--   end,
-- }
return {
  "gokhangeyik/g-worktree.nvim",
  --"Mohanbarman/g-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>gws",
      '<cmd>lua require("telescope").extensions.g_worktree.list()<cr>',
      desc = "Show Git Worktrees",
    },
    {
      "<leader>gwc",
      '<cmd>lua require("telescope").extensions.g_worktree.create()<cr>',
      desc = "Create New Git Worktree",
    },
  },
  config = function()
    require("telescope").load_extension("g_worktree")
    require("g-worktree").setup({
      base_dir_pattern = "../{git_dir_name}-wt/{branch_name}",
      post_create_cmd = "e .", -- you can use any vim cmd in this case default netrw window will open
      change_dir_after_create = true, -- do you want to switch current directory after create ?
      clearjumps = true,
    })
  end,
}
