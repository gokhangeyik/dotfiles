return {
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
    -- Run linters
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })

    -- vim.keymap.set("n", "<leader>ll", function()
    --   lint.try_lint()
    -- end, { desc = "lint file" })
  end,
}
