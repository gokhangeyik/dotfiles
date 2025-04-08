return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git_branch", -- also try out "git_branch"
    icons = true, -- setting to "true" requires "nvim-web-devicons"
    status = true,
  },
  keys = {
    { "<M-=>", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
    { "<M-0>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

    { "<M-1>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<M-2>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<M-3>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<M-4>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
    { "<M-5>", "<cmd>Grapple select index=5<cr>", desc = "Select fifth tag" },

    -- { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
    -- { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
  },
}
