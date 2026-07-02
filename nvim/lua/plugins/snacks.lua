return {
  enabled = true,
  prio = 999,
  eager = true,
  version = "v2.31.0",
  pack = { src = "https://github.com/folke/snacks.nvim" },
  opts = {
    input = {
      enabled = true,
    },
    zen = {
      dim = false,
      git_signs = true,
      diagnostics = true,
      inlay_hints = true,
      center = true,
      show = {
        statusline = true,
        tabline = false,
      },
    },
    image = {
      enabled = false,
    },
    lazygit = {
      enabled = true,
      configure = true,
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "MatchParen", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "BlinkCmpGhostText" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "Visual" },
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },
    picker = {
      ui_select = true,
      toggles = {
        follow = "f",
        hidden = { icon = "" },
        ignored = { icon = "" },
        modified = "m",
        regex = { icon = "R", value = false },
      },
      layout = { preset = "default", cycle = false },
      debug = { scores = false },
      icons = {
        git = {
          staged = "󰱒 ",
          added = "󰐖 ",
          deleted = " ",
          ignored = " ",
          modified = " ",
          renamed = " ",
          untracked = " ",
        },
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          title = "EXPLORER",
          exclude = { ".venv", ".git", "__pycache__", ".pytest_cache" },
        },
        files = {
          show_empty = false,
          hidden = true,
          ignored = true,
          exclude = { ".venv", ".git", "__pycache__", ".pytest_cache", ".ruff_cache" },
        },
      },
      matcher = {
        frecency = true,
        fuzy = true,
        history_bonus = true,
      },
    },
    animate = { enabled = false },
    explorer = {
      enabled = true,
    },
    scroll = { enabled = false },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
      },
      preset = {
        header = [[
██████╗  ██████╗ ██╗  ██╗██╗  ██╗ ██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔════╝ ██╔═══██╗██║ ██╔╝██║ ██╔╝██╔═══██╗████╗  ██║██║   ██║██║████╗ ████║
██║  ███╗██║   ██║█████╔╝ █████╔╝ ██║   ██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██║   ██║██║   ██║██╔═██╗ ██╔═██╗ ██║   ██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╔╝╚██████╔╝██║  ██╗██║  ██╗╚██████╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
      },
    },
    notifier = {
      style = "compact",
      enabled = true,
      timeout = 3000,
      padding = true,
    },
    quickfile = { enabled = false },
    statuscolumn = { enabled = true },
    scope = { enabled = true },
    indent = { enabled = true },
    words = { enabled = true },
  },
  config = function(opts)
    local start = vim.g._start_time
    local ms = start and math.floor(vim.fn.reltimefloat(vim.fn.reltime(start)) * 1000) or 0
    vim.g._startup_ms = ms
    table.insert(opts.dashboard.sections, 2, {
      text = { { "  loaded in " .. ms .. "ms", hl = "Comment" } },
      align = "center",
      padding = 1,
    })
    require("snacks").setup(opts)
  end,
  keys = {

    {
      "<leader>fe",
      function()
        Snacks.explorer()
      end,
      desc = "Switch gitworktree",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
    },
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo Tree",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.pickers()
      end,
      desc = "Snack Pickers",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>gc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sv",
      function()
        local env_list = _GokkoNvim.get_python_envs()
        local env_names = vim.tbl_keys(env_list)
        local python_icon = require("mini.icons").get("extension", "py")
        Snacks.picker.select(env_names, {
          prompt = "Select Python Environment",
          format_item = function(item)
            local env_info = env_list[item]
            return string.format("%s [%s]  %s", python_icon, env_info.type, item)
          end,
        }, _GokkoNvim.activate_python_env)
      end,
      desc = "Python Environment Selector",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>uz",
      function()
        Snacks.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>qp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
}
