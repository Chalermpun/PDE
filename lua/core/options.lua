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

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Wrap
vim.wo.wrap = false

vim.o.mouse = "a"
vim.o.termguicolors = true

