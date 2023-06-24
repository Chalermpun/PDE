local dap = require('dap')
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .."/mason/")


local dap_python = require('dap-python').setup(mason_path .. "packages/debugpy/venv/bin/python")

dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = { '-m', 'debugpy.adapter' },
}

-- dap.configurations.python = {
--     {
--         type = 'python',
--         request = 'launch',
--         name = 'Launch file',
--         program = '${file}',
--         pythonPath = function()
--             return mason_path
--         end,
--     },
-- }
