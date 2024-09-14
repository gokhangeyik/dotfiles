return {
  "samharju/yeet.nvim",
  dependencies = {
    "stevearc/dressing.nvim", -- optional, provides sane UX
  },
  version = "*", -- update only on releases
  cmd = "Yeet",
  keys = {
    {
      -- Pop command cache open
      "<leader>yl",
      function()
        require("yeet").list_cmd()
      end,
      desc = "List Commands",
    },
    {
      -- Open target selection
      "<leader>yt",
      function()
        require("yeet").select_target()
      end,
      desc = "Select Target",
    },
    {
      "<leader>ye",
      function()
        require("yeet").execute()
      end,
      desc = "Execute",
    },
    {
      "<leader>yo",
      function()
        require("yeet").toggle_post_write()
      end,
      desc = "Toggle Autocmd",
    },
    {
      -- Run command without clearing terminal, send C-c
      "<leader>yr",
      function()
        require("yeet").execute(nil, { clear_before_yeet = false, interrupt_before_yeet = true })
      end,
      desc = "Run Without Clearing Terminal",
    },
    {
      -- Yeet visual selection. Useful sending core to a repl or running multiple commands.
      "<leader>ys",
      desc = "Execute Selection",
      function()
        require("yeet").execute_selection({ clear_before_yeet = false })
      end,
      mode = { "n", "v" },
    },
  },
  opts = {
    -- Send <CR> to channel after command for immediate execution.
    yeet_and_run = true,
    -- Send C-c before execution
    interrupt_before_yeet = false,
    -- Send 'clear<CR>' to channel before command for clean output.
    clear_before_yeet = true,
    -- Enable notify for yeets. Success notifications may be a little
    -- too much if you are using noice.nvim or fidget.nvim
    notify_on_success = true,
    -- Print warning if pane list could not be fetched, e.g. tmux not running.
    warn_tmux_not_running = false,
    -- Resolver for cache file
    cache = function()
      -- resolves project path and uses stdpath("cache")/yeet/<project>, see :h yeet
      local nvim_cache_path = vim.fn.stdpath("cache") .. "yeet/"
      return require("yeet.conf").cachepath(nvim_cache_path)
    end,
    -- Use cache.
    -- cache = false,
    -- Window options for cache float
    cache_window_opts = {
      relative = "editor",
      row = (vim.o.lines - 15) * 0.5,
      col = (vim.o.columns - math.ceil(0.6 * vim.o.columns)) * 0.5,
      width = math.ceil(0.6 * vim.o.columns),
      height = 15,
      border = "single",
      title = "Yeet",
    },
  },
}
