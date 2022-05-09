vim.cmd([[
  augroup _nvim
    autocmd!
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  augroup end
]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General Settings
local general_settings = augroup("_general_settings", { clear = true })
autocmd("FileType", {
  group = general_settings,
  pattern = { "qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<CR>",
})
autocmd("TextYankPost", {
  group = general_settings,
  callback = function()
    require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
  end,
})
autocmd("BufWinEnter", {
  group = general_settings,
  command = ":set formatoptions-=cro",
})
autocmd("FileType", {
  group = general_settings,
  pattern = "qt",
  command = "set nobuflisted",
})

-- build pdf on save
local latex = augroup("_latex", { clear = true })
autocmd("BufWritePost", {
  group = latex,
  pattern = { "*.tex" },
  command = "silent !pdflatex --interaction=batchmode report.tex 2>&1> /dev/null",
})

local wrap_spell = augroup("_wrap_spell", { clear = true })
autocmd("FileType", {
  group = wrap_spell,
  pattern = { "gitcommit", "markdown" },
  command = "setlocal wrap",
})
autocmd("FileType", {
  group = wrap_spell,
  pattern = { "gitcommit", "markdown", "tex" },
  command = "setlocal spell",
})

local auto_resize = augroup("_auto_resize", { clear = true })
autocmd("VimResized", {
  command = "tabdo wincmd =",
  group = auto_resize,
})
