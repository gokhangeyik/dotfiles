return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        show_tab_indicators = false,
        separator_style = { "", "" },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
        themeable = false,
        indicator = {},
        style = "none",
      },
    },
  },
}
