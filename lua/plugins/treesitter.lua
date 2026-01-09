return {
  {
    "nvim-treesitter/nvim-treesitter",
    checkout = 'master',
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          local move = require("nvim-treesitter.textobjects.move")
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name]
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
          vim.keymap.set("n", "<leader>uT", function()
            if vim.b.ts_highlight then
              vim.treesitter.stop()
            else
              vim.treesitter.start()
            end
          end, { desc = "Toggle Treesitter Highlight" })
        end,
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "json5",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "yaml",
        "dockerfile",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]A"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[A"] = "@class.outer" },
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
    config = function(_, opts)
      vim.keymap.set("n", "<leader>Tc", "<cmd>TSContextToggle<CR>", { desc = "Toggle Treesitter Context" })
    end,
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({ use_default_keymaps = false })
      local langs = require("treesj.langs")["presets"]
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "*",
        callback = function()
          if langs[vim.bo.filetype] then
            vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", { buffer = true, desc = "TSJSplit" })
            vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", { buffer = true, desc = "TSJJoin" })
          else
            vim.keymap.set("n", "gS", "<Cmd>SplitjoinSplit<CR>", { buffer = true, desc = "TSJSplit" })
            vim.keymap.set("n", "gJ", "<Cmd>SplitjoinJoin<CR>", { buffer = true, desc = "TSJJoin" })
          end
        end,
      })
    end,
  },
}
