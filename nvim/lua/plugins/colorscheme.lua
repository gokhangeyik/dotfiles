return {
  enabled = true,
  prio = 1000,
  eager = true,
  pack = { src = "https://github.com/rebelot/kanagawa.nvim" },
  opts = {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { bold = true, italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
    colors = {
      palette = {},
      theme = {
        wave = {},
        lotus = {},
        dragon = {},
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        ["@lsp.type.class.python"] = { fg = theme.syn.identifier },
        Underlined = { fg = theme.syn.special1, underline = false },
        Normal = { fg = "#c8c7c2" },
        NormalFloat = { bg = theme.ui.bg_m3 },
        FloatBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        BlinkCmpMenuBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        BlinkCmpMenu = { bg = theme.ui.bg_m3 },
        BlinkCmpSource = { bg = theme.ui.bg_m3 },
        BlinkCmpLabelDetail = { bg = theme.ui.bg_m3 },
        BlinkCmpLabelDescription = { bg = theme.ui.bg_m3 },
        FloatTitle = { bg = theme.diag.info, fg = theme.ui.bg_m3 },
        AvanteSidebarNormal = { bg = theme.ui.bg_m2 },
        AvanteSidebarWinSeparator = { fg = theme.ui.bg_m2, bg = theme.ui.bg_m2 },
        AvanteSidebarWinHorizontalSeparator = { fg = theme.ui.bg_p1, bg = theme.ui.bg_m2 },

        AvanteTitle = { bg = theme.diag.info, fg = theme.ui.bg },
        AvanteSubtitle = { bg = theme.syn.number, fg = theme.ui.bg },
        AvanteThirdTitle = { bg = theme.syn.regex, fg = theme.ui.bg },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        Visual = { bg = theme.ui.bg_p2 },
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        SnacksPickerToggle = { bg = theme.diag.info, fg = theme.ui.bg_m3 },
        SnacksPickerFile = { fg = "#c8c7c2" },
        SnacksDashboardHeader = { fg = theme.diag.info },
        SnacksDashboardFooter = { fg = theme.syn.comment },
        SnacksDashboardDesc = { fg = theme.syn.identifier },
        SnacksDashboardIcon = { fg = theme.ui.special },
        SnacksDashboardKey = { fg = theme.syn.special1 },
        SnacksDashboardSpecial = { fg = theme.syn.comment },
        SnacksDashboardDir = { fg = theme.syn.identifier },

        SnacksNotifierInfo = { fg = theme.diag.info, bg = theme.ui.bg_m3 },
        SnacksNotifierBorderInfo = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        SnacksNotifierTitleInfo = { fg = theme.diag.info, bg = theme.ui.bg_m3 },
        SnacksNotifierFooterInfo = { fg = theme.diag.info, bg = theme.ui.bg_m3 },
        SnacksNotifierIconInfo = { fg = theme.diag.info, bg = theme.ui.bg_m3 },

        SnacksNotifierWarn = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
        SnacksNotifierBorderWarn = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        SnacksNotifierTitleWarn = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
        SnacksNotifierFooterWarn = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
        SnacksNotifierIconWarn = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },

        SnacksNotifierDebug = { fg = theme.diag.ok, bg = theme.ui.bg_m3 },
        SnacksNotifierBorderDebug = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        SnacksNotifierTitleDebug = { fg = theme.diag.ok, bg = theme.ui.bg_m3 },
        SnacksNotifierFooterDebug = { fg = theme.diag.ok, bg = theme.ui.bg_m3 },
        SnacksNotifierIconDebug = { fg = theme.diag.ok, bg = theme.ui.bg_m3 },

        SnacksNotifierError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
        SnacksNotifierBorderError = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        SnacksNotifierTitleError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
        SnacksNotifierFooterError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
        SnacksNotifierIconError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },

        SnacksNotifierTrace = { fg = theme.diag.hint, bg = theme.ui.bg_m3 },
        SnacksNotifierBorderTrace = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        SnacksNotifierTitleTrace = { fg = theme.diag.hint, bg = theme.ui.bg_m3 },
        SnacksNotifierFooterTrace = { fg = theme.diag.hint, bg = theme.ui.bg_m3 },
        SnacksNotifierIconTrace = { fg = theme.diag.hint, bg = theme.ui.bg_m3 },
      }
    end,
    theme = "wave",
    background = {
      dark = "wave",
      light = "wave",
    },
  },
  config = function(opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}
