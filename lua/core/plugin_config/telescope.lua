-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("file_browser")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<Space><Space>", builtin.oldfiles, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true })

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)
