require("options")
require("keymaps")

require("plugins.impatient") -- this needs to be loaded before any other plugins

require("installs")
require("colorscheme")

require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.toggleterm")
require("plugins.gitsigns")

require("plugins.cmp")
require("plugins.autopairs") -- require these after nvim-cmp

require("lsp")

if vim.api.nvim_eval('exists("g:vscode")') == 0 then
  require("plugins.treesitter")
  require("plugins.luasnip")
end
require("plugins.comment") -- require these after treesitter plugins

require("plugins.telescope")
require("plugins.project")
require("plugins.alpha")

require("plugins.whichkey")
require("autocommands")
