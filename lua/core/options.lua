-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.codeium_disable_bindings = 1
vim.g.VM_default_mappings = 0
vim.g.VM_maps = {
	["Find Under"] = "<leader>mn",
	["Find Subword Under"] = "<leader>mn",
	["Select Cursor Down"] = "<M-j>",
	["Select Cursor Up"] = "<M-k>",
	["Align"] = "<M-a>",
	["Exit"] = "<C-C>",
}

vim.opt.splitright = true
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.spelllang = "en_us"
vim.opt.spell = false

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.cmd([[ set noswapfile ]])

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Wrap
vim.wo.wrap = false

vim.o.mouse = "a"
vim.o.termguicolors = true

-- Folding
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Window
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
