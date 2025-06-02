return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  lazy = true,
  enabled = true,
  version = "*",
  config = function()
    -- local active = function()
    --   -- *This* is the place that gets adjusted
    --   local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 100 })
    --   local git = MiniStatusline.section_git({ trunc_width = 40 })
    --   local diff = MiniStatusline.section_diff({ trunc_width = 75 })
    --   local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
    --   local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
    --   local filename = MiniStatusline.section_filename({ trunc_width = 140 })
    --   local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    --   local location = MiniStatusline.section_location({ trunc_width = 75 })
    --   local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
    --
    --   return MiniStatusline.combine_groups({
    --     { hl = mode_hl, strings = { mode } },
    --     { strings = { "" } },
    --     { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
    --     "%<", -- Mark general truncate point
    --     { hl = "MiniStatuslineFilename", strings = { filename } },
    --     "%=", -- End left alignment
    --     { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    --     { hl = mode_hl, strings = { search, location } },
    --   })
    -- end
    -- local mini_statusline = require("mini.statusline")
    -- mini_statusline.setup({
    --   content = { active = active },
    --   use_icons = true,
    --   set_vim_settings = true,
    -- })
    -- require("mini.statusline").setup({})
    -- vim.cmd("set laststatus=3")
    require("mini.ai").setup({
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = nil,
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",
        -- Next/last variants
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
      },
      -- Number of lines within which textobject is searched
      n_lines = 50,
      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = "cover_or_next",
      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    })
    -- require("mini.pairs").setup({
    --   modes = { insert = true, command = true, terminal = false },
    --   -- skip autopair when next character is one of these
    --   skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    --   -- skip autopair when the cursor is inside these treesitter nodes
    --   skip_ts = { "string" },
    --   -- skip autopair when next character is closing pair
    --   -- and there are more closing pairs than opening pairs
    --   skip_unbalanced = true,
    --   -- better deal with markdown code blocks
    --   markdown = true,
    -- })

    require("mini.icons").setup({})
    MiniIcons.mock_nvim_web_devicons()

    require("mini.surround").setup({
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,
      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
      -- Number of lines within which surrounding is searched
      n_lines = 20,
      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,
      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = "cover",
      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    })
    require("mini.move").setup()
  end,
}
