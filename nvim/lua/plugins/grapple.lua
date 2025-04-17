return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git_branch", -- also try out "git_branch"
    icons = true, -- setting to "true" requires "nvim-web-devicons"
    status = true,
  },
  keys = {
    { "<a-=>", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
    { "<a-0>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
    { "<a-1>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<a-2>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<a-3>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<a-4>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
    { "<a-5>", "<cmd>Grapple select index=5<cr>", desc = "Select fifth tag" },
    -- { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
    -- { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
  },
}
