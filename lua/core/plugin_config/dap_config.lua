local dap, dapui = require("dap"), require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "watches",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "scopes",
					size = 0.25,
				},
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.5,
				},
				{
					id = "console",
					size = 0.5,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<Leader>dn", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "cdb", ":lua require 'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n", "do", ":lua require 'dap'.step_over()<CR>")
vim.keymap.set("n", "di", ":lua require 'dap'.step_into()<CR>")
vim.keymap.set("n", "dt", ":lua require 'dap'.step_out()<CR>")
vim.keymap.set("n", "du", ":lua require 'dap'.step_back()<CR>")
vim.keymap.set("n", "dr", ":lua require 'dap'.restart()<CR>")
vim.keymap.set("n", "<Leader>B", ":lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
