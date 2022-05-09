-- Shorten function name
local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap

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

--- Set key mappings individually
--- @param keymap table It has the following values
---   mode The keymap mode, can be one of the keys of mode_adapters
---   key The key of keymap
---   val Can be form as a mapping or tuple of mapping and user defined opt
---   opts Other keymap settings
--- @param bufnr integer Buffer number. Undefined if keymap if global
function M.set_keymap(keymap, bufnr)
  local mode = keymap[1]
  local key = keymap[2]
  local val = keymap[3]
  local opt = keymap[4] or M.opts.default

  if val then
    if bufnr then
      buf_map(bufnr, mode, key, val, opt)
    else
      map(mode, key, val, opt)
    end
  end
end

function M.load_keymaps(keymaps, buffer)
  for _, keymap in ipairs(keymaps) do
    M.set_keymap(keymap, buffer)
  end
end

return M
