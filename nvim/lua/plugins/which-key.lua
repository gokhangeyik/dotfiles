return {
  enabled = true,
  event = "SuperLazyGokko",
  dependencies = {},
  pack = { src = "https://github.com/folke/which-key.nvim" },
  opts = {
    preset = "modern",

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
      { "<leader>x", group = "Trouble", icon = "" },
    },
  },
}
