_GokkoNvim = require("core.GokkoNvim")
if not _GokkoNvim.firstboot() then
  _GokkoNvim.load_dependencies()
end
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
_GokkoNvim.async(_GokkoNvim.init, 500)
