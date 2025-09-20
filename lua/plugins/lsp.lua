local function setup_diagnostics()
	local enabled = true
	return function()
		enabled = not enabled
		vim.diagnostic.enable(enabled)
	end
end

local function setup_navbuddy()
	local navbuddy = require("nvim-navbuddy")
	local actions = require("nvim-navbuddy.actions")

	navbuddy.setup({
		window = {
			border = "single",
			size = "60%",
			position = "50%",
			sections = {
				left = { size = "20%" },
				mid = { size = "40%" },
				right = { preview = "leaf" },
			},
		},
		node_markers = {
			enabled = true,
			icons = { leaf = "  ", leaf_selected = " → ", branch = " " },
		},
		icons = require("config.util").defaults.icons.kinds,
		use_default_mappings = true,
		mappings = {
			["<esc>"] = actions.close(),
			["q"] = actions.close(),
			["j"] = actions.next_sibling(),
			["k"] = actions.previous_sibling(),
			["h"] = actions.parent(),
			["l"] = actions.children(),
			["0"] = actions.root(),
			["v"] = actions.visual_name(),
			["V"] = actions.visual_scope(),
			["y"] = actions.yank_name(),
			["Y"] = actions.yank_scope(),
			["i"] = actions.insert_name(),
			["I"] = actions.insert_scope(),
			["a"] = actions.append_name(),
			["A"] = actions.append_scope(),
			["r"] = actions.rename(),
			["d"] = actions.delete(),
			["f"] = actions.fold_create(),
			["F"] = actions.fold_delete(),
			["c"] = actions.comment(),
			["<enter>"] = actions.select(),
			["o"] = actions.select(),
			["J"] = actions.move_down(),
			["K"] = actions.move_up(),
			["s"] = actions.toggle_preview(),
			["<C-v>"] = actions.vsplit(),
			["<C-s>"] = actions.hsplit(),
			["t"] = actions.telescope({
				layout_config = {
					height = 0.60,
					width = 0.60,
					prompt_position = "top",
					preview_width = 0.50,
				},
				layout_strategy = "horizontal",
			}),
			["g?"] = actions.help(),
		},
		lsp = { auto_attach = false },
		source_buffer = {
			follow_node = true,
			highlight = true,
			reorient = "smart",
		},
	})
end

local function setup_keymaps(diagnostics_toggle)
	local keymap = vim.keymap.set
	local telescope = require("telescope.builtin")

	keymap("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
	keymap("n", "<leader>Lr", "<cmd>LspStart<cr>", { desc = "Lsp Start" })
	keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
	keymap("n", "<leader>ud", diagnostics_toggle, { desc = "Toggle Diagnostics" })
	keymap("n", "gd", function()
		telescope.lsp_definitions({ reuse_win = true })
	end, { desc = "Goto Definition" })
	keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
	keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
	keymap("n", "gI", function()
		telescope.lsp_implementations({ reuse_win = true })
	end, { desc = "Goto Implementation" })
	keymap("n", "gy", function()
		telescope.lsp_type_definitions({ reuse_win = true })
	end, { desc = "Goto T[y]pe Definition" })
	keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
	keymap("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
	keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	keymap("n", "<leader>cA", function()
		vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
	end, { desc = "Source Action" })
	keymap("n", "<leader>nd", function()
		require("nvim-navbuddy").open()
	end, { desc = "NavBuddy" })
end

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"markdownlint",
				"ruff",
				"mypy",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "yamlls", "jsonls", "pyright", "marksman" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"b0o/schemastore.nvim",
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
				opts = {
					lsp = { auto_attach = true },
					format = {
						formatting_options = nil,
						timeout_ms = 10000,
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.pyright.setup({})
			lspconfig.marksman.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			require("lspconfig").jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas({
							ignore = {
								".eslintrc",
								"package.json",
							},
						}),
						validate = { enable = true },
					},
				},
			})
			setup_navbuddy()
			setup_keymaps(setup_diagnostics())
			local signs = require("config.util").defaults.icons.diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					enable = true,
					text = {
						["ERROR"] = signs.Error,
						["WARN"] = signs.Warn,
						["HINT"] = signs.Hint,
						["INFO"] = signs.Info,
					},
					texthl = {
						["ERROR"] = "DiagnosticDefault",
						["WARN"] = "DiagnosticDefault",
						["HINT"] = "DiagnosticDefault",
						["INFO"] = "DiagnosticDefault",
					},
					numhl = {
						["ERROR"] = "DiagnosticDefault",
						["WARN"] = "DiagnosticDefault",
						["HINT"] = "DiagnosticDefault",
						["INFO"] = "DiagnosticDefault",
					},
					severity_sort = true,
				},
			})

			if vim.lsp.inlay_hint then
				vim.keymap.set("n", "<leader>uh", function()
					vim.lsp.inlay_hint(0, nil)
				end, { desc = "Toggle Inlay Hints" })
			end
		end,
	},
	{
		"rmagatti/goto-preview",
		event = "VeryLazy",
		config = function()
			require("goto-preview").setup({})
			vim.keymap.set(
				"n",
				"gpd",
				"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
				{ desc = "Goto Preview" }
			)
			vim.keymap.set(
				"n",
				"gpt",
				" <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
				{ desc = "Goto Preview Type Definition" }
			)
			vim.keymap.set(
				"n",
				"gpi",
				" <cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
				{ desc = "Goto Preview Implementation" }
			)
			vim.keymap.set(
				"n",
				"gpD",
				" <cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
				{ desc = "Goto Preview Declaration" }
			)
			vim.keymap.set(
				"n",
				"gP",
				" <cmd>lua require('goto-preview').close_all_win()<CR>",
				{ desc = "Goto Preview Close All" }
			)
			vim.keymap.set(
				"n",
				"gpr",
				" <cmd>lua require('goto-preview').goto_preview_references()<CR>",
				{ desc = "Goto Preview References" }
			)
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
		vim.keymap.set("n", "<leader>cr", ":IncRename "),
	},
	{
		"utilyre/barbecue.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("barbecue").setup()
			vim.keymap.set("n", "<leader>Bt", "<cmd>Barbecue toggle<cr>", { desc = "Barbecue Toggle" })
		end,
	},
}
