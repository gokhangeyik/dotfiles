return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VeryLazy", -- Sets the loading event to 'VimEnter'
  -- lazy = true,
  opts = {
    preset = "modern",
    -- icons = {
    --   -- set icon mappings to true if you have a Nerd Font
    --   mappings = vim.g.have_nerd_font,
    --   -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
    --   -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
    --   keys = vim.g.have_nerd_font and {} or {
    --     Up = "<Up> ",
    --     Down = "<Down> ",
    --     Left = "<Left> ",
    --     Right = "<Right> ",
    --     C = "<C-…> ",
    --     M = "<M-…> ",
    --     D = "<D-…> ",
    --     S = "<S-…> ",
    --     CR = "<CR> ",
    --     Esc = "<Esc> ",
    --     ScrollWheelDown = "<ScrollWheelDown> ",
    --     ScrollWheelUp = "<ScrollWheelUp> ",
    --     NL = "<NL> ",
    --     BS = "<BS> ",
    --     Space = "<Space> ",
    --     Tab = "<Tab> ",
    --     F1 = "<F1>",
    --     F2 = "<F2>",
    --     F3 = "<F3>",
    --     F4 = "<F4>",
    --     F5 = "<F5>",
    --     F6 = "<F6>",
    --     F7 = "<F7>",
    --     F8 = "<F8>",
    --     F9 = "<F9>",
    --     F10 = "<F10>",
    --     F11 = "<F11>",
    --     F12 = "<F12>",
    --   },
    -- },

    -- Document existing key chains
    spec = {
      { "<leader>a", group = "[A]vante", icon = "󰍛" },
      { "<leader>c", group = "[C]ode", icon = "󰅩", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument", icon = "󰈙" },
      { "<leader>l", group = "[L]SP", icon = "󰿘" },
      { "<leader>g", group = "[G]it", icon = "󰊢" },
      { "<leader>s", group = "[S]earch", icon = "" },
      { "<leader>w", group = "[W]indow and [W]orkspace", icon = "" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>o", group = "[O]bsidian", icon = "" },
      { "<leader>y", group = "[Y]eet", icon = "" },
      { "<leader>f", group = "[F]ile Operations", icon = "" },
      { "<leader>u", group = "[U]ser Interface", icon = "󰏘" },
      { "<leader>q", group = "[Q]uick Session", icon = "" },
      -- { "<leader>v", group = "[V]irtualenv", icon = "" },
      { "<leader>x", group = "Trouble", icon = "" },
      -- { "<leader>h", group = "Git [H]unk", icon = "󰊢", mode = { "n", "v" } },
    },
  },
}
