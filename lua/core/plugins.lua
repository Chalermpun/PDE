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

	"christoomey/vim-tmux-navigator",
	"numToStr/Comment.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"famiu/bufdelete.nvim",
	"ThePrimeagen/harpoon",
	"lukas-reineke/indent-blankline.nvim",
	"kevinhwang91/nvim-bqf",
	"vim-scripts/Tabmerge",
	"derektata/lorem.nvim",
	"hkupty/iron.nvim",
	"nyngwang/NeoZoom.lua",
	"kevinhwang91/nvim-hlslens",
	"karb94/neoscroll.nvim",
	"AckslD/swenv.nvim",
	"stevearc/dressing.nvim",
	"echasnovski/mini.nvim",
	"norcalli/nvim-colorizer.lua",
	"freddiehaddad/feline.nvim",
	"EdenEast/nightfox.nvim",
	"tamton-aquib/zone.nvim",
  'mg979/vim-visual-multi',

	----------------------------------------------------------------

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				cond = vim.fn.executable("make") == 1,
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = {
					"nvim-telescope/telescope.nvim",
					"nvim-lua/plenary.nvim",
				},
			},
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
	},
	{ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",
	"f-person/git-blame.nvim",

	-- DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("dap").virtual_text = true
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
	},
	---------------------------------------------------------------

	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"nvim-neorg/neorg",
		ft = "norg",
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"phaazon/hop.nvim",
		dependencies = {
			"ziontee113/syntax-tree-surfer",
			"mfussenegger/nvim-treehopper",
		},
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	{
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	},
  

	--------------------------------------------------------------

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
		},
	},

	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	},
}

local opts = {}
require("lazy").setup(plugins, opts)
