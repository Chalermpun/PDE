local function showFugitiveGit()
	vim.cmd([[
    topleft vertical Git
    setlocal nonumber
    setlocal norelativenumber
    ]])
end

local function toggleFugitiveGit()
	local fugitive_buf_no = vim.fn.bufnr("^fugitive:")
	local buf_win_id = vim.fn.bufwinid(fugitive_buf_no)
	if fugitive_buf_no >= 0 and buf_win_id >= 0 then
		vim.api.nvim_win_close(buf_win_id, false)
	else
		showFugitiveGit()
	end
end

local function set_git_keymaps()
	local map = vim.keymap.set

	-- Git keymaps
	map("n", "<leader>gt", toggleFugitiveGit, { desc = "FugitiveGit" })
	map("n", "<leader>gi", "<cmd>Gitignore<cr>", { desc = "FugitiveGit" })
	map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "DiffviewOpen" })
	map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { silent = true, desc = "DiffviewClose" })
	map("n", "<leader>at", "<cmd>lua require('hlargs').toggle()<cr>", { silent = true, desc = "Highlight Args" })
	map(
		"n",
		"<leader>gY",
		"<cmd>lua require('gitlinker').get_repo_url()<cr>",
		{ silent = true, desc = "Gitlinker Get Repo URL" }
	)
	map(
		"v",
		"<leader>gy",
		"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').copy_to_clipboard, print_url = true})<cr>",
		{ silent = true, desc = "Gitlinker Copy URL with Rank" }
	)
	map(
		"n",
		"<leader>gB",
		"<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker').actions.open_in_browser})<cr>",
		{ silent = true, desc = "Gitlinker Open Repo URL with Browser (Main URL)" }
	)
	map(
		"v",
		"<leader>gb",
		"<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
		{ silent = true, desc = "Git Open Repo with File" }
	)
	map("n", "<C-g>", "<cmd>DiffviewToggle<cr>", { silent = true, desc = "DiffviewToggle" })
	map("n", "<leader>gl", "<cmd>GitBlameToggle<cr>", { silent = true, desc = "GitBlameToggle" })
	map("n", "<leader>gst", "<cmd>Gitsigns toggle_signs<cr>", { silent = true, desc = "GitSignToggle" })

	map("n", "<leader>gcr", "<cmd>GitConflictRefresh<cr>", { desc = "Git Conflict Refresh" })
	map("n", "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", { desc = "Git Conflict Next" })
	map("n", "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", { desc = "Git Conflict Prev" })
	map("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Git Conflict ChooseBoth" })
	map("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Git Conflict ChooseTheirs" })
	map("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Git Conflict ChooseOurs" })
	map("n", "<leader>gcv", "<cmd>Gvdiffsplit!<cr>", { desc = "Git Conflict Diff View" })
end

return {
	"tpope/vim-fugitive",
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = false,
			})
		end,
	},
	"ruifm/gitlinker.nvim",
	"wintermute-cell/gitignore.nvim",

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				change = { text = "▎" },
				delete = { text = "" },
				add = { text = "▎" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				win_config = {
					position = "left",
					width = 40,
					win_opts = {},
				},
			})
			set_git_keymaps()
		end,
	},
	{
		"SuperBo/fugit2.nvim",
		opts = {
			width = 100,
			libgit2_path = "/opt/homebrew/opt/libgit2@1.7/lib/libgit2.1.7.dylib",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			{
				"chrisgrieser/nvim-tinygit", -- optional: for Github PR view
				dependencies = { "stevearc/dressing.nvim" },
			},
		},
		cmd = { "Fugit2Graph" },
		keys = {
			{ "<leader>gg", mode = "n", "<cmd>Fugit2Graph<cr>" },
		},
		config = function(_, opts)
			require("fugit2").setup(opts)
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
}
