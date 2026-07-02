local mod_cache = nil
---@param fname string
---@return string?
local function get_root(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients({ name = "gopls" })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  return vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git")
end

local lsp = {
  golangci_lint_ls = {
    cmd = { "golangci-lint-langserver" },
    filetypes = { "go", "gomod" },
    init_options = {
      command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
    },
    root_markers = {
      ".golangci.yml",
      ".golangci.yaml",
      ".golangci.toml",
      ".golangci.json",
      "go.work",
      "go.mod",
      ".git",
    },
    before_init = function(_, config)
      local v1
      if vim.fn.executable("go") == 1 then
        local exe = vim.fn.exepath("golangci-lint")
        local version = vim.system({ "go", "version", "-m", exe }):wait()
        v1 = string.match(version.stdout, "\tmod\tgithub.com/golangci/golangci%-lint\t")
      else
        local version = vim.system({ "golangci-lint", "version" }):wait()
        v1 = string.match(version.stdout, "version v?1%.")
      end
      if v1 then
        config.init_options.command = { "golangci-lint", "run", "--out-format", "json" }
      end
    end,
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      if mod_cache then
        on_dir(get_root(fname))
        return
      end
      local cmd = { "go", "env", "GOMODCACHE" }
      vim.system(cmd, { text = true }, function(output)
        if output.code == 0 then
          if output.stdout then
            mod_cache = vim.trim(output.stdout)
          end
          on_dir(get_root(fname))
        else
          vim.schedule(function()
            vim.notify(("[gopls] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
          end)
        end
      end)
    end,
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
}

local tools = {
  "golangci-lint-langserver",
  "gopls",
  "goimports",
  "gofumpt",
  "gomodifytags",
  "impl",
  "delve",
  "golangci-lint",
  "djlint",
}

local treesitter = {
  "go",
  "gomod",
  "gowork",
  "gosum",
  "gotmpl",
}

local lsp_overrides = {}
return {
  lsp = lsp or {},
  lsp_overrides = lsp_overrides or {},
  tools = tools or {},
  treesitter = treesitter or {},
}
