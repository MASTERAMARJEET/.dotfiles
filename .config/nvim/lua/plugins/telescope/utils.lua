function _TELESCOPE(picker, theme, args)
  local tele_theme = require("telescope.themes")
  args = args or {}
  if not theme then
    -- no theme => default (horizontal)
    local horizontal_config = { layout_config = { preview_width = 0.6 } }
    args = vim.tbl_deep_extend(
      "force",
      args,
      horizontal_config
    )
  elseif theme=="dropdown" then
    local size = 0.8
    local min_width, min_height = 80, 15
    local dropdown_config = {
      previewer = false,
      layout_config = {
        width = function(_, max_columns, _)
          return math.max(math.ceil(max_columns * size), min_width)
        end,

        height = function(_, _, max_lines)
          return math.max(math.ceil(max_lines * size), min_height)
        end,
      },
      winblend = 10,
      results_title = "",
    }
    args = vim.tbl_deep_extend(
      "force",
      args,
      tele_theme.get_dropdown(dropdown_config)
    )
  elseif theme=="ivy" then
    args = vim.tbl_deep_extend(
      "force",
      args,
      tele_theme.get_ivy({results_title = ""})
    )
  end
  require("telescope.builtin")[picker](args)
end
