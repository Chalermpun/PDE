require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<Leader>dn", ':DapContinue<CR>')
vim.keymap.set("n", "<Leader>db", ':DapToggleBreakpoint<CR>')
vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
vim.keymap.set("n", "do", ":lua require 'dap'.step_over()<CR>")
vim.keymap.set("n", "di", ":lua require 'dap'.step_into()<CR>")
vim.keymap.set("n", "dt", ":lua require 'dap'.step_out()<CR>")
vim.keymap.set("n", "dr", ":lua require 'dap'.restart()<CR>")
vim.keymap.set("n", "<Leader>B", ":lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

