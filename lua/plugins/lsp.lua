local function setup_diagnostics()
  local enabled = true
  return function()
    enabled = not enabled
    vim.diagnostic.enable(enabled)
  end
end

function yank_children_with_signature()
  local callback = function(display)
    local node = display.focus_node

    if not node.children or #node.children == 0 then
      vim.notify("No children found in this node", vim.log.levels.WARN)
      return
    end

    local navic = require("nvim-navic.lib")
    local lines = {}

    for _, child in ipairs(node.children) do
      local kind = navic.adapt_lsp_num_to_str(child.kind)
      local line = child.name

      if child.detail and child.detail ~= "" then
        local detail = child.detail:gsub("^%s+", ""):gsub("%s+$", "")
        line = string.format("%s%s", child.name, detail:match("%(.*%)") or "")

        local return_type = detail:match("%->%s*(.+)") or detail:match(":%s*(.+)")
        if return_type then
          line = line .. " -> " .. return_type
        end
      end

      if kind == "Method" or kind == "Function" then
        line = "def " .. line
      elseif kind == "Field" or kind == "Property" then
        line = "    " .. line
      end

      table.insert(lines, line)
    end

    local text = table.concat(lines, "\n")
    vim.fn.setreg("+", text)
    vim.fn.setreg('"', text)

    vim.notify(string.format("Copied %d members with signatures", #lines), vim.log.levels.INFO)

    display:close()
  end

  return {
    callback = callback,
    description = "Copy all children with full signatures",
  }
end

local function setup_monkeyc(lspconfig, configs)
  local function get_connectiq_sdk_root()
    local current_sdk_cfg_path = "~/.Garmin/ConnectIQ/current-sdk.cfg"

    if vim.g.monkeyc_current_sdk_cfg_path then
      current_sdk_cfg_path = vim.g.monkeyc_current_sdk_cfg_path
    elseif vim.loop.os_uname().sysname == "Darwin" then
      current_sdk_cfg_path = "~/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg"
    end

    local cfg = vim.fn.expand(current_sdk_cfg_path)
    if vim.fn.filereadable(cfg) ~= 1 then
      print("current-sdk.cfg not found: " .. cfg)
      return nil
    end

    local sdk_root = vim.fn.readfile(cfg)[1]
    return sdk_root
  end


  local function get_connectiq_home()
    local sdk_root = get_connectiq_sdk_root()
    if not sdk_root then
      return nil
    end
    sdk_root = sdk_root:gsub("/+$", "")
    local home = sdk_root:match("(.*/ConnectIQ)")
    if not home then
      vim.notify("Failed to derive ConnectIQ home from: " .. sdk_root, vim.log.levels.ERROR)
      return nil
    end

    return home .. "/"
  end


  local function get_monkeyc_language_server_path()
    local current_sdk_cfg_path = "~/.Garmin/ConnectIQ/current-sdk.cfg"
    if vim.g.monkeyc_current_sdk_cfg_path then
      current_sdk_cfg_path = vim.g.monkeyc_current_sdk_cfg_path
    elseif vim.loop.os_uname().sysname == "Darwin" then
      current_sdk_cfg_path = "~/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg"
    end

    local workspace_dir = table.concat(vim.fn.readfile(vim.fn.expand(current_sdk_cfg_path)), "\n")
    local jar_path = workspace_dir .. "/bin/LanguageServer.jar"

    if vim.fn.filereadable(jar_path) == 1 then
      return jar_path
    end
    print("Monkey C Language Server not found: " .. jar_path)
    return nil
  end


  local function run_connectiq(callback)
    local sdk_root = get_connectiq_sdk_root()
    if not sdk_root then
      if callback then callback(false) end
      return
    end
    local connectiq = sdk_root .. "/bin/connectiq"
    if vim.fn.executable(connectiq) ~= 1 then
      vim.notify("connectiq not executable: " .. connectiq, vim.log.levels.ERROR)
      if callback then callback(false) end
      return
    end

    vim.system(
      { "pgrep", "-f", "simulator" },
      { text = true },
      function(res)
        vim.schedule(function()
          if res.code == 0 then
            vim.notify("ConnectIQ simulator is already running", vim.log.levels.INFO)
            if callback then callback(true) end
          else
            vim.notify("Starting ConnectIQ simulator...", vim.log.levels.INFO)
            vim.system(
              { connectiq },
              { text = true, detach = true },
              function(start_res)
                vim.schedule(function()
                  if start_res.code ~= 0 then
                    vim.notify("ConnectIQ failed to start\n" .. (start_res.stderr or ""), vim.log.levels.WARN)
                    if callback then callback(false) end
                  else
                    vim.notify("ConnectIQ simulator started", vim.log.levels.INFO)
                    vim.defer_fn(function()
                      if callback then callback(true) end
                    end, 5000) -- wait 5 seconds
                  end
                end)
              end
            )
          end
        end)
      end
    )
  end

  local function run_monkeydo(outputFile, device, settingsFile, settingsTarget, rootPath)
    local sdk_root = get_connectiq_sdk_root()
    if not sdk_root then return end

    local monkeydo = sdk_root .. "/bin/monkeydo"
    if vim.fn.executable(monkeydo) ~= 1 then
      vim.notify("monkeydo not executable", vim.log.levels.ERROR)
      return
    end

    vim.notify("Running app on " .. device .. "...", vim.log.levels.INFO)
    vim.system(
      {
        monkeydo,
        outputFile,
        device,
        "-a", settingsFile .. ":" .. settingsTarget,
      },
      { text = true, cwd = rootPath },
      function(res)
        vim.schedule(function()
          if res.code ~= 0 then
            vim.notify("MonkeyDO failed\n" .. (res.stderr or ""), vim.log.levels.ERROR)
          else
            vim.notify("App is running on " .. device, vim.log.levels.INFO)
          end
        end)
      end
    )
  end

  local function monkeyc_build_and_maybe_run(opts, rootPath, outputFile, settingsFile, settingsTarget, developerKeyPath,
                                             jungleFiles)
    local do_build = opts.build
    local do_run = opts.run
    local sdk_root = get_connectiq_sdk_root()

    if not sdk_root then return end

    local monkeyc = sdk_root .. "/bin/monkeyc"

    if do_build and vim.fn.executable(monkeyc) ~= 1 then
      vim.notify("monkeyc not executable", vim.log.levels.ERROR)
      return
    end

    local devices = {}
    local sdk_home = get_connectiq_home()
    for _, path in ipairs(vim.fn.glob(sdk_home .. "/Devices/*", false, true)) do
      if vim.fn.isdirectory(path) == 1 then
        table.insert(devices, vim.fn.fnamemodify(path, ":t"))
      end
    end

    if #devices == 0 then
      vim.notify("No ConnectIQ devices found", vim.log.levels.ERROR)
      return
    end

    vim.ui.select(devices, { prompt = "Select ConnectIQ Device:" }, function(device)
      if not device then return end

      local function start_simulator_and_run()
        if not do_run then return end

        run_connectiq(function(success)
          if success then
            run_monkeydo(outputFile, device, settingsFile, settingsTarget, rootPath)
          else
            vim.notify("Skipping monkeydo - simulator not ready", vim.log.levels.WARN)
          end
        end)
      end

      if do_build then
        vim.notify("Building for " .. device .. "...", vim.log.levels.INFO)
        vim.system(
          {
            monkeyc,
            "-d", device,
            "-f", jungleFiles,
            "-o", outputFile,
            "-y", developerKeyPath,
          },
          { text = true, cwd = rootPath },
          function(res)
            vim.schedule(function()
              if res.code ~= 0 then
                vim.notify(
                  "MonkeyC build failed\n" .. (res.stderr or ""),
                  vim.log.levels.ERROR
                )
              else
                vim.notify("Build successful for " .. device, vim.log.levels.INFO)
                start_simulator_and_run()
              end
            end)
          end
        )
      else
        start_simulator_and_run()
      end
    end)
  end


  local function make_monkeyc_capabilities()
    local monkeycLspCapabilities = vim.lsp.protocol.make_client_capabilities()
    monkeycLspCapabilities.textDocument.declaration.dynamicRegistration = true
    monkeycLspCapabilities.textDocument.implementation.dynamicRegistration = true
    monkeycLspCapabilities.textDocument.typeDefinition.dynamicRegistration = true
    monkeycLspCapabilities.textDocument.documentHighlight.dynamicRegistration = true
    monkeycLspCapabilities.textDocument.hover.dynamicRegistration = true
    monkeycLspCapabilities.textDocument.signatureHelp.contextSupport = true
    monkeycLspCapabilities.textDocument.signatureHelp.dynamicRegistration = true
    monkeycLspCapabilities.workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true,
      },
    }
    monkeycLspCapabilities.textDocument.foldingRange = {
      lineFoldingOnly = true,
      dynamicRegistration = true,
    }
    return monkeycLspCapabilities
  end

  local monkeyc_ls_jar = get_monkeyc_language_server_path()
  if not monkeyc_ls_jar then
    return
  end

  local jungleFiles = vim.g.monkeyc_jungle_files or "monkey.jungle"
  local root = lspconfig.util.root_pattern("monkey.jungle", "manifest.xml")
  local rootPath = root(vim.fn.getcwd()) or vim.fn.getcwd()
  local devKeyPath = "~/Project/Garmin/garmin_private_key.der"
  local developerKeyPath = vim.fn.expand(devKeyPath)
  local monkeycLspCapabilities = make_monkeyc_capabilities()
  local outputFile = rootPath .. "/app.prg"
  local settingsFile = rootPath .. "/app-settings.json"
  local settingsTarget = "GARMIN/Settings/app-settings.json"

  if not configs.monkeyc_ls then
    if vim.g.monkeyc_connect_iq_dev_key_path then
      developerKeyPath = vim.fn.expand(vim.g.monkeyc_connect_iq_dev_key_path)
    end
    configs.monkeyc_ls = {
      default_config = {
        cmd = {
          "java",
          "-Dapple.awt.UIElement=true",
          "-classpath",
          monkeyc_ls_jar,
          "com.garmin.monkeybrains.languageserver.LSLauncher",
        },
        filetypes = { "monkey-c", "monkeyc", "jungle", "mss", "m4" },
        root_dir = root,
        settings = {
          {
            developerKeyPath = developerKeyPath,
            compilerWarnings = true,
            compilerOptions = vim.g.monkeyc_compiler_options or "",
            developerId = "",
            jungleFiles = jungleFiles,
            javaPath = "",
            typeCheckLevel = "Default",
            optimizationLevel = "Default",
            testDevices = {
              vim.g.monkeyc_default_device or "enduro3", -- I should be getting this dynamically from the manifest file
            },
            debugLogLevel = "Default",
          },
        },
        capabilities = monkeycLspCapabilities,
        init_options = {
          publishWarnings = vim.g.monkeyc_publish_warnings or true,
          compilerOptions = vim.g.monkeyc_compiler_options or "",
          typeCheckMsgDisplayed = false,
          workspaceSettings = {
            {
              path = rootPath,
              jungleFiles = {
                rootPath .. "/monkey.jungle",
              },
            },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.completionProvider = {
            triggerCharacters = {
              ".",
              ":",
            },
            resolveProvider = false,
            documentSelector = {
              {
                pattern = "**/*.{mc,mcgen}",
              },
            },
          }
          local methods = vim.lsp.protocol.Methods
          local req = client.request

          client.request = function(method, params, handler, bufnr_req)
            if method == methods.textDocument_definition then
              return req(method, params, function(err, result, context, config)
                local function fix_uri(uri)
                  if uri:match("^file:/[^/]") then
                    uri = uri:gsub("^file:/", "file:///") -- Fix missing slashes
                  end
                  return uri
                end

                if vim.islist(result) then
                  for _, res in ipairs(result) do
                    if res.uri then
                      res.uri = fix_uri(res.uri)
                    end
                  end
                elseif result.uri then
                  result.uri = fix_uri(result.uri)
                end

                return handler(err, result, context, config)
              end, bufnr_req)
            elseif method == methods.textDocument_signatureHelp then
              params.context = {
                triggerKind = 1,
              }
              return req(method, params, handler, bufnr_req)
            else
              return req(method, params, handler, bufnr_req)
            end
          end
        end,
      },
    }
  end

  lspconfig.monkeyc_ls.setup({})

  vim.api.nvim_create_user_command("MonkeyC", function(opts)
    local args = vim.split(opts.args, "%s+")
    local flags = {
      build = false,
      run = false,
    }

    for _, a in ipairs(args) do
      if a == "build" or a == "b" then
        flags.build = true
      elseif a == "run" or a == "r" then
        flags.run = true
      elseif a == "connectiq" or a == "c" then
        run_connectiq(function(success)
          if success then
            vim.notify("ConnectIQ simulator ready", vim.log.levels.INFO)
          else
            vim.notify("Failed to start ConnectIQ simulator", vim.log.levels.ERROR)
          end
        end)
        return
      end
    end

    if not flags.build and not flags.run then
      flags.build = true
      flags.run = true
    end

    monkeyc_build_and_maybe_run(flags, rootPath, outputFile, settingsFile, settingsTarget, developerKeyPath, jungleFiles)
  end, {
    nargs = "*",
    complete = function()
      return { "build", "run", "connectiq", "b", "r", "c" }
    end,
  })
end



local function setup_navbuddy()
  local navbuddy = require("nvim-navbuddy")
  local actions = require("nvim-navbuddy.actions")

  navbuddy.setup({
    window = {
      border = "single",
      size = "60%",
      position = "50%",
      sections = {
        left = { size = "20%" },
        mid = { size = "40%" },
        right = { preview = "leaf" },
      },
    },
    node_markers = {
      enabled = true,
      icons = { leaf = "  ", leaf_selected = " → ", branch = " " },
    },
    icons = require("config.util").defaults.icons.kinds,
    use_default_mappings = true,
    mappings = {
      ["<esc>"] = actions.close(),
      ["q"] = actions.close(),
      ["j"] = actions.next_sibling(),
      ["k"] = actions.previous_sibling(),
      ["h"] = actions.parent(),
      ["l"] = actions.children(),
      ["0"] = actions.root(),
      ["v"] = actions.visual_name(),
      ["V"] = actions.visual_scope(),
      ["y"] = actions.yank_name(),
      ["Y"] = actions.yank_scope(),
      ["i"] = actions.insert_name(),
      ["I"] = actions.insert_scope(),
      ["a"] = actions.append_name(),
      ["A"] = actions.append_scope(),
      ["r"] = actions.rename(),
      ["d"] = actions.delete(),
      ["f"] = actions.fold_create(),
      ["F"] = actions.fold_delete(),
      ["c"] = actions.comment(),
      ["<enter>"] = actions.select(),
      ["o"] = actions.select(),
      ["J"] = actions.move_down(),
      ["K"] = actions.move_up(),
      ["s"] = actions.toggle_preview(),
      ["<C-v>"] = actions.vsplit(),
      ["<C-s>"] = actions.hsplit(),
      ["C"] = yank_children_with_signature(),
      ["t"] = actions.telescope({
        layout_config = {
          height = 0.60,
          width = 0.60,
          prompt_position = "top",
          preview_width = 0.50,
        },
        layout_strategy = "horizontal",
      }),
      ["g?"] = actions.help(),
    },
    lsp = { auto_attach = false },
    source_buffer = {
      follow_node = true,
      highlight = true,
      reorient = "smart",
    },
  })
end


local function setup_keymaps(diagnostics_toggle)
  local keymap = vim.keymap.set
  local telescope = require("telescope.builtin")

  keymap("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
  keymap("n", "<leader>Lr", "<cmd>LspStart<cr>", { desc = "Lsp Start" })
  keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  keymap("n", "<leader>ud", diagnostics_toggle, { desc = "Toggle Diagnostics" })
  keymap("n", "gd", function()
    telescope.lsp_definitions({ reuse_win = true })
  end, { desc = "Goto Definition" })
  keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
  keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  keymap("n", "gI", function()
    telescope.lsp_implementations({ reuse_win = true })
  end, { desc = "Goto Implementation" })
  keymap("n", "gy", function()
    telescope.lsp_type_definitions({ reuse_win = true })
  end, { desc = "Goto T[y]pe Definition" })
  keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  keymap("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  keymap("n", "<leader>cA", function()
    vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
  end, { desc = "Source Action" })
  keymap("n", "<leader>nd", function()
    require("nvim-navbuddy").open()
  end, { desc = "NavBuddy" })
end

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "markdownlint",
        "ruff",
        "mypy",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "yamlls", "jsonls", "pyright", "marksman" },
      })
    end,
  },
  { "klimeryk/vim-monkey-c" },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "b0o/schemastore.nvim",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim", { "numToStr/Comment.nvim" } },
        opts = {
          lsp = { auto_attach = true },
          format = {
            formatting_options = nil,
            timeout_ms = 10000,
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      setup_monkeyc(lspconfig, configs)

      lspconfig.pyright.setup({})
      lspconfig.marksman.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })
      require("lspconfig").jsonls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas({
              ignore = {
                ".eslintrc",
                "package.json",
              },
            }),
            validate = { enable = true },
          },
        },
      })
      setup_navbuddy()
      setup_keymaps(setup_diagnostics())
      local signs = require("config.util").defaults.icons.diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          enable = true,
          text = {
            ["ERROR"] = signs.Error,
            ["WARN"] = signs.Warn,
            ["HINT"] = signs.Hint,
            ["INFO"] = signs.Info,
          },
          texthl = {
            ["ERROR"] = "DiagnosticDefault",
            ["WARN"] = "DiagnosticDefault",
            ["HINT"] = "DiagnosticDefault",
            ["INFO"] = "DiagnosticDefault",
          },
          numhl = {
            ["ERROR"] = "DiagnosticDefault",
            ["WARN"] = "DiagnosticDefault",
            ["HINT"] = "DiagnosticDefault",
            ["INFO"] = "DiagnosticDefault",
          },
          severity_sort = true,
        },
      })

      if vim.lsp.inlay_hint then
        vim.keymap.set("n", "<leader>uh", function()
          vim.lsp.inlay_hint(0, nil)
        end, { desc = "Toggle Inlay Hints" })
      end
    end,
  },
  {
    "rmagatti/goto-preview",
    event = "VeryLazy",
    config = function()
      require("goto-preview").setup({})
      vim.keymap.set(
        "n",
        "gpd",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { desc = "Goto Preview" }
      )
      vim.keymap.set(
        "n",
        "gpt",
        " <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
        { desc = "Goto Preview Type Definition" }
      )
      vim.keymap.set(
        "n",
        "gpi",
        " <cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        { desc = "Goto Preview Implementation" }
      )
      vim.keymap.set(
        "n",
        "gpD",
        " <cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
        { desc = "Goto Preview Declaration" }
      )
      vim.keymap.set(
        "n",
        "gP",
        " <cmd>lua require('goto-preview').close_all_win()<CR>",
        { desc = "Goto Preview Close All" }
      )
      vim.keymap.set(
        "n",
        "gpr",
        " <cmd>lua require('goto-preview').goto_preview_references()<CR>",
        { desc = "Goto Preview References" }
      )
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
    vim.keymap.set("n", "<leader>cr", ":IncRename "),
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup()
      vim.keymap.set("n", "<leader>Bt", "<cmd>Barbecue toggle<cr>", { desc = "Barbecue Toggle" })
    end,
  },
}
