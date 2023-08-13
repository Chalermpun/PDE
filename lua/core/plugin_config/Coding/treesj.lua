require("treesj").setup({
	use_default_keymaps = false,
})

local langs = require("treesj.langs")["presets"]

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		if langs[vim.bo.filetype] then
			vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", { buffer = true, desc = "TSJSplit" })
			vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", { buffer = true, desc = "TSJJoin" })
		else
			vim.keymap.set("n", "gS", "<Cmd>SplitjoinSplit<CR>", { buffer = true, desc = "TSJSplit" })
			vim.keymap.set("n", "gJ", "<Cmd>SplitjoinJoin<CR>", { buffer = true, desc = "TSJJoin" })
		end
	end,
})
