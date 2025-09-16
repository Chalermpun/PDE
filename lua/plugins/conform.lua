return {
  'stevearc/conform.nvim',
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { 'ruff_organize_imports', 'ruff_format' },
      },
      format_after_save = {
        lsp_fallback = true,
      },
      notify_on_error = true,
    })
  end
}
