local helpers = require("keymaps.helpers")
local mode = helpers.mode
local opts = helpers.opts

--Remap "," as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local global = {
  { mode.normal, ";", ":", opts.nosilent },

  -- disable arrow keys in normal mode
  { mode.normal, "<Down>", "<Nop>" },
  { mode.normal, "<Up>", "<Nop>" },
  { mode.normal, "<Left>", "<Nop>" },
  { mode.normal, "<Right>", "<Nop>" },

  -- Better copy paste
  { mode.normal, "<leader>y", '"+y' },
  { mode.normal, "<leader>p", '"+p' },
  { mode.visual, "p", '"_dP' },
  { mode.normal, "<A-Up>", "YP" },
  { mode.normal, "<A-Down>", "Yp" },

  -- Better window navigation
  { mode.normal, "<C-h>", "<C-w>h" },
  { mode.normal, "<C-j>", "<C-w>j" },
  { mode.normal, "<C-k>", "<C-w>k" },
  { mode.normal, "<C-l>", "<C-w>l" },
  { mode.insert, "<C-h>", "<C-\\><C-N><C-w>h" },
  { mode.insert, "<C-j>", "<C-\\><C-N><C-w>j" },
  { mode.insert, "<C-k>", "<C-\\><C-N><C-w>k" },
  { mode.insert, "<C-l>", "<C-\\><C-N><C-w>l" },
  { mode.term, "<C-h>", "<C-\\><C-N><C-w>h", opts.term },
  { mode.term, "<C-j>", "<C-\\><C-N><C-w>j", opts.term },
  { mode.term, "<C-k>", "<C-\\><C-N><C-w>k", opts.term },
  { mode.term, "<C-l>", "<C-\\><C-N><C-w>l", opts.term },

  -- Move text up and down
  { mode.visual, "J", ":move '>+1<CR>gv=gv" },
  { mode.visual, "K", ":move '<-2<CR>gv=gv" },

  -- Resize with arrows
  { mode.normal, "<C-Up>", ":resize -2<CR>" },
  { mode.normal, "<C-Down>", ":resize +2<CR>" },
  { mode.normal, "<C-Left>", ":vertical resize -2<CR>" },
  { mode.normal, "<C-Right>", ":vertical resize +2<CR>" },

  -- Navigate buffers
  { mode.normal, "L", ":bnext<CR>" },
  { mode.normal, "H", ":bprevious<CR>" },

  -- Stay in indent mode
  { mode.visual_only, "<", "<gv" },
  { mode.visual_only, ">", ">gv" },
}

helpers.load_keymaps(global)

