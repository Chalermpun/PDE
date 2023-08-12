local map = require("mini.map")
map.setup({
	integrations = {
		map.gen_integration.builtin_search(),
		map.gen_integration.diagnostic({
			error = "DiagnosticFloatingError",
			warn = "DiagnosticFloatingWarn",
			info = "DiagnosticFloatingInfo",
			hint = "DiagnosticFloatingHint",
		}),
	},
	symbols = {
		encode = map.gen_encode_symbols.dot("4x2"),
		scroll_line = "",
	},
	window = {
		side = "right",
		width = 10, -- set to 1 for a pure scrollbar :)
		winblend = 15,
		show_integration_count = false,
		focusable = true,
	},
})

-- custom auto comman disini
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		local exclude_ft = {
			"qf",
			"NvimTree",
			"toggleterm",
			"TelescopePrompt",
			"alpha",
			"netrw",
		}
	end,
})
