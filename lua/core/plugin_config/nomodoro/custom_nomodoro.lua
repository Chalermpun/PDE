local command = vim.api.nvim_create_user_command
local nomodoro = require("nomodoro")
local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local timer
local notifier

vim.notify = require("notify")
vim.notify.setup({
	minimum_width = 15,
	render = "simple",
})

local function nomodoro_notify()
	timer = vim.loop.new_timer()

	notifier = vim.notify(" 󰔟 Starting ..", "info", {
		title = "  Pomodoro",
		timeout = false,
	})

	local function updateStatus()
		local status = nomodoro.status()
		notifier = vim.notify("   " .. status .. "", "info", {
			replace = notifier,
		})

		if status == "TIME IS UP!" or status == "" then
			timer:close()
			notifier = vim.notify("  TIME IS UP!", "error", {
				title = " Pomodoro",
				replace = notifier,
				timeout = 1000,
			})
			nomodoro.stop()
		end
	end

	timer:start(1000, 1000, vim.schedule_wrap(updateStatus))
end

local function on_close() end
local function show()
	local popup_options = {
		border = {
			style = "rounded",
			padding = { 1, 3 },
		},
		position = "50%",
		size = {
			width = "25%",
		},
		opacity = 1,
	}

	local menu_options = {
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		lines = {
			Menu.item("Continue"),
			Menu.item("Start Work"),
			Menu.item("Start Break"),
			Menu.item("Stop"),
		},
		on_close = on_close,
		on_submit = function(item)
			if item.text == "Start Work" then
				if timer and nomodoro.status() ~= "" or nomodoro.status() == "TIME IS UP!" then
					timer:close()
					notifier = vim.notify("  TIME IS UP!", "error", {
						title = " Pomodoro",
						replace = notifier,
						timeout = 0,
					})
				end
				nomodoro.start(vim.g.nomodoro.work_time)
				nomodoro_notify()
			elseif item.text == "Start Break" then
				if timer and nomodoro.status() ~= "" or nomodoro.status() == "TIME IS UP!" then
					timer:close()
					notifier = vim.notify("  TIME IS UP!", "error", {
						title = " Pomodoro",
						replace = notifier,
						timeout = 0,
					})
				end
				nomodoro.start(vim.g.nomodoro.break_time)
				nomodoro_notify()
			elseif item.text == "Stop" then
				nomodoro.stop()
			elseif item.text == "Continue" then
				if nomodoro.status() == "" then
					nomodoro.start(vim.g.nomodoro.work_time)
					nomodoro_notify()
				else
				end
			end
		end,
	}

	local menu = Menu(popup_options, menu_options)
	menu:mount()

	menu:on(event.BufLeave, function()
		menu:unmount()
	end, { once = true })

	menu:map("n", "q", function()
		menu:unmount()
	end, { noremap = true })
end

command("NomoWk", function()
	show()
end, {})

local aopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>nw", "<cmd>NomoWk<cr>", aopts)
