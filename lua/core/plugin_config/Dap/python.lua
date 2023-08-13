local M = {}

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

function M.setup(_)
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end
return M
