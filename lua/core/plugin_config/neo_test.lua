require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = {
				justMyCode = false,
				console = "integratedTerminal",
			},
			args = { "--log-level", "DEBUG", "--quiet" },
			runner = "pytest",
		}),
	},
})

vim.keymap.set("n", "<leader>dm", ":lua require('neotest').run.run()<cr>")
vim.keymap.set("n", "<leader>dM", ":lua require('neotest').run.run({strategy = 'dap'})<cr>")
vim.keymap.set("n", "<leader>df", ":lua require('neotest').run.run({vim.fn.expand('%')})<cr>")
vim.keymap.set("n", "<leader>dF", ":lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>")
vim.keymap.set("n", "<leader>ds", ":lua require('neotest').summary.toggle()<cr>")
