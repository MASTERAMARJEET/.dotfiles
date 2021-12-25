local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- ! DONOT remove this require
local utils = require("plugins.telescope.utils")

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
      find_command = { "fd", "--hidden", "--type", "f", "--strip-cwd-prefix" },
    },
    buffers = {
      entry_maker = utils.buffer_entry_maker(),
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
