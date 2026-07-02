return {
  {
    enabled = true,
    pack = {
      src = "https://github.com/nvim-treesitter/nvim-treesitter",
      version = "main",
    },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
    },
    config = function(opts)
      local TS = require("nvim-treesitter")

      if not TS.get_installed then
        vim.notify("[Treesitter] Please update nvim-treesitter to main branch", vim.log.levels.ERROR)
        return
      end

      TS.setup(opts)

      local installed = TS.get_installed()
      local install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, opts.ensure_installed or {})

      if #install > 0 then
        vim.schedule(function()
          TS.install(install, { summary = true })
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("gokko_treesitter", { clear = true }),
        callback = function(ev)
          local ft = ev.match
          local lang = vim.treesitter.language.get_lang(ft)
          local buf = ev.buf

          local has_parser = pcall(vim.treesitter.language.add, lang or ft)
          if not has_parser then
            return
          end

          ---@param feat string
          ---@param query string
          local function enabled(feat, query)
            local f = opts[feat] or {}
            return f.enable ~= false
              and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
              and pcall(vim.treesitter.query.get, lang or ft, query)
          end

          if enabled("highlight", "highlights") then
            pcall(vim.treesitter.start, buf)
          end

          if enabled("indent", "indents") then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          if enabled("folds", "folds") then
            vim.wo[vim.api.nvim_get_current_win()].foldmethod = "expr"
            vim.wo[vim.api.nvim_get_current_win()].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
  },
  {
    enabled = false,
    dependencies = {},
    event = "SuperLazyGokko",
    pack = { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    opts = {
      ensure_installed = _GokkoNvim.treesitter,
      auto_install = true,
      highlight = true,
      nohighlight = { "helm" },
    },
  },
  {
    enabled = true,
    dependencies = {},
    event = "SuperLazyGokko",
    pack = { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    opts = {
      enable = true,
      multiwindow = false,
      max_lines = 5,
      min_window_height = 200,
      line_numbers = true,
      multiline_threshold = 3,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  },
}
