local M = {}

function M.showFugitiveGit()
	if vim.fn.FugitiveHead() ~= "" then
		vim.cmd([[
    topleft vertical Git
    " wincmd H  " Open Git window in vertical split
    " setlocal winfixwidth
    " vertical resize 75
    " setlocal winfixwidth
    setlocal nonumber
    setlocal norelativenumber
    ]])
	end
end

function M.toggleFugitiveGit()
	if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
		vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
	else
		M.showFugitiveGit()
	end
end

return M
