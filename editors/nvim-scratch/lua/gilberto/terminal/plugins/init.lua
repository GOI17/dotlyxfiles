local map = function(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

local nmap = function(l, r, opts)
  map('n', l, r, opts)
end

local imap = function(l, r, opts)
  map('i', l, r, opts)
end

local vmap = function(l, r, opts)
  map('v', l, r, opts)
end

local shared_deps = {
  { 'MunifTanjim/nui.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'make',
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },
}

local ui_deps = {
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end
  },
  {
    'nvimdev/dashboard-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      theme = "doom",
      config = {
        header = require('gilberto.plugins.dashboard-nvim'),
        disable_move = true,
      }
    },
  },
  {
    'dstein64/vim-startuptime',
  },
  {
    'stevearc/oil.nvim',
    opts = {}
  },
  {
    "numToStr/Navigator.nvim",
    opts = {}
  },
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim"
    },
  },
  {
    'tris203/precognition.nvim',
    opts = {}
  },
  {
    'folke/noice.nvim',
    opts = {},
    dependencies = {
      {
        'rcarriga/nvim-notify',
        opts = {
          render = 'simple',
          stages = 'static',
          top_down = true,
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            local bufType = vim.api.nvim_buf_get_option(buf, 'filetype')
            vim.api.nvim_buf_set_option(buf, 'filetype', bufType)
          end
        },
        config = function()
          vim.notify = require('notify')
        end
      },
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      scope = {
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        }
      },
      exclude = {
        filetypes = {
          'lspinfo',
          'packer',
          'checkhealth',
          'help',
          'man',
          'dashboard'
        }
      },
    },
    config = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  },
  { 'szw/vim-maximizer' },
  {
    'echasnovski/mini.bufremove',
    opts = {}
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      'nvim-telescope/telescope-ui-select.nvim',
      "nvim-lua/plenary.nvim",
      'andrew-george/telescope-themes',
      'folke/noice.nvim',
      'stevearc/aerial.nvim',
      'gbprod/yanky.nvim'
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        themes = {}
      },
    },
    config = function()
      local telescope = require('telescope');
      telescope.load_extension('notify')
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension('themes')
      telescope.load_extension('noice')
      telescope.load_extension('aerial')
      telescope.load_extension("yank_history")
    end
  },
  {
    'folke/flash.nvim',
    config = function()
      local flash = require('flash')
      map({ "n", "x", "o" }, 's', flash.jump, { desc = 'Flash' })
      map({ "n", "x", "o" }, 'S', flash.treesitter, { desc = 'Flash treesitter' })
      map({ "o" }, 'r', flash.remote, { desc = 'Flash remote' })
      map({ "x" }, 'R', flash.treesitter_search, { desc = 'Flash treesitter_search' })
      map({ "c" }, '<c-s>', flash.toggle, { desc = 'Flash toggle' })
    end
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure()
    end
  },
  {
    'mvllow/modes.nvim',
    opts = {}
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      options = {
        theme = "tokyonight",
        sections = {
          lualine_x = { "searchcount" },
          lualine_z = { "os.date('%a')" }
        },
      },
    }
  },
  {
    'romgrk/barbar.nvim',
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function()
        local gs = require('gitsigns')

        nmap("<leader>g]h", gs.next_hunk, { desc = ':Gitsigns next_hunk' })
        nmap("<leader>g[h", gs.prev_hunk, { desc = ':Gitsigns prev_hunk' })
        nmap("<leader>ghS", gs.stage_buffer, { desc = ":Gitsigns stage_buffer" })
        nmap("<leader>ghu", gs.undo_stage_hunk, { desc = ":Gitsigns undo_stage_hunk" })
        nmap("<leader>ghR", gs.reset_buffer, { desc = ":Gitsigns reset_buffer" })
        nmap("<leader>ghp", gs.preview_hunk_inline, { desc = ":Gitsigns preview_hunk_inline" })
        nmap("<leader>ghb", function()
            gs.blame_line({ full = true })
          end,
          { desc = ":Gitsigns blame_line" })
        nmap("<leader>ghd", gs.diffthis, { desc = ":Gitsigns diffthis (open file)" })
        nmap("<leader>ghD",
          function()
            gs.diffthis("~")
          end,
          { desc = ":Gitsigns diffthis (cwd)" })
      end
    }
  },
  {
    'folke/which-key.nvim',
    opts = {
      plugins = { spelling = true },
      triggers_blacklist = {
        n = { "d", "y" }
      }
    },
    config = function()
      local wk = require("which-key")

      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end

      wk.register({
        {
          mode = { "n" },
          ["<leader>pv"] = {
            ":Oil<cr>",
            "Show file explorer"
          },
          ["<leader>g"] = {
            "+git"
          },
          ["<leader>gg"] = {
            ":LazyGit<cr>",
            "LazyGit (Root dir)"
          },
          ["<leader>gG"] = {
            ":LazyGit<cr>",
            "LazyGitCurrentFile (cwd)"
          },
          ["<leader>gc"] = {
            ":LazyGitFilter<cr>",
            "LazyGitCommits"
          },
          ["<C-h>"] = {
            ":NavigatorLeft<cr>",
            "Go to Left window"
          },
          ["<C-j>"] = {
            ":NavigatorDown<cr>",
            "Go to Lower window"
          },
          ["<C-k>"] = {
            ":NavigatorUp<cr>",
            "Go to Upper window"
          },
          ["<C-l>"] = {
            ":NavigatorRight<cr>",
            "Go to Right window"
          },
          ["H"] = {
            ":bprevious<cr>",
            "Prev buffer",
          },
          ["L"] = {
            ":bnext<cr>",
            "Next buffer",
          },
          ["Ó"] = {
            ":vertical resize +2<cr>",
            "Decrease window width"
          },
          ["Ô"] = {
            ":resize -2<cr>",
            "Decrease window height"
          },
          [""] = {
            ":resize +2<cr>",
            "Increase window height"
          },
          ["Ò"] = {
            ":vertical resize -2<cr>",
            "Increase window with"
          },
          ["∆"] = {
            ":m .+1<cr>==",
            "Move lines down"
          },
          ["˚"] = {
            ":m .-2<cr>==",
            "Move lines up"
          },
          ["<leader>s"] = {
            "+save",
          },
          ["<leader>ss"] = {
            ":w<cr>",
            "Save file",
          },
          ["<leader>sa"] = {
            ":noa w<cr>",
            "Save file without actions",
          },
          ["<leader>sS"] = {
            ":wa<cr>",
            "Save all files",
          },
          ["<leader>sA"] = {
            ":noa wa<cr>",
            "Save all files without actions",
          },
          ["<leader>K"] = {
            ":norm! K<cr>",
            "Keywordprg"
          },
          ["<leader>f"] = {
            "+files",
          },
          ["<leader>ff"] = {
            ":Telescope find_files<cr>",
            "Find files",
          },
          ["<leader>fs"] = {
            ":Telescope live_grep<cr>",
            "Find term",
          },
          ["<leader>fc"] = {
            ":Telescope grep_string<cr>",
            "Find hover term",
          },
          ["<leader>fn"] = {
            ":enew<cr>",
            "New file"
          },
          ["<leader>c"] = {
            "+code",
          },
          ["<leader>cf"] = {
            function()
              require("conform").format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 1000,
              })
            end,
            "Format file or range selection"
          },
          ["<leader>cd"] = {
            vim.diagnostic.open_float,
            "Line diagnostics"
          },
          ["<leader>cdf"] = {
            ":Telescope diagnostics bufnr=0<CR>",
            "File diagnostics"
          },
          ["<leader>ct"] = {
            ":TodoTelescope<cr>",
            "Find todos"
          },
          ["<leader>cl"] = {
            function()
              require("lint").try_lint()
            end,
            "Lint current file"
          },
          ["<leader>cgd"] = {
            ":Telescope lsp_definitions<CR>",
            "Show LSP definitions"
          },
          ["<leader>cgi"] = {
            ":Telescope lsp_implementations<CR>",
            "Show LSP implementations"
          },
          ["<leader>cgt"] = {
            ":Telescope lsp_type_definitions<CR>",
            "Show LSP type definitions"
          },
          ["<leader>cgr"] = {
            ":Telescope lsp_references<CR>",
            "Show LSP type definitions"
          },
          ["<leader>ca"] = {
            vim.lsp.buf.code_action,
            "See available code actions"
          },
          ["<leader>cr"] = {
            vim.lsp.buf.rename,
            "Smart rename",
          },
          ["<leader>ck"] = {
            vim.lsp.buf.hover,
            "Show documentation for what is under cursor"
          },
          ["<leader>clr"] = {
            ":LspRestart<CR>",
            "Restart LSP"
          },
          ["]d"] = {
            diagnostic_goto(true),
            "Next Diagnostic"
          },
          ["[d"] = {
            diagnostic_goto(false),
            "Prev Diagnostic"
          },
          ["]e"] = {
            diagnostic_goto(true, "ERROR"),
            "Next Error"
          },
          ["[e"] = {
            diagnostic_goto(false, "ERROR"),
            "Prev Error"
          },
          ["]w"] = {
            diagnostic_goto(true, "WARN"),
            "Next Warning"
          },
          ["[w"] = {
            diagnostic_goto(false, "WARN"),
            "Prev Warning"
          },
        },
        {
          mode = { "i" },
          ["∆"] = {
            "<esc>:m .+1<cr>==gi",
            "Move lines down"
          },
          ["˚"] = {
            "<esc>:m .-2<cr>==gi",
            "Move lines up"
          },
        },
        {
          mode = { "i", "n" },
          ["<esc>"] = {
            ":noh<cr><esc>",
            "Escape and Clear hlsearch"
          }
        },
        {
          mode = { "i", "v" },
          ["qw"] = {
            "<esc>",
            "Back to normal mode"
          }
        },
        {
          mode = { "v" },
          ["∆"] = {
            ":m '>+1<cr>gv=gv",
            "Move lines down"
          },
          ["˚"] = {
            ":m '<-2<cr>gv=gv",
            "Move lines up"
          },
        },
        ["<leader>b"] = {
          "+buffers"
        },
        ["<leader>bsr"] = {
          ":FineCmdline %s/<cr>",
          "Search and Replace open buffer"
        },
        ["<leader>bb"] = {
          ":Telescope buffers<cr>",
          "Switch to other buffer",
        },
        ["<leader>bc"] = {
          ":Telescope colorscheme<cr>",
          "Colorschemes",
        },
        ["<leader>bd"] = {
          ":BufferClose<cr>",
          "Delete buffer"
        },
        ["<leader>p"] = {
          "+panes",
        },
        ["<leader>p["] = {
          ":split<cr>",
          "Horizontal split"
        },
        ["<leader>p]"] = {
          ":vsplit<cr>",
          "Vertical split"
        },
        ["<leader>pc"] = {
          ":close<cr>",
          "Close split"
        },
        ["<leader>pm"] = {
          ":MaximizerToggle<cr>",
          "Max/Min pane"
        },
        {
          mode = { "n", "v" },
          ["<leader>ghs"] = {
            ":Gitsigns stage_hunk<CR>",
            "Stage Hunk",
          },
          ["<leader>ghr"] = {
            ":Gitsigns reset_hunk<CR>",
            "Reset Hunk",
          },
        },
        {
          mode = { "o", "x" },
          ["ih"] = {
            ":<C-U>Gitsigns select_hunk<CR>",
            "GitSigns Select Hunk"
          },
        },
      })
    end
  },
  {
    "prichrd/netrw.nvim",
    opts = {
      use_devicons = true
    }
  }
}

local lsp_deps = {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'marilari88/twoslash-queries.nvim',
      'williamboman/nvim-lsp-installer',
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspinsntaller = require('nvim-lsp-installer')

      lspinsntaller.setup({
        automatic_installation = true
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client, _)
          require("twoslash-queries").attach(client, _)
          client.server_capabilities.document_formatting = false
        end,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            }
          },
        },
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      {
        "KadoBOT/cmp-plugins",
        opts = {}
      },
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local defaults = require("cmp.config.default")()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path' }
          },
          {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          }
        )
      })

      cmp.setup({
        auto_brackets = {},
        completion = {
          completeopt = "menu,menuone,noinsert,preview,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = 'plugins' },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] =
              cmp.mapping.select_prev_item(),
          ["<C-b>"] =
              cmp.mapping.scroll_docs(-4),
          ["<C-f>"] =
              cmp.mapping.scroll_docs(4),
          ["<C-Space>"] =
              cmp.mapping.complete(),
          ["<C-e>"] =
              cmp.mapping.abort(),
          ["<CR>"] =
              cmp.mapping.confirm({ select = false }),
          ["<S-CR>"] =
              cmp.mapping.confirm({
                select = true,
              }),
          ["<C-CR>"] =
              function(fallback)
                cmp.abort()
                fallback()
              end,
        }),
      })
    end
  },
}

local coding_deps = {
  { "stevearc/conform.nvim" },
  {
    'echasnovski/mini.pairs',
    opts = {}
  },
  {
    'echasnovski/mini.surround',
    opts = {}
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {}
  },
  {
    'echasnovski/mini.comment',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    opts = {
      custom_commentstring = function()
        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
      end
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      ensure_installed = { "javascript", "typescript", "lua", "tsx" },
      modules = {},
      sync_install = true,
      ignore_install = {},
      auto_install = true,
    }
  },
  { "mfussenegger/nvim-lint" },
  { 'folke/trouble.nvim' },
  { 'folke/todo-comments.nvim' },
  { "VidocqH/lsp-lens.nvim" },
  { "ray-x/lsp_signature.nvim" },
  { "editorconfig/editorconfig-vim" },
  { "Tastyep/structlog.nvim" },
  { 'folke/neodev.nvim',                  opts = {} },
  { 'jose-elias-alvarez/typescript.nvim', opts = {} },
  { 'dmmulroy/ts-error-translator.nvim',  opts = {} },
  { "marilari88/twoslash-queries.nvim",   opts = {} },
  { 'tpope/vim-fugitive' },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        opts = {
          -- Set icons to characters that are more likely to work in every terminal.
          --    Feel free to remove or use ones that you like more! :)
          --    Don't feel like these are good choices.
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
        }
      },
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {},
        }
      },
    },
    config = function()
      local dap = require('dap')

      -- Basic debugging keymaps, feel free to change to your liking!
      nmap('<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      nmap('<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      nmap('<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      nmap('<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      nmap('<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      nmap('<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      local dapui = require('dapui')
      nmap('<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {
      highlighter = {
        lsp = true,
        auto_enable = true
      }
    }
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = 'prefer_left'
      }
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  { "OrangeT/vim-csharp" }
}

return {
  shared_deps,
  ui_deps,
  lsp_deps,
  coding_deps,
  -- UNCATEGORIZED SETUP
  { "LunarVim/bigfile.nvim" }, -- Disable plugins only for files bigger enough to increase startuptime
  {
    "gbprod/yanky.nvim",
    opts = {}
  },
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
    },
    config = function()
      nmap('K', vim.lsp.buf.hover, { desc = 'Testing hover docs' } )
      require("mason").setup() -- Mason setup must run before csharp
      require("csharp").setup()
    end
  }
}
