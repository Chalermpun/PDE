local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local dap_python = require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
