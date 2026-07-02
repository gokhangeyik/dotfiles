return {
  enabled = true,
  dependencies = { { src = "https://github.com/kevinhwang91/promise-async" } },
  event = "SuperLazyGokko",
  pack = { src = "https://github.com/kevinhwang91/nvim-ufo" },
  opts = {},
  config = function()
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      mode = "n",
      desc = "Open All Folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      mode = "n",
      desc = "Close All Folds",
    },
  },
}
