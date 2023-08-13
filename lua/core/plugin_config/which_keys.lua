vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "bd", "<cmd>:Bdelete<cr>")
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end, { desc = "Trouble LSP References" })

vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "Neotree Toggle" })
vim.keymap.set("n", "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>")
vim.keymap.set("n", "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>")
vim.keymap.set("n", "<C-w>=", "<cmd>WindowsEqualize<cr>")
vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>DiffviewToggle<cr>", { silent = true })

vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, desc = "BufferLineCyclePrev" })
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, desc = "BufferLineCycleNext" })

vim.keymap.set("n", "<A-n>n", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<A-p>p", "<Plug>(YankyCycleBackward)")

----------------- WhichKey ------------------------------
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

local mappings_leader = {
	["<c-e>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon Menu" },
	["<Tab>"] = { "<cmd>BufferLineMoveNext<cr>", "BufferLineMoveNext" },
	["<S-Tab>"] = { "<cmd>BufferLineMovePrev<cr>", "BufferLineMovePrev" },
	["<leader>"] = { "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>", "Telescope Frecency" },

	a = {
		a = { "<cmd>WhichKey<cr>", "WhichKey" },
		r = { "<cmd>AerialToggle<cr>", "AerialToggle" },
		t = { "<cmd>lua require('hlargs').toggle()<cr>", "Highlight Args" },
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
		f = { "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", "Telescope Find Files" },
		b = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", "Telescope File Browser" },
		m = { vim.lsp.buf.format, "LSP formatting" },
	},

	g = {
		Y = { "<cmd>lua require('gitlinker').get_repo_url()<cr>", "Gitlinker Get Repo URL" },
		y = {
			"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').copy_to_clipboard, print_url = true})<cr>",
			"Gitlinker Copy URL with Rank",
			mode = "v",
		},

		B = {
			"<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker').actions.open_in_browser})<cr>",
			"Gitlinker Open Repo URL with Browser (Main URL)",
		},
		b = {
			"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
			"Git Open Repo with File",
			mode = "v",
		},
		d = { "<cmd>DiffviewOpen<cr>", "DiffviewOpen" },
		D = { "<cmd>DiffviewClose<cr>", "DiffviewClose" },
	},

	h = { "<cmd>nohlsearch<cr>", "No Highlight Search" },
	H = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Add File" },

	i = {
		ih = { "<cmd>IlluminatePause<cr>", "IlluminatePause" },
		is = { "<cmd>IlluminateResume<cr>", "IlluminateResume" },
	},

	m = {
		name = "Minimap",
		o = { "<cmd>lua require('mini.map').open()<cr>", "Minimap Open" },
		c = { "<cmd>lua require('mini.map').close()<cr>", "Minimap Close" },
		f = { "<cmd>lua require('mini.map').toggle_focus()<cr>", "Minimap Focus" },
	},
	q = { "<cmd>qa!<cr>", "Quit ALL" },
	r = {
		s = { "<cmd>IronRepl<cr>", "IronRepl" },
		r = { "<cmd>IronRestart<cr>", "IronRestart" },
		f = { "<cmd>IronFocus<cr>", "IronFocus" },
		h = { "<cmd>IronHide<cr>", "IronHide" },
	},

	S = { "<cmd>lua require('spectre').toggle()<cr>", "Spectre Toggle" },
	s = {
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current word (N)", mode = "n" },
		v = { "<cmd>lua require('spectre').open_visual()<cr>", "Search current word (V)", mode = "v" },
		p = {
			"<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
			"Search on current file (V)",
			mode = "v",
		},
	},

	t = {
		t = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
		w = { "<cmd>lua require('trouble').open('workspace_diagnostics')<cr>", "Trouble Workspace Diagnostic" },
		d = { "<cmd>lua require('trouble').open('document_diagnostics')<cr>", "Trouble Document Diagnostic" },
		q = { "<cmd>lua require('trouble').open('quickfix')<cr>", "Trouble Quickfix" },
	},
	v = { s = { "<cmd> lua require('swenv.api).pick_venv()<cr>", "Switch Python Environment" } },

	w = { "<cmd>wa<cr>", "Save All" },
	x = {
		name = "External",
		p = { "<cmd>lua require('core.plugin_config.Terminal.term').project_info_toggle()<CR>", "Project Info" },
		s = { "<cmd>lua require('core.plugin_config.Terminal.term').system_info_toggle()<CR>", "System Info" },
		c = { "<cmd>lua require('core.plugin_config.Terminal.term').cht()<CR>", "Cheatsheet" },
		i = {
			"<cmd>lua require('core.plugin_config.Terminal.term').interactive_cheatsheet_toggle()<CR>",
			"Interactive Cheatsheet",
		},
		o = {
			"<cmd>lua require('core.plugin_config.Terminal.term').so()<CR>",
			"Stack Overflow",
		},
		d = { "<cmd>lua require('core.plugin_config.Terminal.term').docker_client_toggle()<CR>", "Docker" },
	},
	z = { z = { "<cmd>NeoZoomToggle<cr>", "NeoZoom" } },
}

whichkey.setup(conf)
whichkey.register(mappings_leader, leaders)
