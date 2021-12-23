-- Shorten function name
local map = vim.api.nvim_set_keymap

local M = {}

-- Modes
M.mode = {
  normal = "n",
  insert = "i",
  visual = "v",
  visual_only = "x",
  term = "t",
  command = "c",
}
M.opts = {
  default = { noremap = true, silent = true },
  nosilent = { silent = false },
  term = { silent = true },
}

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymap(keymap)
  local mode = keymap[1]
  local key = keymap[2]
  local val = keymap[3]
  local opt = keymap[4] or M.opts.default

  if val then
    map(mode, key, val, opt)
  end
end

function M.load_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    M.set_keymap(keymap)
  end
end

return M
