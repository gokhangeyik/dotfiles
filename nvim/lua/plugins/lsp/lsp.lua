return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
            commitCharactersSupport = true,
            deprecatedSupport = true,
            preselectSupport = true,
            labelDetailsSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = false,
            insertTextModeSupport = { 1 },
            resolveSupport = {
              properties = {
                "documentation",
                "detail",
              },
            },
          },
        },
      },
    },
  },
  config = function()
    for lsp_name, _ in pairs(_GokkoNvim.lsp) do
      vim.lsp.config(lsp_name, _GokkoNvim.lsp[lsp_name])
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("gokko-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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
