return {
	{
		"Exafunction/windsurf.vim",
		event = "InsertEnter",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<A-m>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, desc = "Codeium Accept" })
			vim.keymap.set("i", "<A-f>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, desc = "Codeium Cycle Next" })
			vim.keymap.set("i", "<A-n>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, desc = "Codeium Cycle Prev" })
			vim.keymap.set("i", "<A-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, desc = "Codedium Clear" })
			vim.keymap.set("i", "<A-s>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true, desc = "Codedum Complete" })
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "openai",
			providers = {
				openai = {
					endpoint = "https://litellm.aigen.online/v1",
					model = "dev-gemini-2.5-pro-preview-05-06",
					extra_request_body = {
						timeout = 30000,
						temperature = 0.75,
						max_completion_tokens = 8192,
					},
				},
				bedrock = {
					model = "us.anthropic.claude-3-7-sonnet-20250219-v1:0",
					aws_profile = "bedrock",
					aws_region = "us-east-1",
				},
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
		},
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup({
				extensions = {
					avante = {
						enabled = true,
						make_slash_commands = true,
					},
				},
			})
		end,
	},
}
