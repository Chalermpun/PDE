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
		-- branch = "0.1.x",
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
	"AckslD/swenv.nvim",
	"stevearc/dressing.nvim",
	"nvim-neotest/neotest-python",
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	},

	"hkupty/iron.nvim",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",

	"nyngwang/NeoZoom.lua",
	"petertriho/nvim-scrollbar",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "kevinhwang91/nvim-hlslens" },
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	},
	"karb94/neoscroll.nvim",
	{ "echasnovski/mini.nvim", version = false },
	{ "freddiehaddad/feline.nvim" },
	{
		"nvim-neorg/neorg",
		ft = "norg",
	},
	{ "kevinhwang91/nvim-bqf" },
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({ --[[ your config ]]
			})
		end,
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
	"f-person/git-blame.nvim",
	"rcarriga/nvim-notify",
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"christoomey/vim-tmux-navigator",
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- packer boostrapping code
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
	{ "tamton-aquib/zone.nvim" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	"xiyaowong/transparent.nvim",
	"dstein64/vim-startuptime",
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"ThePrimeagen/harpoon",
	"rafamadriz/friendly-snippets",
	{ "derektata/lorem.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"phaazon/hop.nvim",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	"mfussenegger/nvim-treehopper",
	"ziontee113/syntax-tree-surfer",
	"liuchengxu/vista.vim",
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	"marko-cerovac/material.nvim",
	"mg979/vim-visual-multi",
}

local opts = {}
require("lazy").setup(plugins, opts)
