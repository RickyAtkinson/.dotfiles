-- Globals for OS specific settings
local uname = vim.loop.os_uname()
_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:lower():find("microsoft") and true or false

-- Bootstrap lazy.nvim, LazyVim and custom plugins
require("config.lazy")
