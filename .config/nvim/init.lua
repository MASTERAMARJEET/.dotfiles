require("options")
require("keymaps")
require("installs")
require("colorscheme")
require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.bufferline")

require("plugins.cmp")

require("lsp")

require("plugins.comment") -- require these after treesitter plugins
require("plugins.autopairs") -- require these after nvim-cmp
