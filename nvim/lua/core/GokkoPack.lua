local M = {}

local DEFAULT_PRIO = 50

local pending_setups = {}

--- Generate unique ID for a spec
---@param spec table
---@return string
local function get_spec_id(spec)
  return spec.pack and spec.pack.src or tostring(spec)
end

--- Register custom GokkoPack events (LazyGokko, SuperLazyGokko)
--- Called once during setup
function M.register_custom_events()
  vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LazyGokko" })
      end)

      vim.defer_fn(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SuperLazyGokko" })
      end, 1000)
    end,
  })
end

--- Setup GokkoPack with the given configuration
---@param config { sources: string[] }
function M.setup(config)
  local sources = config.sources or {}

  M.register_custom_events()

  local specs = M.collect_specs(sources)

  specs = M.flatten_specs(specs)

  specs = vim.tbl_filter(function(spec)
    return spec.enabled ~= false
  end, specs)

  M.sort_by_prio(specs)

  M.batch_install(specs)

  for _, spec in ipairs(specs) do
    M.load_plugin(spec)
  end

  M.register_commands()
end

--- Register GokkoPack user commands
function M.register_commands()
  vim.api.nvim_create_user_command("PackUpdate", function(opts)
    vim.pack.update(nil, { force = opts.bang })
  end, {
    bang = true,
    desc = "Update all plugins. :PackUpdate shows confirmation buffer, :PackUpdate! skips it.",
  })
end

--- Collect specs from all source directories
---@param sources string[]
---@return table[]
function M.collect_specs(sources)
  local specs = {}
  local config_path = vim.fn.stdpath("config") --[[@as string]]

  for _, source in ipairs(sources) do
    local full_path = config_path .. "/" .. source
    local files = vim.fn.glob(full_path .. "/*.lua", false, true)

    for _, file in ipairs(files) do
      local ok, spec = pcall(dofile, file)
      if ok and spec then
        table.insert(specs, spec)
      end
    end
  end

  return specs
end

--- Flatten nested specs (handle files returning multiple plugins)
---@param specs table[]
---@return table[]
function M.flatten_specs(specs)
  local flat = {}

  for _, spec in ipairs(specs) do
    if spec.pack then
      table.insert(flat, spec)
    else
      for _, s in ipairs(spec) do
        if s.pack then
          table.insert(flat, s)
        end
      end
    end
  end

  return flat
end

--- Sort specs by priority (higher priority first)
---@param specs table[]
function M.sort_by_prio(specs)
  table.sort(specs, function(a, b)
    local prio_a = a.prio or DEFAULT_PRIO
    local prio_b = b.prio or DEFAULT_PRIO
    return prio_a > prio_b
  end)
end

--- Guess module name from GitHub URL
---@param src string
---@return string|nil
function M.guess_main(src)
  if not src then
    return nil
  end

  local repo = src:match("([^/]+)$")
  if not repo then
    return nil
  end

  repo = repo:gsub("%.nvim$", "")
  repo = repo:gsub("%.lua$", "")

  return repo
end

--- Normalize keys spec to consistent format
--- Accepts: { "<lhs>", "<rhs>" } or { { "<lhs>", "<rhs>", mode = "n" }, ... }
---@param spec table
---@return table[]
function M.normalize_keys(spec)
  local keys = spec.keys
  if not keys then
    return {}
  end

  if type(keys[1]) == "string" and type(keys[2]) == "string" then
    return { keys }
  end

  return keys
end

--- Install a plugin and its dependencies (vim.pack.add only, no setup)
---@param spec table
function M.install_plugin(spec)
  if spec.dependencies then
    for _, dep in ipairs(spec.dependencies) do
      vim.pack.add({ { src = dep.src } }, { confirm = false })
    end
  end

  if spec.pack and spec.pack.src then
    vim.pack.add({ { src = spec.pack.src, version = spec.version } }, { confirm = false })
  end
end

--- Collect all pack entries from all specs+deps, deduplicate by src, and install in one call
---@param specs table[]
function M.batch_install(specs)
  local seen = {}
  local pack_list = {}

  for _, spec in ipairs(specs) do
    if spec.dependencies then
      for _, dep in ipairs(spec.dependencies) do
        if dep.src and not seen[dep.src] then
          seen[dep.src] = true
          table.insert(pack_list, { src = dep.src })
        end
      end
    end

    if spec.pack and spec.pack.src then
      local src = spec.pack.src
      if not seen[src] then
        seen[src] = true
        table.insert(pack_list, {
          src = src,
          version = spec.version,
        })
      end
    end
  end

  if #pack_list > 0 then
    vim.pack.add(pack_list, { confirm = false })
  end
end

--- Setup a plugin (call config or require(main).setup(opts))
---@param spec table
function M.setup_plugin(spec)
  if spec.dependencies then
    for _, dep in ipairs(spec.dependencies) do
      if dep.opts or dep.config or dep.main then
        M.setup_single(dep)
      end
    end
  end

  M.setup_single(spec)

  if spec.keys and spec.ft then
    M.setup_buffer_keys(spec)
  end
end

--- Setup a single plugin/dependency
---@param spec table
function M.setup_single(spec)
  local opts = spec.opts or {}

  if type(spec.config) == "function" then
    local ok, err = pcall(spec.config, opts)
    if not ok then
      vim.notify("[GokkoPack] config() failed: " .. tostring(err), vim.log.levels.WARN)
    end
    return
  end

  local main = spec.main or M.guess_main(spec.pack and spec.pack.src)
  if not main then
    return
  end

  local ok, mod = pcall(require, main)
  if ok and type(mod) == "table" and type(mod.setup) == "function" then
    local setup_ok, err = pcall(mod.setup, opts)
    if not setup_ok then
      vim.notify("[GokkoPack] setup() failed for " .. main .. ": " .. tostring(err), vim.log.levels.WARN)
    end
  end
end

--- Setup buffer-local keymaps (when ft is defined)
---@param spec table
function M.setup_buffer_keys(spec)
  local keys = M.normalize_keys(spec)

  for _, key in ipairs(keys) do
    local lhs = key[1]
    local rhs = key[2]
    local mode = key.mode or "n"
    local desc = key.desc

    if type(mode) == "string" then
      mode = { mode }
    end

    local keymap_opts = { buffer = true }
    if desc then
      keymap_opts.desc = desc
    end

    for _, m in ipairs(mode) do
      vim.keymap.set(m, lhs, rhs, keymap_opts)
    end
  end
end

--- Cleanup all pending triggers for a spec (autocmds + keymaps)
---@param spec_id string
function M.cleanup_triggers(spec_id)
  local pending = pending_setups[spec_id]
  if not pending then
    return
  end

  for _, id in ipairs(pending.autocmds or {}) do
    pcall(vim.api.nvim_del_autocmd, id)
  end

  for _, keymap in ipairs(pending.keymaps or {}) do
    for _, m in ipairs(keymap.mode) do
      pcall(vim.keymap.del, m, keymap.lhs)
    end
  end

  pending_setups[spec_id] = nil
end

--- Setup global keymaps for eager-loaded plugins
--- Only sets up keys that are NOT filetype-specific
---@param spec table
function M.setup_eager_keys(spec)
  if not spec.keys or spec.ft then
    return
  end

  local keys = M.normalize_keys(spec)
  for _, key in ipairs(keys) do
    local lhs = key[1]
    local rhs = key[2]
    local mode = key.mode or "n"
    local desc = key.desc

    if type(mode) == "string" then
      mode = { mode }
    end

    local keymap_opts = {}
    if desc then
      keymap_opts.desc = desc
    end

    for _, m in ipairs(mode) do
      vim.keymap.set(m, lhs, rhs, keymap_opts)
    end
  end
end

--- Replay a key sequence after plugin is loaded
---@param lhs string
---@param mode string
function M.replay_key(lhs, mode)
  local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
  vim.api.nvim_feedkeys(keys, mode, false)
end

--- Create callback for lazy loading triggers
---@param spec table
---@param replay_info? { lhs: string, mode: string }
---@return function
function M.create_lazy_callback(spec, replay_info)
  local spec_id = get_spec_id(spec)

  return function()
    M.cleanup_triggers(spec_id)

    M.setup_plugin(spec)

    if spec.keys and not spec.ft then
      local keys = M.normalize_keys(spec)
      for _, key in ipairs(keys) do
        local lhs = key[1]
        local rhs = key[2]
        local mode = key.mode or "n"
        local desc = key.desc

        if type(mode) == "string" then
          mode = { mode }
        end

        local keymap_opts = {}
        if desc then
          keymap_opts.desc = desc
        end

        for _, m in ipairs(mode) do
          vim.keymap.set(m, lhs, rhs, keymap_opts)
        end
      end
    end

    if replay_info then
      M.replay_key(replay_info.lhs, replay_info.mode)
    end
  end
end

--- Initialize pending_setups entry for a spec
---@param spec_id string
local function init_pending(spec_id)
  if not pending_setups[spec_id] then
    pending_setups[spec_id] = { autocmds = {}, keymaps = {} }
  end
end

--- Register filetype listener(s) for lazy setup
---@param spec table
function M.register_ft(spec)
  local filetypes = spec.ft
  if type(filetypes) == "string" then
    filetypes = { filetypes }
  end

  local spec_id = get_spec_id(spec)
  init_pending(spec_id)

  local autocmd_id = vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    once = true,
    callback = M.create_lazy_callback(spec),
  })

  table.insert(pending_setups[spec_id].autocmds, autocmd_id)
end

--- Register event listener(s) for lazy setup
---@param spec table
function M.register_event(spec)
  local events = spec.event
  if type(events) == "string" then
    events = { events }
  end

  local spec_id = get_spec_id(spec)
  init_pending(spec_id)

  for _, event in ipairs(events) do
    local autocmd_id
    local is_custom = event == "LazyGokko" or event == "SuperLazyGokko"

    if is_custom then
      autocmd_id = vim.api.nvim_create_autocmd("User", {
        pattern = event,
        once = true,
        callback = M.create_lazy_callback(spec),
      })
    else
      autocmd_id = vim.api.nvim_create_autocmd(event, {
        once = true,
        callback = M.create_lazy_callback(spec),
      })
    end

    table.insert(pending_setups[spec_id].autocmds, autocmd_id)
  end
end

--- Register key listener(s) for lazy setup (global keymaps as triggers)
---@param spec table
function M.register_keys(spec)
  local keys = M.normalize_keys(spec)
  local spec_id = get_spec_id(spec)
  init_pending(spec_id)

  for _, key in ipairs(keys) do
    local lhs = key[1]
    local mode = key.mode or "n"
    local desc = key.desc

    if type(mode) == "string" then
      mode = { mode }
    end

    table.insert(pending_setups[spec_id].keymaps, { lhs = lhs, mode = mode })

    for _, m in ipairs(mode) do
      local keymap_opts = {}
      if desc then
        keymap_opts.desc = desc .. " (lazy)"
      end

      vim.keymap.set(m, lhs, function()
        M.create_lazy_callback(spec, { lhs = lhs, mode = m })()
      end, keymap_opts)
    end
  end
end

--- Load a single plugin (install always, setup based on triggers)
---@param spec table
function M.load_plugin(spec)
  if spec.enabled == false then
    return
  end

  if spec.eager == true then
    M.setup_plugin(spec)
    M.setup_eager_keys(spec)
    return
  end

  local has_ft = spec.ft ~= nil
  local has_event = spec.event ~= nil
  local has_keys = spec.keys ~= nil and not has_ft

  local has_triggers = has_ft or has_event or has_keys

  if not has_triggers then
    M.setup_plugin(spec)
    return
  end

  if has_ft then
    M.register_ft(spec)
  end
  if has_event then
    M.register_event(spec)
  end
  if has_keys then
    M.register_keys(spec)
  end
end

return M
