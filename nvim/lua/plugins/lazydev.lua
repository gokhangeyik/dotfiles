return {
  enabled = true,
  ft = { "lua" },
  dependencies = {},
  pack = { src = "https://github.com/folke/lazydev.nvim" },
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "LazyVim" } },
    },
  },
}
