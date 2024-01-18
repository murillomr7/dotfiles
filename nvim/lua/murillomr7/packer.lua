-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use ('ThePrimeagen/vim-be-good')
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  tag = 'v0.1.0', -- Optional tag release
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

  use( 'nvim-treesitter/playground')  

  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use {
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')
  use ('williamboman/mason.nvim')
  
  use {
	  "williamboman/mason.nvim",
	  "williamboman/mason-lspconfig.nvim",
	  "neovim/nvim-lspconfig",
  }
------------------------------------------------------------
  -- NVIM-CMP
  --call plug#begin(s:plug_dir)
 use ('neovim/nvim-lspconfig')
 use ('hrsh7th/cmp-nvim-lsp')
 use ('hrsh7th/cmp-buffer')
 use ('hrsh7th/cmp-path')
 use ('hrsh7th/cmp-cmdline')
 use ('hrsh7th/nvim-cmp')

 -- For vsnip users.
 use ('hrsh7th/cmp-vsnip')
 use ('hrsh7th/vim-vsnip')

-- For luasnip users.
  use ('L3MON4D3/LuaSnip')
  use ('saadparwaiz1/cmp_luasnip')

-- For ultisnips users.
  use ('SirVer/ultisnips')
  use ('quangnguyen30192/cmp-nvim-ultisnips')

-- For snippy users.
  use ('dcampos/nvim-snippy')
  use ('dcampos/cmp-snippy')

---------------------------------------------------------
  -- CMP-NVIM-LSP
  -- cmp-buffer
  --

  -- cmp_luasnip
  --
  -- Installation
  use { 'L3MON4D3/LuaSnip' }
  use {
	  'hrsh7th/nvim-cmp',
	  config = function ()
		  require'cmp'.setup {
			  snippet = {
				  expand = function(args)
					  require'luasnip'.lsp_expand(args.body)
				  end
			  },

			  sources = {
				  { name = 'luasnip' },
				  -- more sources
			  },
		  }
	  end
  }
  use { 'saadparwaiz1/cmp_luasnip' }

  use "rafamadriz/friendly-snippets"
  -- Lsp-zero.nvim configurations 
  --

  use ('VonHeikemen/lsp-zero.nvim')
  
  local lsp_zero = require('lsp-zero')

  lsp_zero.on_attach(function(client, bufnr)
	  local opts = {buffer = bufnr, remap = false}

	  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end)

  require('mason').setup({})
  require('mason-lspconfig').setup({
	  ensure_installed = {'tsserver', 'rust_analyzer'},
	  handlers = {
		  lsp_zero.default_setup,
		  lua_ls = function()
			  local lua_opts = lsp_zero.nvim_lua_ls()
			  require('lspconfig').lua_ls.setup(lua_opts)
		  end,
	  }
  })

  local cmp = require('cmp')
  local cmp_select = {behavior = cmp.SelectBehavior.Select}

  cmp.setup({
	  sources = {
		  {name = 'path'},
		  {name = 'nvim_lsp'},
		  {name = 'nvim_lua'},
		  {name = 'luasnip', keyword_length = 2},
		  {name = 'buffer', keyword_length = 3},
	  },
	  formatting = lsp_zero.cmp_format(),
	  mapping = cmp.mapping.preset.insert({
		  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		  ['<C-Space>'] = cmp.mapping.complete(),
	  }),
  })
 end)
