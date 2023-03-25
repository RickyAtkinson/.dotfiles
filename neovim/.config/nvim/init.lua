require('ricky.base')
require('ricky.remap')
require('ricky.plugins')

-- Load OS specific settings
local has = function(x)
  return vim.fn.has(x) == 1
end

local is_win = has('win32')

if is_win then
  require('ricky.windows')
end
