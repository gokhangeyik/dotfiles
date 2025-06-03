local lsp = {
  ansiblels = {
    cmd = { "ansible-language-server", "--stdio" },
    settings = {
      ansible = {
        python = {
          interpreterPath = "python",
        },
        ansible = {
          path = "ansible",
        },
        executionEnvironment = {
          enabled = false,
        },
        validation = {
          enabled = true,
          lint = {
            enabled = true,
            path = "ansible-lint",
          },
        },
      },
    },
    filetypes = { "yaml.ansible" },
    root_markers = { "ansible.cfg", ".ansible-lint" },
  },
}

local tools = {
  "ansible-language-server",
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
