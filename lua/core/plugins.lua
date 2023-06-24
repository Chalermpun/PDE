local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"EdenEast/nightfox.nvim",
	"nvim-lualine/lualine.nvim",
	"dbinagi/nomodoro",
	"vim-scripts/Tabmerge",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"numToStr/Comment.nvim",
	{ "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
	},
	{ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", cond = vim.fn.executable("make") == 1 },

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
	},
	{ "j-hui/fidget.nvim", tag = "legacy" },

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	"jose-elias-alvarez/null-ls.nvim",
	"norcalli/nvim-colorizer.lua",
	{
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("dap").virtual_text = true
		end,
	},
	{ "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  'AckslD/swenv.nvim',
  'stevearc/dressing.nvim',
"nvim-neotest/neotest-python",
{
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
  }
}
}

require("lazy").setup(plugins, opts)
