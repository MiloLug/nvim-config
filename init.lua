local function script_path()
  local str = debug.getinfo(2, 'S').source:sub(2)
  return str:match('(.*/)')
end

NVIM_ROOT = script_path()

require("liava")
