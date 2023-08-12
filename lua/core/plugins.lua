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
	"folke/which-key.nvim",

	{ -- Directory Management
		{
			"stevearc/oil.nvim",
			opts = {},
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		{
			"ThePrimeagen/harpoon",
			config = function()
				local harpoon_status_ok, harpoon = pcall(require, "harpoon")
				if not harpoon_status_ok then
					return
				end

				harpoon.setup({
					menu = {
						width = 60,
					},
				})
			end,
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
		},
	},

	{ -- Terminal Plugin
		"akinsho/toggleterm.nvim",
		keys = { [[<C-\>]] },
		cmd = { "ToggleTerm", "TermExec" },
		module = { "toggleterm", "toggleterm.terminal" },
		config = function()
			require("core.plugin_config.toggleterm.toggleterm").setup()
		end,
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
		},
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-project.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"cljoly/telescope-repo.nvim",
		"stevearc/aerial.nvim",
		"gbprod/yanky.nvim",
		"kevinhwang91/nvim-bqf",
		{
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"nvim-telescope/telescope-symbols.nvim",
			dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
		},
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		dependencies = { "kkharji/sqlite.lua" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		cond = vim.fn.executable("make") == 1,
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	{ --LSP
		{
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			dependencies = {
				{ "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", config = true },
				{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
				{ "folke/neodev.nvim", config = true },
				{ "smjonas/inc-rename.nvim", config = true },
				"simrat39/rust-tools.nvim",
				"rust-lang/rust.vim",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"b0o/schemastore.nvim",
				"nvim-lua/plenary.nvim",
				"RRethy/vim-illuminate",
			},
			config = function(plugin)
				require("core.plugin_config.LSP.lsp_config").setup(plugin)
			end,
		},
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			ensure_installed = {
				"stylua",
				"ruff",
			},
			config = function(plugin)
				require("mason").setup()
				local mr = require("mason-registry")
				for _, tool in ipairs(plugin.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			event = "BufReadPre",
			dependencies = { "mason.nvim" },
			config = function()
				local nls = require("null-ls")
				nls.setup({
					sources = {
						nls.builtins.formatting.stylua,
						nls.builtins.diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
					},
				})
			end,
		},
		{
			"utilyre/barbecue.nvim",
			event = "VeryLazy",
			dependencies = {
				"neovim/nvim-lspconfig",
				"SmiteshP/nvim-navic",
				"nvim-tree/nvim-web-devicons",
			},
			config = true,
		},
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
		{
			"m-demare/hlargs.nvim",
			config = function()
				require("hlargs").setup()
			end,
		},
	},

	{ -- BCE
		"karb94/neoscroll.nvim",
		"lukas-reineke/indent-blankline.nvim",
		{
			"gelguy/wilder.nvim",
			build = ":UpdateRemotePlugins",
			dependencies = {
				"roxma/nvim-yarp",
				"roxma/vim-hug-neovim-rpc",
				"nixprime/cpsm",
				"romgrk/fzy-lua-native",
				"sharkdp/fd",
			},
		},
		{
			"echasnovski/mini.map",
			branch = "stable",
			event = "BufWinEnter",
			dependencies = { "dstein64/nvim-scrollview", enabled = false },
		},

		{
			"petertriho/nvim-scrollbar",
			dependencies = {
				"kevinhwang91/nvim-hlslens",
				"folke/tokyonight.nvim",
				lazy = false,
				priority = 1000,
				opts = {},
			},
		},

		{
			"goolord/alpha-nvim",
			event = "VimEnter",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		{
			"anuvyklack/windows.nvim",
			dependencies = {
				"anuvyklack/middleclass",
				"anuvyklack/animation.nvim",
			},
		},

		{
			"gen740/SmoothCursor.nvim",
			config = function()
				require("smoothcursor").setup()
			end,
		},
		{
			"kevinhwang91/nvim-ufo",
			dependencies = { "kevinhwang91/promise-async" },
		},
	},
}

local opts = {}
require("lazy").setup(plugins, opts)
