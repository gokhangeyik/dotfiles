return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    lsp = {
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
      message = {
        enabled = true,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
      -- {
      --   filter = {
      --     event = "notify",
      --     find = "",
      --   },
      --   opts = { skip = true },
      -- },
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
          { find = "fewer lines" },
        },
      },
      view = "mini",
    },
    views = {

      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        border = {
          style = "none",
          padding = { 1, 2 },
        },
        size = {
          min_width = 60,
          width = "auto",
          height = "auto",
        },
        win_options = {
          winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
      -- mini = {
      --   win_options = {
      --     winblend = 10,
      --   },
      -- },
    },
  },
}
