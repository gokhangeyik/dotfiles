return {
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  -- event = "VeryLazy",
  lazy = true,
  enabled = true,
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  opts = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("gokko-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- map("<leader>lD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        -- map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- map("gd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")
        -- map("gr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eferences")
        -- map("gI", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [I]mplementation")
        -- map("<leader>lD", "<cmd>FzfLua lsp_typedefs<cr>", "Type [D]efinition")
        -- map("<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", "[D]ocument [S]ymbols")
        -- map("<leader>lS", "<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>", "[W]orkspace [S]ymbols")
        map("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- LSP Config Exceptions
        local client = vim.lsp.get_client_by_id(event.data.client_id) or {}
        if _GokkoNvim.func_exist(_GokkoNvim.lsp_overrides[client.name]) then
          local func = _GokkoNvim.lsp_overrides[client.name]
          client = func(client)
        end
        -- /LSP Config Exceptions

        -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        --   local highlight_augroup = vim.api.nvim_create_augroup("gokko-lsp-highlight", { clear = false })
        --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --     buffer = event.buf,
        --     group = highlight_augroup,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --     buffer = event.buf,
        --     group = highlight_augroup,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        --   vim.api.nvim_create_autocmd("LspDetach", {
        --     group = vim.api.nvim_create_augroup("gokko-lsp-detach", { clear = true }),
        --     callback = function(event2)
        --       vim.lsp.buf.clear_references()
        --       vim.api.nvim_clear_autocmds({ group = "gokko-lsp-highlight", buffer = event2.buf })
        --     end,
        --   })
        -- end
      end,
    })
  end,
}
