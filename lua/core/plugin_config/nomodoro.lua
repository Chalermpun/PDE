-- Nomodoro Timer
require("nomodoro").setup({
	work_time = 25,
	break_time = 5,
	menu_available = true,
	texts = {
		on_break_complete = "TIME IS UP!",
		on_work_complete = "TIME IS UP!",
		status_icon = " ",
		timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
	},
	on_work_complete = function() end,
	on_break_complete = function() end,
})

local aopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>nw", "<cmd>NomoWork<cr>", aopts)
vim.api.nvim_set_keymap("n", "<leader>nb", "<cmd>NomoBreak<cr>", aopts)
vim.api.nvim_set_keymap("n", "<leader>ns", "<cmd>NomoStop<cr>", aopts)

