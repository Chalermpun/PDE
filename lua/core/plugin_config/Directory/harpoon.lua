local harpoon_status_ok, harpoon = pcall(require, "harpoon")
if not harpoon_status_ok then
	return
end

local harpoon_mark_status_ok, harpoon_mark = pcall(require, "harpoon.mark")
if not harpoon_mark_status_ok then
	return
end

local harpoon_ui_status_ok, harpoon_ui = pcall(require, "harpoon.ui")
if not harpoon_ui_status_ok then
	return
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

harpoon.setup({
	menu = {
		width = 60,
	},
})

keymap.set("n", "<leader>H", harpoon_mark.add_file, { noremap = true, silent = true, desc = "Harpoon Add File" })
keymap.set(
	"n",
	"<leader><C-e>",
	harpoon_ui.toggle_quick_menu,
	{ noremap = true, silent = true, desc = "Harpoon Toggle Menu" }
)

keymap.set("n", "<leader>1", function()
	harpoon_ui.nav_file(1)
end, { desc = "Harpoon Nav_File 1" })
keymap.set("n", "<leader>2", function()
	harpoon_ui.nav_file(2)
end, { desc = "Harpoon Nav_File 2" })
keymap.set("n", "<leader>3", function()
	harpoon_ui.nav_file(3)
end, { desc = "Harpoon Nav_File 3" })
keymap.set("n", "<leader>4", function()
	harpoon_ui.nav_file(4)
end, { desc = "Harpoon Nav_File 4" })
keymap.set("n", "<leader>5", function()
	harpoon_ui.nav_file(5)
end, { desc = "Harpoon Nav_File 5" })
keymap.set("n", "<leader>6", function()
	harpoon_ui.nav_file(6)
end, { desc = "Harpoon Nav_File 6" })
keymap.set("n", "<leader>7", function()
	harpoon_ui.nav_file(7)
end, { desc = "Harpoon Nav_File 7" })
keymap.set("n", "<leader>8", function()
	harpoon_ui.nav_file(8)
end, { desc = "Harpoon Nav_File 8" })
keymap.set("n", "<leader>9", function()
	harpoon_ui.nav_file(9)
end, { desc = "Harpoon Nav_File 9" })
