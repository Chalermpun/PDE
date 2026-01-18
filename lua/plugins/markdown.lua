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
    "brianhuster/live-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
      "folke/snacks.nvim",
    },
    config = function()
      require("live-preview").setup()

      vim.o.autowriteall = true

      vim.api.nvim_create_autocmd(
        { "InsertLeave", "TextChanged", "TextChangedI" },
        {
          pattern = "*",
          callback = function()
            vim.cmd("silent! write")
          end,
        }
      )
    end,
  }
}
