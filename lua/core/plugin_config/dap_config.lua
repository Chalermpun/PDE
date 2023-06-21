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

vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')


dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = {'-m', 'debugpy.adapter'}
}
dap.configurations.python = {
    {
        type = 'python',
        require = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function() return '/data/data/com.termux/files/usr/bin/python' end,
    },
}
