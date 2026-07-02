return {
  enabled = true,
  dependencies = {},
  event = "LazyGokko",
  pack = { src = "https://github.com/stevearc/conform.nvim" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "ruff_format", "ruff_organize_imports" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      hcl = { "packer_fmt" },
      terraform = { "terraform_fmt" },
      toml = { "pyproject-fmt" },
    },
    default_format_opts = {
      async = true,
      quiet = false,
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 2000 },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      ruff_format = { "--line-length", "100" },
    },
  },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
}
