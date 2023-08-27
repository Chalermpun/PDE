-- Colorscheme
vim.cmd("colorscheme catppuccin-mocha")
vim.cmd("highlight visual guibg=#ffffff guifg=#000000")
vim.cmd("highlight HighlightUndo guibg=#ffffff guifg=#000000")

vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

vim.cmd([[hi Cursor guibg=yellow]])
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.cmd([[hi Cursor guibg=white]])
	end,
})
