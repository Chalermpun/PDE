-- This file is automatically loaded by core.config.init
local Util = require("core.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

-- better up/dow
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <space-o> h,l,k and j keys
local Hydra = require("hydra")
Hydra({
	name = "Side scroll",
	mode = "n",
	body = "<leader>o",
	heads = {
		{ "h", "1<C-w><" },
		{ "l", "1<C-w>>" },
		{ "j", "1<C-w>+" },
		{ "k", "1<C-w>-" },
	},
})

-- Move Lines
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>h",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map("n", "<leader>ws", "<cmd>wa!<cr><esc>", { desc = "Save file" })

-- exit
map("n", "<leader>qq", "<cmd>qa!<cr><esc>", { desc = "Exit" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
local lazyterm = function()
	Util.terminal(nil, { cwd = Util.root() })
end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
	Util.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<C-w>|", "<cmd>WindowsMaximize<cr>", { desc = "Window Maximization", remap = true })
map("n", "<C-w>z", "<cmd>WindowsMaximize<cr>", { desc = "Window Maximization", remap = true })
map("n", "<C-w>=", "<cmd>WindowsEqualize<cr>", { desc = "Window Equalization", remap = true })
map("n", "<leader>y", ":lua require('nvim-window').pick()<CR>", { desc = "Pick windows", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- toggle options
map("n", "<leader>uf", function()
	Util.format.toggle()
end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function()
	Util.format.toggle(true)
end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function()
	Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
	Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function()
	Util.toggle("relativenumber")
end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function()
	Util.toggle.number()
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function()
	Util.toggle.diagnostics()
end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
	Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
	map("n", "<leader>uh", function()
		vim.lsp.inlay_hint(0, nil)
	end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function()
	if vim.b.ts_highlight then
		vim.treesitter.stop()
	else
		vim.treesitter.start()
	end
end, { desc = "Toggle Treesitter Highlight" })
map("n", "<C-g>", "<cmd>DiffviewToggle<cr>", { silent = true, desc = "DiffviewToggle" })
map("n", "<leader>gl", "<cmd>GitBlameToggle<cr>", { silent = true, desc = "GitBlameToggle" })
map("n", "<leader>gst", "<cmd>Gitsigns toggle_signs<cr>", { silent = true, desc = "GitSignToggle" })
map("n", "<leader>gst", "<cmd>Gitsigns toggle_signs<cr>", { silent = true, desc = "GitSignToggle" })
map("n", "<leader>Bt", "<cmd>Barbecue toggle<cr>", { desc = "Barbecue Toggle" })
map("n", "<leader>it", "<cmd>IBLToggle<cr>", { desc = "Indent Blankline Toggle" })
map("n", "<leader>rt", "<cmd>ScrollbarToggle<cr>", { desc = "ScrollbarToggle" })
map("n", "<leader>rc", "<cmd>SmoothCursorToggle<cr>", { desc = "SmoothCursorToggle" })
map("n", "<leader>zz", "<cmd>NeoZoomToggle<cr>", { desc = "NeoZoomToggle" })
map("n", "<leader>il", "<cmd>IlluminateToggle<cr>", { desc = "IlluminateToggle" })
map(
	"n",
	"<leader>bt",
	[[&showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"]],
	{ expr = true, silent = true, desc = "BufferLine Toggle" }
)

map(
	"n",
	"<leader>ts",
	[[&laststatus ? ":set laststatus=0\<cr>" : ":set laststatus=2\<cr>"]],
	{ expr = true, silent = true, desc = "StatusLine Toggle" }
)

map(
	"n",
	"<leader>Ft",
	[[&foldcolumn ? ":set foldcolumn=0\<cr>" : ":set foldcolumn=1\<cr>"]],
	{ expr = true, silent = true, desc = "Folding Toggle" }
)

map(
	"n",
	"<leader>rl",
	[[&cursorline ? ":lua vim.opt.cursorline=false\<cr>" : ":set cursorline\<cr>"]],
	{ expr = true, silent = true, desc = "Folding Toggle" }
)

-- formatting
map({ "n", "v" }, "<leader>cf", function()
	Util.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- git
local git = require("core.util.git")
map("n", "<leader>gt", git.toggleFugitiveGit, { desc = "FugitiveGit" })
map("n", "<leader>gi", "<cmd>Gitignore<cr>", { desc = "FugitiveGit" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "DiffviewOpen" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { silent = true, desc = "DiffviewClose" })
map("n", "<leader>at", "<cmd>lua require('hlargs').toggle()<cr>", { silent = true, desc = "Highlight Args" })
map(
	"n",
	"<leader>gY",
	"<cmd>lua require('gitlinker').get_repo_url()<cr>",
	{ silent = true, desc = "Gitlinker Get Repo URL" }
)
map(
	"v",
	"<leader>gy",
	"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').copy_to_clipboard, print_url = true})<cr>",
	{ silent = true, desc = "Gitlinker Copy URL with Rank" }
)
map(
	"n",
	"<leader>gB",
	"<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker').actions.open_in_browser})<cr>",
	{ silent = true, desc = "Gitlinker Open Repo URL with Browser (Main URL)" }
)
map(
	"v",
	"<leader>gb",
	"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
	{ silent = true, desc = "Git Open Repo with File" }
)

-- Easy Motion
local hop = require("hop")
map({ "n", "v" }, "f", function()
	hop.hint_char1({ current_line_only = true })
end, { remap = true, desc = "Move to Charecter in Current Line" })

map({ "n", "v" }, "t", function()
	hop.hint_words({ current_line_only = false })
end, { remap = true, desc = "Move to Charecter in Other Line" })

vim.keymap.set("n", "vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Below Without Enter" })

vim.keymap.set("n", "<Leader>vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Below With Enter" })

vim.keymap.set("n", "vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Above Without Enter" })

vim.keymap.set("n", "<Leader>vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! O]]) --> make another new line below target
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Above With Enter" })

-- Directory
map("n", "-", require("oil").open, { desc = "Open parent directory" })

-- Pomodoro
map("n", "<leader>nw", "<cmd>NomoWork<cr>", { desc = "NomoWork" })
map("n", "<leader>nb", "<cmd>NomoBreak<cr>", { desc = "NomoBreak" })
map("n", "<leader>ns", "<cmd>NomoStop<cr>", { desc = "NomoStop" })

-- Color Picker
-- l / d / , (1 / 5 / 10) Increase the value times delta of the slider.
-- h / s / m (1 / 5 / 10) Decrease the value times delta of the slider.
-- mapping: H / M / L (0 / 50 / 100), 1 - 9 (10% - 90%)
-- mapping: a Toggle show/hide alpha (transparency) slider.
-- mapping: r Reset input and output to default, and hide alpha slider and previous colors palette.
-- mapping: o Toggle output mode. See |ccc-option-outputs|.
-- mapping: i Toggle input mode. See |ccc-option-inputs|.
map("n", "<leader>zp", "<cmd>CccPick<cr>", { desc = "Color Picker" })
map("n", "<leader>zc", "<cmd>CccConvert<cr>", { desc = "Color Convert" })
map("n", "<leader>zh", "<cmd>CccHighlighterToggle<cr>", { desc = "Color Toggle Highlighter" })

-- Document Generation
map("n", "<leader>cg", "<cmd>Neogen func<Cr>", { desc = "Func Doc" })
map("n", "<leader>cG", "<cmd>Neogen class<Cr>", { desc = "Class Doc" })
map("n", "<leader>cD", "<cmd>DogeGenerate<Cr>", { desc = "Generate Doc" })

-- Markdown
map("n", "<leader>pn", '<cmd>:lua require("nabla").popup()<CR>', { desc = "Nabla Popup" })

-- goto-preview
map("n", "gpd", " <cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Goto Preview Definition" })
map(
	"n",
	"gpt",
	" <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
	{ desc = "Goto Preview Type Definition" }
)
map(
	"n",
	"gpi",
	" <cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
	{ desc = "Goto Preview Implementation" }
)
map(
	"n",
	"gpD",
	" <cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
	{ desc = "Goto Preview Declaration" }
)
map("n", "gP", " <cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Goto Preview Close All" })
map("n", "gpr", " <cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Goto Preview References" })
