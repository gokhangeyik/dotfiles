local lsp = {
  ansiblels = {
    filetypes = { "ansible.yaml" },
    settings = {},
  },
}

local tools = {
  "ansible-lint",
}

local treesitter = {}

return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {
    {
      "mfussenegger/nvim-ansible",
      lazy = true,
      ft = { "ansible.yaml" },
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
    },
  },
}
