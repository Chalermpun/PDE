-- Move Lines
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set(
	"n",
	"<leader>h",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- save file
vim.keymap.set("n", "<leader>ws", "<cmd>wa!<cr><esc>", { desc = "Save file" })

-- exit
vim.keymap.set("n", "<leader>qq", "<cmd>qa!<cr><esc>", { desc = "Exit" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

local terminal = require("util.terminal").open
-- floating terminal
local lazyterm = function()
	terminal(nil, { cwd = vim.fn.getcwd() })
end
vim.keymap.set("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>fT", function()
	terminal()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Toggle
local toggle = require("util.toggle")
vim.keymap.set("n", "<leader>uw", function()
	toggle.option("wrap")
end, { desc = "Toggle Word Wrap" })

vim.keymap.set("n", "<leader>uL", function()
	toggle.option("relativenumber")
end, { desc = "Toggle Relative Line Numbers" })
vim.keymap.set("n", "<leader>ul", function()
	toggle.number()
end, { desc = "Toggle Line Numbers" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set("n", "<leader>uc", function()
	if vim.o.conceallevel == 0 then
		vim.o.conceallevel = conceallevel
	else
		vim.o.conceallevel = 0
	end
end, { desc = "Toggle Conceal" })
vim.keymap.set(
	"n",
	"<leader>Ts",
	[[&laststatus ? ":set laststatus=0\<cr>" : ":set laststatus=2\<cr>"]],
	{ expr = true, silent = true, desc = "StatusLine Toggle" }
)
vim.keymap.set(
	"n",
	"<leader>Ft",
	[[&foldcolumn ? ":set foldcolumn=0\<cr>" : ":set foldcolumn=1\<cr>"]],
	{ expr = true, silent = true, desc = "Folding Toggle" }
)
vim.keymap.set(
	"n",
	"<leader>rl",
	[[&cursorline ? ":lua vim.opt.cursorline=false\<cr>" : ":set cursorline\<cr>"]],
	{ expr = true, silent = true, desc = "CursorLine Toggle" }
)

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>ch",
	":highlight Cursor gui=reverse guifg=NONE guibg=NONE<CR>",
	{ noremap = true, silent = true }
)

-- Control Size split
vim.keymap.set("n", "<M-Left>", "<c-w>5<")
vim.keymap.set("n", "<M-Right>", "<c-w>5>")
vim.keymap.set("n", "<M-Up>", "<c-w>+")
vim.keymap.set("n", "<M-Down>", "<c-w>-")

vim.api.nvim_set_keymap("n", ".", ".", { noremap = true, silent = true })
