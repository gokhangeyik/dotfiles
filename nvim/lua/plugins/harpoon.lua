return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = true,
  enabled = true,
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    })
  end,
  keys = function()
    local keys = {
      {
        "<M-=>",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon the buffer",
      },
      {
        "<M-->",
        function()
          require("harpoon"):list():remove()
        end,
        desc = "Remove harpoon from the buffer",
      },
      {
        "<M-0>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<M-" .. i .. ">",
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
