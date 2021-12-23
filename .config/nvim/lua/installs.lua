local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})
return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself

  -- USER BY OTHER PLUGINS
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })

  -- CMP PLUGINS
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/nvim-lsp-installer" })
  use({ "tamago324/nlsp-settings.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- SNIPPETS
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- TREESITTER
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- TELESCOPE
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- BETTER UI
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "nvim-lualine/lualine.nvim" })
  use({
    "akinsho/bufferline.nvim",
    requires = { "moll/vim-bbye" }
  })

  -- COLORSCHEMES
  use({
    "MASTERAMARJEET/material.nvim", -- forked from 'marko-cerovac/material.nvim'
    branch = "amar",
  })

  -- CODE EASY
  use({ "numToStr/Comment.nvim" })
  use({ "windwp/nvim-autopairs" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
