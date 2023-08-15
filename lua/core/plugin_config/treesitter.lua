-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
local swap_next, swap_prev = (function()
	local swap_objects = {
		a = "@parameter.inner",
		f = "@function.outer",
		c = "@class.outer",
	}

	-- local n, p = {}, {}
	-- for key, obj in pairs(swap_objects) do
	-- 	n[string.format("<A-n><A-%s>", key)] = obj
	-- 	p[string.format("<A-p><A-%s>", key)] = obj
	-- end

	local n, p = {}, {}
	for key, obj in pairs(swap_objects) do
		n[string.format("<A-n>%s", key)] = obj
		p[string.format("<A-p>%s", key)] = obj
	end

	return n, p
end)()

require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "python", "rust", "vim", "lua", "http", "json", "latex" },
	modules = {},
	auto_install = true,
	sync_install = true,
	ignore_install = {},

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<a-space>",
			node_incremental = "<a-space>",
			scope_incremental = "<a-s>",
			node_decremental = "<a-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]]"] = "@class.outer",
				["]a"] = "@parameter.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]["] = "@class.outer",
				["]A"] = "@parameter.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[["] = "@class.outer",
				["[a"] = "@parameter.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[]"] = "@class.outer",
				["[A"] = "@parameter.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = swap_next,
			swap_previous = swap_prev,
		},
		autopairs = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	},
})
