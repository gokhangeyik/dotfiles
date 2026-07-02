return {
  enabled = true,
  dependencies = {},
  event = "LazyGokko",
  pack = { src = "https://github.com/echasnovski/mini.nvim" },
  config = function()
    require("mini.ai").setup({
      custom_textobjects = nil,
      mappings = {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 50,
      search_method = "cover_or_next",
      silent = false,
    })

    require("mini.icons").setup({})
    MiniIcons.mock_nvim_web_devicons()

    require("mini.surround").setup({
      custom_surroundings = nil,
      highlight_duration = 500,
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
        suffix_last = "l",
        suffix_next = "n",
      },
      n_lines = 20,
      respect_selection_type = false,
      search_method = "cover",
      silent = false,
    })
    require("mini.move").setup()
  end,
}
