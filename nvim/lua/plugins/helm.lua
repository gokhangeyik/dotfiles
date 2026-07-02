return {
  {
    enabled = true,
    ft = { "helm", "yaml.helm-values" },
    dependencies = {},
    pack = { src = "https://github.com/qvalentin/helm-ls.nvim" },
    opts = {
      conceal_templates = {
        enabled = false,
      },
      indent_hints = {
        enabled = true,
        only_for_current_line = true,
      },
      action_highlight = {
        enabled = true,
      },
    },
  },
}
