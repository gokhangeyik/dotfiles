return {
  "rebelot/kanagawa.nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { bold = true, italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window ``
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
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
      overrides = function(colors) -- add/modify highlights
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
          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          Visual = { bg = theme.ui.bg_p2 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          SnacksPickerToggle = { bg = theme.diag.info, fg = theme.ui.bg_m3 },
          SnacksPickerFile = { fg = "#c8c7c2" },
          -- SnacksDashboard
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
    })
    vim.cmd.colorscheme("kanagawa")
    -- _GokkoNvim.async(vim.cmd("KanagawaCompile"))
  end,
}
