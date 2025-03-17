return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "cat " .. home .. "/.chat",
        api_host_cmd = "echo http://10.204.100.76:11000",
        yank_register = "+",
        edit_with_instructions = {
          diff = false,
          keymaps = {
            close = "<C-c>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            toggle_help = "<C-h>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          welcome_message = WELCOME_MESSAGE,
          loading_text = "Loading, please wait ...",
          question_sign = "",
          answer_sign = "󰚩",
          border_left_sign = "",
          border_right_sign = "",
          max_line_length = 120,
          sessions_window = {
            active_sign = " 󰄵 ",
            inactive_sign = " 󰄱 ",
            current_line_sign = "",
            border = {
              style = "rounded",
              text = {
                top = " Sessions ",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          keymaps = {
            close = "<C-c>",
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-f>",
            next_message = "<C-j>",
            prev_message = "<C-k>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
            draft_message = "<C-r>",
            edit_message = "e",
            delete_message = "d",
            toggle_settings = "<C-o>",
            toggle_sessions = "<C-p>",
            toggle_help = "<C-h>",
            toggle_message_role = "<C-r>",
            toggle_system_role_open = "<C-s>",
            stop_generating = "<C-x>",
          },
        },
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
          right = {
            width = "30%",
            width_settings_open = "50%",
          },
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          buf_options = {
            filetype = "markdown",
          },
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " SYSTEM ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "2",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          prompt = "  ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " Prompt ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20,
        },
        settings_window = {
          setting_sign = "  ",
          border = {
            style = "rounded",
            text = {
              top = " Settings ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        help_window = {
          setting_sign = "  ",
          border = {
            style = "rounded",
            text = {
              top = " Help ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        openai_params = {
          model = "Qwen/Qwen2.5-72B-Instruct",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "Qwen/Qwen2.5-72B-Instruct",
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        use_openai_functions_for_edits = false,
        actions_paths = {},
        show_quickfixes_cmd = "Trouble quickfix",
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
        highlights = {
          help_key = "@symbol",
          help_description = "@comment",
        },
      })
      local opts = { noremap = true, silent = true }

      vim.keymap.set({ "n", "v" }, "<leader>Cc", "<cmd>ChatGPT<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>", opts)
      vim.keymap.set({ "n", "v" }, "<leader>Cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", opts)
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "Exafunction/codeium.vim",
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
    "robitx/gp.nvim",
    config = function()
      local conf = {
        openai_api_key = "EMPTY",
        providers = {
          openai = {
            disable = false,
            endpoint = "http://10.204.100.76:11000/v1/chat/completions",
          },
        },
        cmd_prefix = "Gp",
        agents = {
          {
            provider = "openai",
            name = "Qwen/Qwen2.5-72B-Instruct",
            chat = true,
            command = true,
            model = { model = "Qwen/Qwen2.5-72B-Instruct", temperature = 1.1, top_p = 1},
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            name = "CodeGPT4o",
            disable = true,
          },
          {
            name = "CodeGPT4o-mini",
            disable = true,
          },
        }
      }
      require("gp").setup(conf)
      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = "GPT prompt " .. desc,
        }
      end

      -- Chat commands
      vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
      vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
      vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

      vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
      vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
      vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

      vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
      vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
      vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

      vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
      vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
      vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

      -- Prompt commands
      vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
      vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
      vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

      vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
      vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
      vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
      vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

      vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
      vim.keymap.set({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

      vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
      vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
      vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
      vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
      vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

      vim.keymap.set({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
      vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

      vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
      vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
    end
  }
}
