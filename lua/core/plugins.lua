local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use("wbthomason/packer.nvim")
	use("EdenEast/nightfox.nvim")
  use("nvim-lualine/lualine.nvim")
  use({
    "nvim-neo-tree/neo-tree.nvim",
     branch = "v2.x",
     requires = {"nvim-lua/plenary.nvim",
                 "nvim-tree/nvim-web-devicons",
                 "MunifTanjim/nui.nvim"
                 }
       })

  use("dbinagi/nomodoro")
	use({ 
     "akinsho/bufferline.nvim", 
      tag = "*", 
      requires = "nvim-tree/nvim-web-devicons" 
       })

  use("famiu/bufdelete.nvim")
  use("lukas-reineke/indent-blankline.nvim")
	use("numToStr/Comment.nvim")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})


	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	use({ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
	})
	use({"j-hui/fidget.nvim", tag='legacy'})

	use({ -- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	use "jose-elias-alvarez/null-ls.nvim"
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'mfussenegger/nvim-dap-python'
  use "norcalli/nvim-colorizer.lua"
  use ({"ziontee113/color-picker.nvim",
    config = function()
        require("color-picker")
    end,
      })
  

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
