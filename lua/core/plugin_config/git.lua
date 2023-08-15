-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

local function showFugitiveGit()
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

local function toggleFugitiveGit()
	if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
		vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
	else
		showFugitiveGit()
	end
end

vim.api.nvim_create_user_command("GitToggle", toggleFugitiveGit, {})
