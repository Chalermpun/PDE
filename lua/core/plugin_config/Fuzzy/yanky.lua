local mapping = require("yanky.telescope.mapping")
local mappings = mapping.get_defaults()
local actions = require("telescope.actions")
mappings.i = {
	["<C-j>"] = actions.move_selection_next,
	["<C-k>"] = actions.move_selection_previous,
	["<C-n>"] = actions.cycle_history_next,
	["<C-p>"] = actions.cycle_history_prev,
}

require("yanky").setup({
	ring = {
		history_length = 100,
		storage = "shada",
		sync_with_numbered_registers = true,
		cancel_event = "update",
	},
	picker = {
		telescope = {
			use_default_mappings = false,
			mappings = mappings,
		},
	},
	system_clipboard = {
		sync_with_ring = true,
	},
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 250,
	},
	preserve_cursor_position = {
		enabled = true,
	},
})

vim.cmd([[hi YankyYanked guifg=#000000 guibg=#ffffff]])
vim.cmd([[hi YankyPut guifg=#000000 guibg=#ffffff]])
