vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "bd", "<cmd>:Bdelete<cr>")
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end, { desc = "Trouble LSP References" })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "oil://*" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>lua require('oil').close()<cr>", { buffer = 0 })
	end,
})

vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "Neotree Toggle" })
vim.keymap.set("n", "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>")
vim.keymap.set("n", "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>")
vim.keymap.set("n", "<C-w>=", "<cmd>WindowsEqualize<cr>")
vim.keymap.set("n", "<C-w>z", "<cmd>WindowsMaximize<cr>")
vim.keymap.set("n", "s", "", { noremap = true, nowait = true })
vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>DiffviewToggle<cr>", { silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>bt",
	[[&showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"]],
	{ expr = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, desc = "BufferLineCyclePrev" })
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, desc = "BufferLineCycleNext" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>ts",
	[[&laststatus ? ":set laststatus=0\<cr>" : ":set laststatus=2\<cr>"]],
	{ expr = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>Ft",
	[[&foldcolumn ? ":set foldcolumn=0\<cr>" : ":set foldcolumn=1\<cr>"]],
	{ expr = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>nt",
	[[&number ? ":set nonumber norelativenumber\<cr>" : ":set number relativenumber\<cr>"]],
	{ expr = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>rl",
	[[&cursorline ? ":lua vim.opt.cursorline=false\<cr>" : ":set cursorline\<cr>"]],
	{ expr = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>rp",
	[[&wrap ? ":set nowrap\<cr>" : ":set wrap\<cr>"]],
	{ expr = true, silent = true }
)

vim.keymap.set("i", "<A-m>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Codeium Accept" })
vim.keymap.set("i", "<A-f>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, desc = "Codeium Cycle Next" })
vim.keymap.set("i", "<A-n>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, desc = "Codeium Cycle Prev" })
vim.keymap.set("i", "<A-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, desc = "Codedium Clear" })
vim.keymap.set("i", "<A-s>", function()
	return vim.fn["codeium#Complete"]()
end, { expr = true, desc = "Codedum Complete" })
vim.keymap.set("n", "<S-f>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<S-n>", "<Plug>(YankyCycleBackward)")

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
		r = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
		t = { "<cmd>lua require('hlargs').toggle()<cr>", "Highlight Args" },
	},
	b = {
		p = { "<cmd>BufferLinePick<cr>", "BufferlinePick" },
	},

	B = {
		t = { "<cmd>Barbecue toggle<cr>", "Barbecue Toggle" },
		u = { "<cmd>lua require('barbecue.ui').update()<cr>", "Barbecue Update" },
		p = { "<cmd>lua require('barbecue.ui').navigate(-2)<cr>", "Barbecue Previous" },
	},

	C = {
		name = "ChatGPT",
		c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		t = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
		k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
		d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
		A = { "<cmd>ChatGPTActAs<CR>", "Act As" },
		a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
		o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
		s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
		f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
		r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
	},

	c = {
		g = { "<cmd>Neogen func<Cr>", "Func Doc" },
		G = { "<cmd>Neogen class<Cr>", "Class Doc" },
		d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
	},

	D = { -- Database
		name = "Database",
		u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
		f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
		r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
		q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
	},

	d = {
		dh = { vim.diagnostic.hide, "Hide Diagnostic" },
		ds = { vim.diagnostic.show, "Show Diagnostic" },
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
		U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		dd = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dapui'.open({reset = true})<cr>", "Reset" },
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		T = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoint" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},

	e = { vim.diagnostic.open_float, "Open Float Diagnostic" },
	f = {
		name = "Telescope",
		s = { "<cmd>Telescope symbols<CR>", "Telescope symbols" },
		p = { "<cmd>Telescope projects<CR>", "Telescope projects" },
		r = { "<cmd>Telescope repo<CR>", "Telescope repo" },
		y = { "<cmd>lua require('telescope').extensions.yank_history.yank_history()<CR>", "Telescope Yank History" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Telescope Oldfiles" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Telescope Live Grep" },
		f = { "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", "Telescope Find Files" },
		b = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", "Telescope File Browser" },
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
		t = { "<cmd>GitToggle<cr>", "Git Status" },
		l = { "<cmd>GitBlameToggle<cr>", "Git Blame" },
		st = { "<cmd>Gitsigns toggle_signs<cr>", "Git Sign Toggle" },
	},

	h = { "<cmd>nohlsearch<cr>", "No Highlight Search" },
	H = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Add File" },

	i = {
		ih = { "<cmd>IlluminatePause<cr>", "IlluminatePause" },
		is = { "<cmd>IlluminateResume<cr>", "IlluminateResume" },
		t = { "<cmd>IndentBlanklineToggle<cr>", "Indent Blankline Toggle" },
	},

	j = { "<Plug>RestNvim", "Rest API" },

	m = {
		name = "Minimap",
		o = { "<cmd>lua require('mini.map').open()<cr>", "Minimap Open" },
		c = { "<cmd>lua require('mini.map').close()<cr>", "Minimap Close" },
		f = { "<cmd>lua require('mini.map').toggle_focus()<cr>", "Minimap Focus" },
	},

	n = {
		name = "Neotest",
		a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
		f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
		F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
		l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
		L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
		n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
		N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
		o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
		S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
		s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
	},
	p = { n = { "<cmd>lua require('nabla').popup()<cr>", "Nabla" } },
	q = { "<cmd>qa!<cr>", "Quit ALL" },
	rt = { "<cmd>ScrollbarToggle<cr>", "Scrollbar Toggle" },
	rc = { "<cmd>SmoothCursorToggle<cr>", "SmoothCursor Toggle" },

	S = { "<cmd>lua require('spectre').toggle()<cr>", "Spectre Toggle" },
	s = {
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current word (N)", mode = "n" },
		v = { "<cmd>lua require('spectre').open_visual()<cr>", "Search current word (V)", mode = "v" },
		p = {
			"<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
			"Search on current file (V)",
			mode = "v",
		},
		t = { "<cmd>CtrlSFToggle<cr>", "Search Toggle" },
		f = { "<cmd>CtrlSF<cr>", "Search Words", mode = "v" },
	},

	t = {
		T = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
		w = { "<cmd>lua require('trouble').open('workspace_diagnostics')<cr>", "Trouble Workspace Diagnostic" },
		d = { "<cmd>lua require('trouble').open('document_diagnostics')<cr>", "Trouble Document Diagnostic" },
		q = { "<cmd>lua require('trouble').open('quickfix')<cr>", "Trouble Quickfix" },
		tR = { "<cmd>OverseerRunCmd<cr>", "Run Command" },
		ta = { "<cmd>OverseerTaskAction<cr>", "Task Action" },
		tb = { "<cmd>OverseerBuild<cr>", "Build" },
		tc = { "<cmd>OverseerClose<cr>", "Close" },
		td = { "<cmd>OverseerDeleteBundle<cr>", "Delete Bundle" },
		tl = { "<cmd>OverseerLoadBundle<cr>", "Load Bundle" },
		to = { "<cmd>OverseerOpen<cr>", "Open" },
		tq = { "<cmd>OverseerQuickAction<cr>", "Quick Action" },
		tr = { "<cmd>OverseerRun<cr>", "Run" },
		ts = { "<cmd>OverseerSaveBundle<cr>", "Save Bundle" },
		tt = { "<cmd>OverseerToggle<cr>", "Toggle" },
	},

	v = { s = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Switch Python Environment" } },

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
	y = { "<cmd>lua require('nvim-window').pick()<cr>", "Pick Window" },
	z = {
		z = { "<cmd>NeoZoomToggle<cr>", "NeoZoom" },
		p = { "<cmd>CccPick<cr>", "Color Picker" },
		c = { "<cmd>CccConvert<cr>", "Color Convert" },
		h = { "<cmd>CccHighlighterToggle<cr>", "Color Toggle Highlighter" },
		t = { "<cmd>Telekasten panel<cr>", "Telekasten" },
	},
}

whichkey.setup(conf)
whichkey.register(mappings_leader, leaders)
