return {
  "linux-cultist/venv-selector.nvim",
  version = false,
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    parents = 3,
    stay_on_this_version = true,
    name = { "env", "venv", ".env", ".venv" },
  },
  config = function(_, opts)
    require("venv-selector").setup(opts)
  end,
  event = "VeryLazy",
  keys = {
    { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
  },
}
