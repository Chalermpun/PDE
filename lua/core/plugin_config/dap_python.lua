local dap = require('dap')
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .."/mason/")
require('dap-python').setup(mason_path .. "packages/debugpy/venv/bin/python")

-- dap.adapters.python = {
--   type = 'executable',
--   command = '/usr/local/bin/python3',
--   args = { '-m', 'debugpy.adapter' },
-- }

-- dap.configurations.python = {
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'Launch file',
--     program = '${file}',
--     pythonPath ='/usr/local/bin/python3'
--   },
-- }
--
-- dap_python.resolve_python = function()
--   return '/usr/local/bin/python3'
-- end


