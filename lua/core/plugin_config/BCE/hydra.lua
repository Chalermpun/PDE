local Hydra = require("hydra")

Hydra({
	name = "Side scroll",
	mode = "n",
	body = "<leader>o",
	heads = {
		{ "h", "5<C-w><" },
		{ "l", "5<C-w>>" },
		{ "j", "5<C-w>+" },
		{ "k", "5<C-w>-" },
	},
})
