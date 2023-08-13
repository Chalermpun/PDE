M = {}

local servers = {
	-- pyright = {
	-- 	settings = {
	-- 		python = {
	-- 			analysis = {
	-- 				typeCheckingMode = "off",
	-- 				autoSearchPaths = true,
	-- 				useLibraryCodeForTypes = true,
	-- 				diagnosticMode = "workspace",
	-- 			},
	-- 		},
	-- 	},
	-- },
	jedi_language_server = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = {
					command = "cargo clippy",
					extraArgs = { "--no-deps" },
				},
			},
		},
	},
	html = {},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	marksman = {},
	zk = {},
	-- lua_ls = {
	-- Lua = {
	-- 	workspace = { checkThirdParty = false },
	-- 	telemetry = { enable = false },
	-- },
	-- },
	tsserver = {
		disable_formatting = false,
	},
	dockerls = {},
}

local function lsp_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, bufnr)
		end,
	})
end

local function lsp_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function M.setup(_)
	lsp_attach(function(client, buffer)
		require("core.plugin_config.LSP.format").on_attach(client, buffer)
		require("core.plugin_config.LSP.keymaps").on_attach(client, buffer)
	end)

	require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
	require("mason-lspconfig").setup_handlers({
		function(server)
			local opts = servers[server] or {}
			opts.capabilities = lsp_capabilities()
			require("lspconfig")[server].setup(opts)
		end,
		["rust_analyzer"] = function(server)
			local rt = require("rust-tools")
			local opts = servers[server] or {}
			opts.capabilities = lsp_capabilities()
			rt.setup({ server = opts })
		end,
	})
end

require("illuminate").configure({
	filetypes_denylist = {
		"dirvish",
		"fugitive",
		"aerial",
	},
})

-- change the highlight style
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

--- auto update the highlight style on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	callback = function(ev)
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
	end,
})

vim.cmd([[IlluminatePause]])

return M
