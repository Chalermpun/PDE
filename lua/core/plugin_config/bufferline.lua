-- Bufferline
require("bufferline").setup({})

-- Bufferline keymap
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><Tab>", ":BufferLineMoveNext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><S-Tab>", ":BufferLineMovePrev<CR>", { noremap = true })
