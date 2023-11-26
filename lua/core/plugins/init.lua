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
local black = require("core.plugins.black")
local prettier = require("core.plugins.prettier")
local docker = require("core.plugins.lang.docker")
local elixir = require("core.plugins.lang.elixir")
local json = require("core.plugins.lang.json")
local markdown = require("core.plugins.lang.markdown")
local tex = require("core.plugins.lang.tex")
local python_semshi = require("core.plugins.lang.python-semshi")
local python = require("core.plugins.lang.python")
local yaml = require("core.plugins.lang.yaml")
local dot = require("core.plugins.dot")
local mini_hipatterns = require("core.plugins.mini-hipatterns")
local project = require("core.plugins.project")

local plugins = {
	formatting,
	lsp,
	editor,
	treesitter,
	coding,
	colourscheme,
	linting,
	util,
	ui,
	black,
	prettier,
	docker,
	elixir,
	json,
	markdown,
	tex,
	python_semshi,
	python,
	yaml,
	dot,
	mini_hipatterns,
	project,
}
local opts = {}
require("lazy").setup(plugins, opts)
