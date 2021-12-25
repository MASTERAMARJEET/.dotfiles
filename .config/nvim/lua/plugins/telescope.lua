local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

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

local telescope_mappings = require("keymaps.telescope")

telescope.setup({
  defaults = {

    prompt_prefix = "  ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = telescope_mappings,
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      find_command = { "fd", "--hidden", "--type", "f", "--strip-cwd-prefix" }
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})
telescope.load_extension("fzf")
