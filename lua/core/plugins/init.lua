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

local formatting = require("core.plugins.formatting")
local ui = require("core.plugins.ui")
local lsp = require("core.plugins.lsp")
local editor = require("core.plugins.editor")
local treesitter = require("core.plugins.treesitter")
local coding = require("core.plugins.coding")
local colourscheme = require("core.plugins.colorscheme")
local linting = require("core.plugins.linting")
local util = require("core.plugins.util")

local plugins = { formatting, ui, lsp, editor, treesitter, coding, colourscheme, linting, util }
local opts = {}
require("lazy").setup(plugins, opts)
