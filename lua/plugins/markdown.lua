return {
	{
		"jbyuki/nabla.nvim",
		keys = { { "<leader>pn", "<cmd>:lua require('nabla').popup()<CR>", desc = "Nabla Popup" } },
	},
	{
		-- Install markdown preview, use npx if available.
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
	},
	{
		"AckslD/nvim-FeMaco.lua",
		config = 'require("femaco").setup()',
	},

	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "org", "norg" },
	},

	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown" },
	},
	{
		"Zeioth/markmap.nvim",
		build = "yarn global add markmap-cli",
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
		opts = {
			html_output = "/tmp/markmap.html",
			hide_toolbar = false,
			grace_period = 3600000,
		},
		config = function(_, opts)
			require("markmap").setup(opts)
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons",
		},

		config = function(_, opts)
			require("markview").setup(opts)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mt",
				":Markview toggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle Markview (Current buffer)" }
			)
		end,
	},
	  {
    "selimacerbas/mermaid-playground.nvim",
    dependencies = {
      "barrett-ruth/live-server.nvim",
      lazy = false,
      config = function()
        require("live-server").setup({
          port = 5500,
          open = true,
        })
      end,
    },
    config = function()
      require("mermaid_playground").setup({
        workspace_dir            = nil,
        index_name               = "index.html",
        diagram_name             = "diagram.mmd",
        overwrite_index_on_start = false,
        auto_refresh             = true,
        auto_refresh_events      = { "InsertLeave", "TextChanged", "TextChangedI", "BufWritePost" },
        debounce_ms              = 450,
        notify_on_refresh        = false,
      })
    end,
  }
}
