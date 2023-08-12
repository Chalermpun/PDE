vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "Neotree Toggle" })
vim.keymap.set("n", "<leader>at", "<cmd>lua require('hlargs').toggle()<cr>", { desc = "Highlight Args" })
vim.keymap.set(
	"n",
	"<leader><leader>",
	":lua require('telescope').extensions.frecency.frecency()<CR>",
	{ desc = "Telescope Frecency" }
)
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end, { desc = "Trouble LSP References" })
vim.keymap.set("n", "<leader>tw", function()
	require("trouble").open("workspace_diagnostics")
end, { desc = "Trouble Workspace Diagnostic" })
vim.keymap.set("n", "<leader>td", function()
	require("trouble").open("document_diagnostics")
end, { desc = "Trouble Document Diagnostic" })
vim.keymap.set("n", "<leader>tq", function()
	require("trouble").open("quickfix")
end, { desc = "Trouble Quickfix" })

local whichkey = require("which-key")
local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
	spelling = {
		enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
		suggestions = 20, -- how many suggestions should be shown in the list?
	},
}

local leaders = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>ar", "<cmd>AerialToggle!<CR>")
local mappings_leader = {
	a = {
		a = { "<cmd>WhichKey<cr>", "WhichKey" },
		r = { "<cmd>AerialToggle<cr>", "AerialToggle" },
	},
	b = {
		t = { "<cmd>Barbecue toggle<cr>", "Barbecue Toggle" },
		u = { "<cmd>lua require('barbecue.ui').update()<cr>", "Barbecue Update" },
		p = { "<cmd>lua require('barbecue.ui').navigate(-2)<cr>", "Barbecue Previous" },
	},
	d = {
		dh = { vim.diagnostic.hide, "Hide Diagnostic" },
		ds = { vim.diagnostic.show, "Show Diagnostic" },
	},
	e = { vim.diagnostic.open_float, "Open Float Diagnostic" },
	f = {
		name = "Telescope",
		s = {
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			"Telescope Live Grep Args",
		},
		y = { "<cmd>lua require('telescope').extensions.yank_history.yank_history()<CR>", "Telescope Yank History" },
		a = { "<cmd>lua require('telescope').extensions.aerial.aerial()<CR>", "Telescope Aerial" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Telescope Oldfiles" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Telescope Live Grep" },
		f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Telescope Find Files" },
		b = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", "Telescope File Browser" },
		m = { vim.lsp.buf.format, "LSP formatting" },
	},

	m = {
		name = "Minimap",
		o = { "<cmd>lua require('mini.map').open()<cr>", "Minimap Open" },
		c = { "<cmd>lua require('mini.map').close()<cr>", "Minimap Close" },
		f = { "<cmd>lua require('mini.map').toggle_focus()<cr>", "Minimap Focus" },
	},

	h = { "<cmd>nohlsearch<cr>", "No Highlight Search" },
	i = {
		ih = { "<cmd>IlluminatePause<cr>", "IlluminatePause" },
		is = { "<cmd>IlluminateResume<cr>", "IlluminateResume" },
	},
	q = { "<cmd>qa!<cr>", "Quit ALL" },
	t = {
		t = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
	},
	w = { "<cmd>wa<cr>", "Save All" },
	x = {
		name = "External",
		p = { "<cmd>lua require('core.plugin_config.toggleterm.term').project_info_toggle()<CR>", "Project Info" },
		s = { "<cmd>lua require('core.plugin_config.toggleterm.term').system_info_toggle()<CR>", "System Info" },
		c = { "<cmd>lua require('core.plugin_config.toggleterm.term').cht()<CR>", "Cheatsheet" },
		i = {
			"<cmd>lua require('core.plugin_config.toggleterm.term').interactive_cheatsheet_toggle()<CR>",
			"Interactive Cheatsheet",
		},
		o = {
			"<cmd>lua require('core.plugin_config.toggleterm.term').so()<CR>",
			"Stack Overflow",
		},
		d = { "<cmd>lua require('core.plugin_config.toggleterm.term').docker_client_toggle()<CR>", "Docker" },
	},
}

whichkey.setup(conf)
whichkey.register(mappings_leader, leaders)
