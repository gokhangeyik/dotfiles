return {
  enabled = true,
  dependencies = {},
  pack = { src = "https://github.com/rachartier/tiny-cmdline.nvim" },
  config = function()
    require("tiny-cmdline").setup({
      width = {
        value = "40%",
        min = 40,
        max = 50,
      },

      position = {
        x = "50%",
        y = "50%",
      },

      border = nil,

      menu_col_offset = 3,

      native_types = { "/", "?" },

      on_reposition = nil,
    })
  end,
}
