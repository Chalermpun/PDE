require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
				},
			},
		},
	},
})
