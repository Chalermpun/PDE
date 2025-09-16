return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
          lua = { "stylua" },
          markdown = { "markdownlint" },
          javascript = { "prettier" },
        },
        format_after_save = {
          lsp_fallback = true,
        },
        notify_on_error = true,
      })

      vim.keymap.set("n", "<leader>cf", function()
        conform.format({
          async = true,
          lsp_fallback = true,
        })
      end, { desc = "Format with Conform" })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.mypy,
        },
      })
    end,
  },
}
