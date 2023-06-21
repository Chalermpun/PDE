-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "nord",
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_y = {
      "progress",
      require("nomodoro").status,
    },
  },
})
