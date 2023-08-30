local Hydra = require("hydra")

Hydra({
	name = "Side scroll",
	mode = "n",
	body = "<leader>o",
	heads = {
		{ "h", "1<C-w><" },
		{ "l", "1<C-w>>" },
		{ "j", "1<C-w>+" },
		{ "k", "1<C-w>-" },
	},
})
