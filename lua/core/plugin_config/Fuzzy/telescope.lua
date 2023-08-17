--[[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
local nvb_actions = transform_mod({
	file_path = function(prompt_bufnr)
		-- Get selected entry and the file full path
		local content = require("telescope.actions.state").get_selected_entry()
		local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

		-- Yank the path to unnamed and clipboard registers
		vim.fn.setreg('"', full_path)
		vim.fn.setreg("+", full_path)

		-- Close the popup
		require("telescope.actions").close(prompt_bufnr)
	end,

	-- VisiData
	visidata = function(prompt_bufnr)
		-- Get the full path
		local content = require("telescope.actions.state").get_selected_entry()
		local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

		-- Close the Telescope window
		require("telescope.actions").close(prompt_bufnr)

		-- Open the file with VisiData
		local term = require("core.plugin_config.Terminal.term")
		term.open_term("vd " .. full_path, { direction = "float" })
	end,
})

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
		},
	},
	preview = {
		mime_hook = function(filepath, bufnr, opts)
			local is_image = function(filepath)
				local image_extensions = { "png", "jpg", "jpeg", "gif" } -- Supported image formats
				local split_path = vim.split(filepath:lower(), ".", { plain = true })
				local extension = split_path[#split_path]
				return vim.tbl_contains(image_extensions, extension)
			end
			if is_image(filepath) then
				local term = vim.api.nvim_open_term(bufnr, {})
				local function send_output(_, data, _)
					for _, d in ipairs(data) do
						vim.api.nvim_chan_send(term, d .. "\r\n")
					end
				end
				vim.fn.jobstart({
					"viu",
					"-w",
					"40",
					"-b",
					filepath,
				}, {
					on_stdout = send_output,
					stdout_buffered = true,
				})
			else
				require("telescope.previewers.utils").set_preview_message(
					bufnr,
					opts.winid,
					"Binary cannot be previewed"
				)
			end
		end,
	},
	pickers = {
		find_files = {
			theme = "ivy",
			mappings = {
				n = {
					["y"] = nvb_actions.file_path,
					["s"] = nvb_actions.visidata,
				},
				i = {
					["<C-y>"] = nvb_actions.file_path,
					["<C-s>"] = nvb_actions.visidata,
				},
			},
			hidden = true,
			find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
		},
		git_files = {
			theme = "dropdown",
			mappings = {
				n = {
					["y"] = nvb_actions.file_path,
					["s"] = nvb_actions.visidata,
				},
				i = {
					["<C-y>"] = nvb_actions.file_path,
					["<C-s>"] = nvb_actions.visidata,
				},
			},
		},
	},
	extensions = {
		aerial = {
			-- Display symbols as <root>.<parent>.<symbol>
			show_nesting = {
				["_"] = false, -- This key will be the default
				json = true, -- You can set the option for specific filetypes
				yaml = true,
			},
		},
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
require("telescope").load_extension("aerial")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project") -- telescope-project.nvim
require("telescope").load_extension("projects") -- project.nvim
require("telescope").load_extension("repo")
require("telescope").load_extension("media_files")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("dap")
