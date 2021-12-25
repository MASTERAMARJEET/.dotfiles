function _TELESCOPE(picker, theme)
  local tele_theme = require("telescope.themes")
  local theme_args = {}
  if not theme then
    -- no theme => default (horizontal)
    local horizontal_config = { layout_config = { preview_width = 0.6 } }
    theme_args = horizontal_config
  elseif theme == "dropdown" then
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
    theme_args = tele_theme.get_dropdown(dropdown_config)
  elseif theme == "ivy" then
    theme_args = tele_theme.get_ivy({ results_title = "" })
  end
  require("telescope.builtin")[picker](theme_args)
end

local M = {}

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")

local filter = vim.tbl_filter
local map = vim.tbl_map

function M.buffer_entry_maker(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", { default = true })

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(unpack(map(function(bufnr)
    return vim.fn.strdisplaywidth(
      vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t")
    )
  end, bufnrs)))

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.bufnr, "TelescopeResultsNumber" },
      { entry.indicator, "TelescopeResultsComment" },
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { entry.dir_name, "Comment" },
    })
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly")
        and "="
      or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    local icons, highlight = devicons.get_icon(
      bufname,
      string.match(bufname, "%a+$"),
      { default = true }
    )

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

return M
