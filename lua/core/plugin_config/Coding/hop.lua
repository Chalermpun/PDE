require("hop").setup({}) -- testing out Hop.nvim with vim.schedule
local opts = { noremap = true, silent = true }
local function jump_back_to_original_buffer(original_buffer) --{{{
	local current_buffer = vim.api.nvim_get_current_buf()

	if current_buffer ~= original_buffer then
		-- jump back to the original buffer
		vim.cmd([[normal! ]])
	else
		-- jump back to the original line
		vim.cmd([[normal! ]])
	end
end --}}}

vim.keymap.set("n", "yx", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd([[:HopLineStartMW]]) --> jump to line
	vim.schedule(function()
		require("syntax-tree-surfer").select()
		vim.cmd([[normal! V]]) --> go to visual selection mode -> optional
		vim.cmd([[normal! x]]) --> yank
		jump_back_to_original_buffer(original_buffer)
	end)
end, { noremap = true, silent = true, desc = "Hop Cut Block" })

-- SECTION: Hyper Yank
-- NOTE: Hyper Yank with Treesitter Node Select
vim.keymap.set("n", "ym", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd([[:HopLineStartMW]]) --> jump to line
	vim.schedule(function()
		require("syntax-tree-surfer").select()
		vim.cmd([[normal! V]]) --> go to visual selection mode -> optional
		vim.cmd([[normal! y]]) --> yank
		jump_back_to_original_buffer(original_buffer)
	end)
end, { noremap = true, silent = true, desc = "Hop Copy Block" })

-- NOTE: Hyper Yank a line
vim.keymap.set("n", "yl", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd([[:HopLineStartMW]]) --> jump to line
	vim.schedule(function()
		vim.cmd([[normal! yy]]) --> yank the line
		jump_back_to_original_buffer(original_buffer)
	end)
end, { noremap = true, silent = true, desc = "Hop Copy Line" })

vim.keymap.set("n", "vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Below Without Enter" })

vim.keymap.set("n", "<Leader>vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Below With Enter" })

vim.keymap.set("n", "vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Above Without Enter" })

vim.keymap.set("n", "<Leader>vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! O]]) --> make another new line below target
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true, desc = "Hop Paste Above With Enter" })

vim.keymap.set("n", "vo", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true, desc = "Hop Insert Below Without Enter" })

vim.keymap.set("n", "<Leader>vo", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true, desc = "Hop Insert Below With Enter" })

vim.keymap.set("n", "vO", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! O]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true, desc = "Hop Insert Above without Enter" })

vim.keymap.set("n", "<Leader>vO", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! O]])
		vim.cmd([[normal! O]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true, desc = "Hop Insert Above with Enter" })

--  NOTE: Hop with Macros

vim.keymap.set("n", "vC", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[:normal @f]])
	end)
end, { noremap = true, silent = true, desc = "Hop record Function with f" })

--  NOTE: TSHT (Treesitter hint textobject) --> mfussenegger/nvim-treehopper

vim.keymap.set("n", "vc", function()
	require("tsht").nodes()
	vim.schedule(function()
		vim.cmd([[normal! c]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true, desc = "Hop Change according to treeobject" })

-- place this in one of your configuration file(s)
local hop = require("hop")
vim.keymap.set("", "f", function()
	hop.hint_char1({ current_line_only = true })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_words({ current_line_only = false })
end, { remap = true })
