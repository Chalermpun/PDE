-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
-- Set cursor color to yellow
vim.cmd("highlight Cursor guifg=yellow guibg=yellow")

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Wrap
vim.wo.wrap = false

vim.o.mouse = "a"
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Define the VM_maps table and set the key-value pairs
vim.g.VM_maps = {
	["Find Under"] = "<C-m>", -- replace C-n
	["Find Subword Under"] = "<C-m>", -- replace visual C-n
	["Select Cursor Down"] = "<M-C-j>", -- start selecting down
	["Select Cursor Up"] = "<M-C-k>", -- start selecting up
}
