return {
  enabled = true,
  ft = { "python" },
  dependencies = {},
  pack = { src = "https://github.com/benomahony/uv.nvim" },
  opts = {
    auto_activate_venv = true,
    auto_commands = true,
    picker_integration = true,
    keymaps = {
      prefix = "<leader>uv",
      commands = true,
      run_file = true,
      run_selection = true,
      run_function = true,
      venv = true,
      init = true,
      add = true,
      remove = true,
      sync = true,
    },
    execution = {
      run_command = "uv run python",
      notify_output = true,
      notification_timeout = 10000,
    },
  },
}
