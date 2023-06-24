-- require("neotest").setup({
--   adapters = {
--     require("neotest-python")({
--       dap = {
--         justMyCode = false,
--         console = "integratedTerminal",
--       },
--       args = { "--log-level", "DEBUG", "--quiet" },
--       runner = "pytest",
--     })
--   }
-- })
--
--
-- vim.keymap.set("n", "<Leader>dm", ":lua require('neotest').run.run()<cr>")
-- vim.keymap.set("n", "<Leader>dM", ":lua require('neotest').run.run({strategy = 'dap'})<cr>")
-- vim.keymap.set("n", "<Leader>df", ":lua require('neotest').run.run({vim.fn.expand('%')})<cr>")
-- vim.keymap.set("n", "<Leader>dF", ":lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>")
-- vim.keymap.set("n", "<Leader>dm", ":lua require('neotest').summary.toggle()<cr>")
require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})
