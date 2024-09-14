return {
  {
    "akinsho/toggleterm.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        hide_numbers = true,
        direction = "horizontal",
        terminal_mappings = true,
        start_in_insert = true,
        close_on_exit = true,
      })
    end,
    keys = {
      { [[<C-\>]] },
      { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
      {
        "<leader>td",
        "<cmd>ToggleTerm size=10 dir=~/Desktop direction=horizontal<cr>",
        desc = "Open a horizontal terminal at the Desktop directory",
      },
    },
  },
}
