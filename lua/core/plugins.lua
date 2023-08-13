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

	{ -- Coding
		"abecodes/tabout.nvim",
		"derektata/lorem.nvim",

		{
			"uga-rosa/ccc.nvim",
			opts = {},
			cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
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
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},

		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup()
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
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter" },
		},
	},

	{ -- Directory Management
		{
			"stevearc/oil.nvim",
			opts = {},
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
	},

	-- Git related plugins
	{
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		"lewis6991/gitsigns.nvim",
		"f-person/git-blame.nvim",
		"ruifm/gitlinker.nvim",
		"wintermute-cell/gitignore.nvim",
		{
			"sindrets/diffview.nvim",
			config = function()
				require("diffview").setup({
					win_config = { -- See ':h diffview-config-win_config'
						position = "left",
						width = 40,
						win_opts = {},
					},
				})
			end,
		},
	},

	{ -- Terminal Plugin
		"hkupty/iron.nvim",

		{
			"kiyoon/jupynium.nvim",
			build = "pip3 install --user .",
		},
		{
			"akinsho/toggleterm.nvim",
			keys = { [[<C-\>]] },
			cmd = { "ToggleTerm", "TermExec" },
			module = { "toggleterm", "toggleterm.terminal" },
			config = function()
				require("core.plugin_config.Terminal.toggleterm").setup()
			end,
		},

		{
			"jpalardy/vim-slime",
			config = function()
				vim.g.slime_target = "tmux"
				vim.g.slime_default_config = {
					socket_name = "default",
					target_pane = "{last}",
				}
			end,
		},

		{
			"ThePrimeagen/harpoon",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
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
		"chrisbra/unicode.vim",
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
						nls.builtins.diagnostics.ruff,
						nls.builtins.diagnostics.write_good,
						nls.builtins.diagnostics.tsc,
						nls.builtins.diagnostics.shellcheck,
						nls.builtins.diagnostics.hadolint,
						nls.builtins.formatting.black,
						nls.builtins.formatting.isort,
						nls.builtins.formatting.stylua,
						nls.builtins.formatting.fixjson,
						nls.builtins.formatting.prettierd,
						nls.builtins.formatting.shfmt,
						nls.builtins.code_actions.gitsigns,
						nls.builtins.code_actions.gitrebase,
						-- hover
						nls.builtins.hover.dictionary,
					},
					debounce = 150,
					save_after_format = false,
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
		"nvim-treesitter/playground",
		{
			"RRethy/nvim-treesitter-endwise",
			event = "InsertEnter",
		},
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
		"nyngwang/NeoZoom.lua",
		"AckslD/swenv.nvim",
		"vim-scripts/Tabmerge",

		{
			"windwp/nvim-spectre",
			config = function()
				require("spectre").setup()
			end,
		},
		{
			"akinsho/bufferline.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
			config = function()
				require("bufferline").setup()
			end,
		},
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

	{ -- Document Generator
		"kkoomen/vim-doge",
		build = function()
			vim.cmd([[call doge#install()]])
		end,
		dependencies = {
			"danymat/neogen",
		},
	},

	{ -- Interface
		"EdenEast/nightfox.nvim",
		"catppuccin/nvim",
		"freddiehaddad/feline.nvim",
		"dstein64/vim-startuptime",
		"eandrju/cellular-automaton.nvim",
		"tamton-aquib/zone.nvim",
		{
			"stevearc/dressing.nvim",
			opts = {},
		},
		{ "itchyny/calendar.vim", cmd = { "Calendar" } },
		{ "folke/twilight.nvim", opts = {}, cmd = { "Twilight", "TwilightEnable", "TwilightDisable" } },
		{
			"folke/zen-mode.nvim",
			opts = { plugins = { tmux = { enabled = true } } },
			cmd = { "ZenMode" },
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		},
		{
			"goolord/alpha-nvim",
			event = "VimEnter",
			dependencies = { "nvim-tree/nvim-web-devicons" },
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
	},

	{ -- DAP
		{

			"ThePrimeagen/refactoring.nvim",
			config = function()
				require("refactoring").setup()
			end,
		},

		{
			"mfussenegger/nvim-dap",
			event = "BufReadPre",
			module = { "dap" },
			dependencies = {
				"theHamsta/nvim-dap-virtual-text",
				"rcarriga/nvim-dap-ui",
				"mfussenegger/nvim-dap-python",
				"nvim-telescope/telescope-dap.nvim",
				{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
				"nvim-telescope/telescope-media-files.nvim",
			},
			config = function()
				require("core.plugin_config.Dap.dap").setup()
			end,
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

		{
			"stevearc/overseer.nvim",
			opts = {},
		},
	},

	{ --- Database
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("core.plugin_config.dadbod").setup()
		end,
		cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
	},

	{ -- API
		"NTBBloodbath/rest.nvim",
		config = function()
			require("rest-nvim").setup()
		end,
	},

	{ -- AI
		{
			"Exafunction/codeium.vim",
			event = "InsertEnter",
		},
		{
			"jackMort/ChatGPT.nvim",
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},
	},

	{ -- Markdown
		"jbyuki/nabla.nvim",

		{
			"dhruvasagar/vim-table-mode",
			ft = { "markdown", "org", "norg" },
		},
		{
			"iamcco/markdown-preview.nvim",
			build = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = { "MarkdownPreview" },
			dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
		},

		{
			"lukas-reineke/headlines.nvim",
			opts = {},
			ft = { "markdown", "org", "norg" },
		},

		{
			"renerocksai/telekasten.nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
			opts = {
				home = vim.env.HOME .. "/zettelkasten",
			},
			ft = { "markdown" },
			config = function()
				require("telekasten").setup({
					home = vim.fn.expand("~/zettelkasten"),
				})
			end,
		},
		{
			"mzlogin/vim-markdown-toc",
			ft = { "markdown" },
		},
	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
	},
	{
		"jakewvincent/mkdnflow.nvim",
		ft = { "markdown" },
		rocks = "luautf8",
		opts = {},
	},
}

local opts = {}
require("lazy").setup(plugins, opts)
