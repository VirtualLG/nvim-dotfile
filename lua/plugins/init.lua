local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons" -- icons
  use "drmikehenry/vim-fixkey"
  use {
    'williamboman/mason.nvim',
    config = function()
      require("plugins.configs.others").config_mason()
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require("plugins.configs.treesitter")
    end,
  }
  use "MTDL9/vim-log-highlighting"

  -- LSP
  use {
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',
    config = function()
      require("plugins.configs.others").config_mason_lsp()
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    after = 'mason-lspconfig.nvim',
    config = function()
      require("plugins.configs.nvim-lspconfig")
    end,
  }

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
    requires = 'nvim-telescope/telescope-live-grep-args.nvim',
    config = function()
      require("telescope").load_extension("live_grep_args")
      require("plugins.configs.telescope")
      require("mappings").telescope()
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("plugins.configs.gitsigns")
    end,
  }
  use {
    'sindrets/diffview.nvim',
    event = "BufRead",
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'tpope/vim-fugitive',
    config = function()
      require("mappings").fugitive()
    end,
  }

  -- Editor enhance
  use {
    'tpope/vim-repeat',
  }

  use {
    "tpope/vim-surround",
  }

  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.comment")
    end,
  }

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
  }

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use "saadparwaiz1/cmp_luasnip"
  use {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    config = function()
      require("plugins.configs.cmp")
    end,
  }

  -- Navigator
  use {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      require("mappings").hop()
    end,
  }
  use {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
	require("nvim-lastplace").setup({
	    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	    lastplace_ignore_filetype = {
		"gitcommit", "gitrebase", "svn", "hgcommit",
	    },
	    lastplace_open_folds = true,
	})
    end,
  }
  use {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
            hide_cursor = true,          -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,        -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,              -- Function to run after the scrolling animation ends
            })
    end,
  }
  use "jsfaint/gen_tags.vim"         -- tag support
  -- Debug

  --UI
  use {
    'goolord/alpha-nvim',
    config = function()
      require("plugins.configs.alpha")
    end,
  }
  use {
    'Mofiqul/dracula.nvim',
    -- config = 'vim.cmd[[colorscheme dracula]]'
  }
  use {
    'UtkarshVerma/molokai.nvim',
    config = 'vim.cmd[[ colorscheme molokai ]]'
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("plugins.configs.lualine")
    end,
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("plugins.configs.bufferline")
      require("mappings").bufferline()
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("plugins.configs.nvim-tree")
      require("mappings").nvimtree()
    end,
  }
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("plugins.configs.symbols-outline")
      require("mappings").symbols()
    end,
  }
  use {
    'lfv89/vim-interestingwords',
    -- config = vim.cmd [[
      -- " let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
      -- " let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
    -- ]]
  }

  -- Misc
  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.trouble")
      require("mappings").trouble()
    end,
  }

  use {
    'akinsho/toggleterm.nvim', tag = 'v2.2.1',
    config = function()
      require("plugins.configs.toggleterm")
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

