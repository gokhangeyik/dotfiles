local function reload_workspace(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
  for _, client in ipairs(clients) do
    vim.notify("Reloading Cargo Workspace")
    client.request("rust-analyzer/reloadWorkspace", nil, function(err)
      if err then
        error(tostring(err))
      end
      vim.notify("Cargo workspace reloaded")
    end, 0)
  end
end

local function is_library(fname)
  local user_home = vim.fs.normalize(vim.env.HOME)
  local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
  local registry = cargo_home .. "/registry/src"
  local git_registry = cargo_home .. "/git/checkouts"

  local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
  local toolchains = rustup_home .. "/toolchains"

  for _, item in ipairs({ toolchains, registry, git_registry }) do
    if vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
end

local lsp = {
  -- bacon_ls = {
  --   filetypes = { "rust" },
  --   enabled = "bacon-ls",
  -- },
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local reused_dir = is_library(fname)
      if reused_dir then
        on_dir(reused_dir)
        return
      end

      local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
      local cargo_workspace_root

      if cargo_crate_dir == nil then
        on_dir(
          vim.fs.root(fname, { "rust-project.json" })
            or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        )
        return
      end

      local cmd = {
        "cargo",
        "metadata",
        "--no-deps",
        "--format-version",
        "1",
        "--manifest-path",
        cargo_crate_dir .. "/Cargo.toml",
      }

      vim.system(cmd, { text = true }, function(output)
        if output.code == 0 then
          if output.stdout then
            local result = vim.json.decode(output.stdout)
            if result["workspace_root"] then
              cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
            end
          end

          on_dir(cargo_workspace_root or cargo_crate_dir)
        else
          vim.schedule(function()
            vim.notify(("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
          end)
        end
      end)
    end,
    capabilities = {
      experimental = {
        serverStatusNotification = true,
      },
    },
    before_init = function(init_params, config)
      -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
      if config.settings and config.settings["rust-analyzer"] then
        init_params.initializationOptions = config.settings["rust-analyzer"]
      end
    end,
    on_attach = function()
      vim.api.nvim_buf_create_user_command(0, "LspCargoReload", function()
        reload_workspace(0)
      end, { desc = "Reload current cargo workspace" })
    end,
  },
}

local tools = { "codelldb" }

local treesitter = {
  "rust",
  "ron",
}

-- Language spesific plugins
return {
  lsp = lsp or {},
  tools = tools or {},
  treesitter = treesitter or {},
  lang_plugins = {
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = {
        completion = {
          crates = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      },
    },
    {
      "mrcjkb/rustaceanvim",
      enabled = false,
      version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
      ft = { "rust" },
      opts = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>cR", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "Code Action", buffer = bufnr })
            vim.keymap.set("n", "<leader>dr", function()
              vim.cmd.RustLsp("debuggables")
            end, { desc = "Rust Debuggables", buffer = bufnr })
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
              },
            },
          },
        },
      },
      config = function(_, opts)
        local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
        local codelldb = package_path .. "/extension/adapter/codelldb"
        local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
        local uname = io.popen("uname"):read("*l")
        if uname == "Linux" then
          library_path = package_path .. "/extension/lldb/lib/liblldb.so"
        end
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
        vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      end,
    },
  },
}
