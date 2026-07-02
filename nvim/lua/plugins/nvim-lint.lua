return {
  enabled = true,
  event = "SuperLazyGokko",
  dependencies = {},
  pack = { src = "https://github.com/mfussenegger/nvim-lint" },
  opts = {},
  config = function()
    local lint = require("lint")

    local djlint = lint.linters.djlint
    djlint.args = {
      "--profile",
      "golang",
      "--linter-output-format",
      "{line}:{code}: {message}",
      "-",
    }
    lint.linters_by_ft = {
      python = { "bandit" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
      template = { "djlint" },
    }
  end,
}
