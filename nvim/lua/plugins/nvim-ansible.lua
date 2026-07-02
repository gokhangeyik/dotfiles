return {
  enabled = true,
  ft = { "ansible.yaml" },
  dependencies = {},
  pack = { src = "https://github.com/mfussenegger/nvim-ansible" },
  opts = {
    ui = {
      check_outdated_packages_on_open = true,
      border = "none",
      width = 0.8,
      height = 0.9,
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  keys = {
    {
      "<leader>ta",
      function()
        require("ansible").run()
      end,
      desc = "Ansible Run Playbook/Role",
      silent = true,
    },
  },
}
