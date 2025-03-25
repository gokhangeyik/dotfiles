_GokkoNvim = require("config.GokkoNvim")
_GokkoNvim.async(_GokkoNvim.init_deps)
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- Lua require cache optimizasyonu
local function optimize_lua_cache()
  local package_cache = {}
  local old_require = require

  require = function(name)
    if package_cache[name] then
      return package_cache[name]
    end
    local loaded = old_require(name)
    package_cache[name] = loaded
    return loaded
  end
end

optimize_lua_cache()
