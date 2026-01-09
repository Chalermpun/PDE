return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {

      "mfussenegger/nvim-dap-python",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = { "debugpy" },
        },
      },
    },
    keys = {
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to line (no execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },

    config = function()
      local Config = require("config.util")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.defaults.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
  {
    "puremourning/vimspector",
    ft = "rust",
    keys = {
      {
        "<leader>dv",
        "<cmd>call vimspector#Launch()<cr>",
        desc = "Vimspector Launch (Rust)",
        ft = "rust",
      },
      {
        "<leader>dt",
        "<cmd>call vimspector#Reset()<cr>",
        desc = "Vimspector Reset (Rust)",
        ft = "rust",
      },

      -- Breakpoints
      {
        "<leader>db",
        "<cmd>call vimspector#ToggleBreakpoint()<cr>",
        desc = "Toggle Breakpoint (Rust)",
        ft = "rust",
      },

      -- Stepping
      {
        "<leader>dO",
        "<cmd>call vimspector#StepOver()<cr>",
        desc = "Step Over (Rust)",
        ft = "rust",
      },
      {
        "<leader>di",
        "<cmd>call vimspector#StepInto()<cr>",
        desc = "Step Into (Rust)",
        ft = "rust",
      },
      {
        "<leader>do",
        "<cmd>call vimspector#StepOut()<cr>",
        desc = "Step Out (Rust)",
        ft = "rust",
      },

      -- Continue / Stop
      {
        "<leader>dc",
        "<cmd>call vimspector#Continue()<cr>",
        desc = "Continue (Rust)",
        ft = "rust",
      },
      {
        "<leader>dq",
        "<cmd>call vimspector#Stop()<cr>",
        desc = "Stop (Rust)",
        ft = "rust",
      },

      -- Watch / Eval
      {
        "<leader>dw",
        "<cmd>call vimspector#AddWatch()<cr>",
        desc = "Add Watch (Rust)",
        ft = "rust",
      },
      {
        "<leader>de",
        "<cmd>call vimspector#Evaluate()<cr>",
        desc = "Evaluate (Rust)",
        mode = { "n", "v" },
        ft = "rust",
      },
    },

    config = function()
      vim.g.vimspector_enable_mappings = "HUMAN"
      vim.g.vimspector_install_gadgets = {
        "CodeLLDB",
      }
    end,
  }
}
