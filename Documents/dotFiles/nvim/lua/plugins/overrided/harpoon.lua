local keys = {
  {
    "<M-=>",
    function()
      require("harpoon"):list():add()
    end,
    desc = "Add buffer to harpoon list",
  },
  {
    "<M-->",
    function()
      require("harpoon"):list():remove()
    end,
    desc = "Remove buffer from harpoon list",
  },
  {
    "<M-0>",
    function()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end,
    desc = "Show harpoon list",
  },
}
for i = 1, 5, 1 do
  table.insert(keys, {
    "<M-" .. i .. ">",
    function()
      require("harpoon"):list():select(i)
    end,
    desc = "Open harpoon buffer #" .. i,
  })
end
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = "nvim-lua/plenary.nvim",
  keys = keys,
  config = function()
    require("harpoon"):setup()
  end,
}
