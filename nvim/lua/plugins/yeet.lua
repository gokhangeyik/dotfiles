return {
  enabled = true,
  event = "SuperLazyGokko",
  dependencies = {
    { src = "https://github.com/stevearc/dressing.nvim" },
  },
  pack = { src = "https://github.com/samharju/yeet.nvim" },
  opts = {
    yeet_and_run = true,
    interrupt_before_yeet = false,
    clear_before_yeet = true,
    notify_on_success = true,
    warn_tmux_not_running = false,
    cache = function()
      local nvim_cache_path = vim.fn.stdpath("cache") .. "yeet/"
      return require("yeet.conf").cachepath(nvim_cache_path)
    end,
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
  keys = {
    {
      "<leader>yl",
      function()
        require("yeet").list_cmd()
      end,
      desc = "List Commands",
    },
    {
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
      "<leader>yr",
      function()
        require("yeet").execute(nil, { clear_before_yeet = false, interrupt_before_yeet = true })
      end,
      desc = "Run Without Clearing Terminal",
    },
    {
      "<leader>ys",
      desc = "Execute Selection",
      function()
        require("yeet").execute_selection({ clear_before_yeet = false })
      end,
      mode = { "n", "v" },
    },
  },
}
