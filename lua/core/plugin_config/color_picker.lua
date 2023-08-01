local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>c", "<cmd>PickColor<cr>", opts)
-- vim.keymap.set("i", "<leader>c", "<cmd>PickColorInsert<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

require("color-picker").setup({ -- for changing icons & mappings
	["icons"] = { "󰝤", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
	["text_highlight_group"] = "Normal", --default
})

vim.cmd([[hi FloatBorder guibg=NONE]])

-- h and l will increment the color slider value by 1.
-- u and i will increment the color slider value by 5.
-- s and w will increment the color slider value by 10.
-- o will change your color output
-- Number 0 to 9 will set the slider at your cursor to certain percentages.
-- H sets to 0%, M sets to 50%, L sets to 100%.
