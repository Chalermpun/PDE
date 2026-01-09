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

      local function find_cargo_root()
        local current_file = vim.fn.expand("%:p:h")
        local cargo_root = vim.fn.findfile("Cargo.toml", current_file .. ";")
        if cargo_root ~= "" then
          return vim.fn.fnamemodify(cargo_root, ":h")
        end
        return vim.fn.getcwd()
      end

      -- Setup DAP UI
      dapui.setup(opts)

      -- DAP UI listeners
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      -- ========== Python Setup ==========
      local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy"
      if vim.fn.isdirectory(debugpy_path) == 1 then
        local python_path = debugpy_path .. "/venv/bin/python"
        if vim.fn.has("win32") == 1 then
          python_path = debugpy_path .. "/venv/Scripts/python.exe"
        end
        require("dap-python").setup(python_path)
      else
        vim.notify("debugpy not installed. Run :MasonInstall debugpy", vim.log.levels.WARN)
      end

      -- ========== Rust/C/C++ Setup (CodeLLDB) ==========
      local codelldb_path
      if vim.fn.has("win32") == 1 then
        codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe"
      else
        codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
      end

      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        }
      }

      -- Rust configurations
      dap.configurations.rust = {
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            local cargo_root = find_cargo_root()
            return vim.fn.input(
              "Path to executable: ",
              cargo_root .. "/target/debug/",
              "file"
            )
          end,
          cwd = function()
            return find_cargo_root()
          end,
          stopOnEntry = false,
        },
        {
          name = "Launch (auto-detect binary)",
          type = "codelldb",
          request = "launch",
          program = function()
            local cargo_root = find_cargo_root()

            -- พยายามหา binary จาก cargo metadata
            local handle = io.popen("cd " ..
              vim.fn.shellescape(cargo_root) .. " && cargo metadata --format-version 1 --no-deps 2>/dev/null")
            if handle then
              local result = handle:read("*a")
              handle:close()

              local ok, metadata = pcall(vim.fn.json_decode, result)
              if ok and metadata and metadata.packages and #metadata.packages > 0 then
                local package_name = metadata.packages[1].name:gsub("-", "_")
                local binary_path = cargo_root .. "/target/debug/" .. package_name

                -- ตรวจสอบว่าไฟล์มีจริง
                if vim.fn.filereadable(binary_path) == 1 then
                  vim.notify("Found binary: " .. binary_path, vim.log.levels.INFO)
                  return binary_path
                end
              end
            end

            -- ถ้าหาไม่เจอ ให้ user เลือกเอง
            vim.notify("Could not auto-detect binary. Please select manually.", vim.log.levels.WARN)
            return vim.fn.input(
              "Path to executable: ",
              cargo_root .. "/target/debug/",
              "file"
            )
          end,
          cwd = function()
            return find_cargo_root()
          end,
          stopOnEntry = false,
        },
        {
          name = "Launch (select from target/debug/)",
          type = "codelldb",
          request = "launch",
          program = function()
            local cargo_root = find_cargo_root()
            local target_debug = cargo_root .. "/target/debug/"

            -- ตรวจสอบว่า directory มีอยู่จริง
            if vim.fn.isdirectory(target_debug) == 0 then
              vim.notify("Directory not found: " .. target_debug .. "\nRun 'cargo build' first.", vim.log.levels.ERROR)
              return vim.fn.input("Path to executable: ", cargo_root .. "/target/debug/", "file")
            end

            -- หา executables ทั้งหมดใน target/debug
            local executables = {}
            local handle = io.popen("find " ..
              vim.fn.shellescape(target_debug) .. " -maxdepth 1 -type f -perm +111 2>/dev/null")
            if handle then
              for file in handle:lines() do
                local basename = vim.fn.fnamemodify(file, ":t")
                -- กรองไฟล์ที่มี extension, deps, หรือเป็น build script
                if not basename:match("%.")
                    and not basename:match("^%.")
                    and not file:match("/deps/")
                    and not basename:match("^build%-script") then
                  table.insert(executables, file)
                end
              end
              handle:close()
            end

            if #executables == 0 then
              vim.notify("No executables found in " .. target_debug .. "\nRun 'cargo build' first.", vim.log.levels.WARN)
              return vim.fn.input("Path to executable: ", target_debug, "file")
            elseif #executables == 1 then
              vim.notify("Using: " .. executables[1], vim.log.levels.INFO)
              return executables[1]
            else
              -- ให้เลือกจาก list โดยใช้ vim.ui.select
              local selected = nil
              vim.ui.select(executables, {
                prompt = "Select executable to debug:",
                format_item = function(item)
                  return vim.fn.fnamemodify(item, ":t")
                end,
              }, function(choice)
                selected = choice
              end)
              return selected or executables[1]
            end
          end,
          cwd = function()
            return find_cargo_root()
          end,
          stopOnEntry = false,
        },
      }

      -- C/C++ configurations (optional - ใช้ร่วมกับ Rust)
      dap.configurations.c = dap.configurations.rust
      dap.configurations.cpp = dap.configurations.rust
    end
  },
}
