-- local function optimize_lua_cache()
--   local package_cache = {}
--   local old_require = require
--
--   require = function(name)
--     if package_cache[name] then
--       return package_cache[name]
--     end
--     local loaded = old_require(name)
--     package_cache[name] = loaded
--     return loaded
--   end
-- end
-- optimize_lua_cache()
--
_GokkoNvim = require("core.GokkoNvim")
if not _GokkoNvim.firstboot() then
  _GokkoNvim.load_dependencies()
end
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
_GokkoNvim.async(_GokkoNvim.init)
vim.cmd.colorscheme("kanagawa")
