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
	opts = function()
		return {
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
			overseer = {
				enabled = true,
				force_default = true,
			},
		}
	end,
})
