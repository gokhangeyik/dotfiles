return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>y", group = "Yeet", icon = { icon = "", color = "blue" } },
      { "<leader>o", group = "Ollama", icon = { icon = "󰧑", color = "orange" } },
      -- { "<leader>ye", group = "Yeet", icon = { icon = "", color = "green" } },
      -- { "<leader>yl", group = "Yeet", icon = { icon = "", color = "yellow" } },
      -- { "<leader>yo", group = "Yeet", icon = { icon = "󰚩", color = "blue" } },
      -- { "<leader>ys", group = "Yeet", icon = { icon = "󰩀", color = "blue" } },
    })
  end,
}
