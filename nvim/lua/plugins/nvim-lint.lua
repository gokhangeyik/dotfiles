return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
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

      -- vim.keymap.set("n", "<leader>ll", function()
      --   lint.try_lint()
      -- end, { desc = "lint file" })
    end,
  },
}
