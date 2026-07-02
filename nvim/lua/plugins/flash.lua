return {
  enabled = true,
  dependencies = {},
  event = "SuperLazyGokko",
  pack = { src = "https://github.com/folke/flash.nvim" },
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
