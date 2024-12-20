return {
  "stevearc/oil.nvim",
  lazy = true,
  keys = {
    {
      "<leader>fo",
      function()
        require("oil").toggle_float()
      end,
      desc = "Toggle Oil",
    },
  },
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    experimental_watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      -- Padding around the floating window
      padding = 5,
      max_width = 0,
      max_height = 0,
      border = "single",
      win_options = {
        winblend = 0,
      },
    },
  },
}
