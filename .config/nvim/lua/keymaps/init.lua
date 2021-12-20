local opts = { noremap = true, silent = true }
local nosilent_opts = { silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap "," as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
local mode = {
  normal = "n",
  insert = "i",
  visual = "v",
  visual_only = "x",
  term = "t",
  command = "c",
}

--
keymap(mode.normal, ";", ':', nosilent_opts)

-- disable arrow keys in normal mode
keymap(mode.normal, "<Down>", "<Nop>", opts)
keymap(mode.normal, "<Up>", "<Nop>", opts)
keymap(mode.normal, "<Left>", "<Nop>", opts)
keymap(mode.normal, "<Right>", "<Nop>", opts)

-- Better copy paste
keymap(mode.normal, "<leader>y", '"+y', opts)
keymap(mode.normal, "<leader>p", '"+p', opts)
keymap(mode.visual, "p", '"_dP', opts)
keymap(mode.normal, "<A-Up>", 'YP', opts)
keymap(mode.normal, "<A-Down>", 'Yp', opts)

-- Better window navigation
keymap(mode.normal, "<C-h>", "<C-w>h", opts)
keymap(mode.normal, "<C-j>", "<C-w>j", opts)
keymap(mode.normal, "<C-k>", "<C-w>k", opts)
keymap(mode.normal, "<C-l>", "<C-w>l", opts)
keymap(mode.insert, "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap(mode.insert, "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap(mode.insert, "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap(mode.insert, "<C-l>", "<C-\\><C-N><C-w>l", opts)
keymap(mode.term, "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap(mode.term, "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap(mode.term, "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap(mode.term, "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Move text up and down
keymap(mode.visual, "J", ":move '>+1<CR>gv=gv", opts)
keymap(mode.visual, "K", ":move '<-2<CR>gv=gv", opts)

-- Resize with arrows
keymap(mode.normal, "<C-Up>", ":resize -2<CR>", opts)
keymap(mode.normal, "<C-Down>", ":resize +2<CR>", opts)
keymap(mode.normal, "<C-Left>", ":vertical resize -2<CR>", opts)
keymap(mode.normal, "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap(mode.normal, "L", ":bnext<CR>", opts)
keymap(mode.normal, "H", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap(mode.visual_only, "<", "<gv", opts)
keymap(mode.visual_only, ">", ">gv", opts)

