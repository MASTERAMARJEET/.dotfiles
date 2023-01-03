local M = {}
---Get the key of `val` in `tbl`
---@param tbl table
---@param val any
---@return any
M.get_key = function(tbl, val)
  for k, v in pairs(tbl) do
    if v == val then
      return k
    end
  end
end

return M
