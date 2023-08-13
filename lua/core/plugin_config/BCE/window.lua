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
