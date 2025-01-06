return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    event = "VeryLazy",
    opts = {
      ensure_installed = _GokkoNvim.treesitter,
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        astro = "<!-- %s -->",
        axaml = "<!-- %s -->",
        blueprint = "// %s",
        c = "// %s",
        c_sharp = "// %s",
        clojure = { ";; %s", "; %s" },
        cpp = "// %s",
        cs_project = "<!-- %s -->",
        cue = "// %s",
        fsharp = "// %s",
        fsharp_project = "<!-- %s -->",
        gleam = "// %s",
        glimmer = "{{! %s }}",
        graphql = "# %s",
        handlebars = "{{! %s }}",
        hcl = "# %s",
        html = "<!-- %s -->",
        hyprlang = "# %s",
        ini = "; %s",
        ipynb = "# %s",
        javascript = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        kdl = "// %s",
        php = "// %s",
        rego = "# %s",
        rescript = "// %s",
        rust = { "// %s", "/* %s */" },
        sql = "-- %s",
        styled = "/* %s */",
        svelte = "<!-- %s -->",
        templ = {
          "// %s",
          component_block = "<!-- %s -->",
        },
        terraform = "# %s",
        tsx = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        twig = "{# %s #}",
        typescript = { "// %s", "/* %s */" }, -- langs can have multiple commentstrings
        vue = "<!-- %s -->",
        xaml = "<!-- %s -->",
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
