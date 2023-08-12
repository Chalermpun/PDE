local function cmd(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end

vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"))
vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"))
vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"))
vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))

require("windows").setup({
	autowidth = { --		       |windows.autowidth|
		enable = false,
		winwidth = 5, --		        |windows.winwidth|
		filetype = { --	      |windows.autowidth.filetype|
			help = 2,
		},
	},
	ignore = { --			  |windows.ignore|
		buftype = { "quickfix" },
		filetype = {
			"diffviewfilepanel",
			"NvimTree",
			"DiffviewFilePanel",
			"neo-tree",
			"undotree",
			"gundo",
		},
	},
})
