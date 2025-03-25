return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  enabled = true,
  lazy = true,
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
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      hcl = { "packer_fmt" },
      terraform = { "terraform_fmt" },
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
      black = { "--line-length", "80" },
    },
  },
  -- init = function()
  --   -- If you want the formatexpr, here is the place to set it
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}
