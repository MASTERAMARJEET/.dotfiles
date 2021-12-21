vim.g.material_terminal_italics = 1
vim.g.material_theme_style = "ocean-community"
vim.cmd [[
try
  colorscheme material
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
vim.cmd[[highlight ColorColumn ctermbg=red guibg=7]]
