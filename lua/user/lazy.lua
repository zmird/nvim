local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local opts = {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
    version = nil,
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  -- leave nil when passing the spec as the first argument to setup()
  spec = nil, ---@type LazySpec
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This is should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/Workspace/nvim/plugins",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "github-nvim-theme" },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",
    icons = {
      cmd = icons.terminal,
      config = icons.cog,
      event = icons.lightning,
      ft = icons.fileNoLines .. " ",
      init = icons.cog .. " ",
      import = icons.fileImport .. " ",
      keys = icons.keys .. " ",
      lazy = icons.sleep .. " ",
      loaded = icons.dot,
      not_loaded = icons.dotOutline,
      plugin = icons.box .. " ",
      runtime = icons.vim .. "",
      source = icons.snippet2 .. " ",
      start = icons.play,
      task = icons.check2,
      list = {
        icons.dotBig,
        icons.arrowRight2,
        icons.star,
        icons.minusSmall,
      },
    },
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      -- open a terminal for the plugin dir
      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { "UIEnter", "BufReadPre" },
      ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
}

local plugins = {
  -- Utils
  {
    "nvim-lua/popup.nvim",
    lazy = false,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "nathom/filetype.nvim",
    lazy = true,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function ()
      pcall(vim.cmd, ":TSUpdate")
    end,
    config = function ()
      require "user.plugins.treesitter"
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    priority = 1000,
    dependencies = {
      {
        "williamboman/mason.nvim",
        dependencies = {
          "williamboman/mason-lspconfig.nvim"
        }
      },
      {
        "simrat39/symbols-outline.nvim",
        config = function ()
          require "user.plugins.symbols"
        end,
      },
      {
        "folke/lsp-trouble.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        }
      },
      "jose-elias-alvarez/null-ls.nvim",
      "j-hui/fidget.nvim",
    },
    config = function ()
      require "user.plugins.lsp"
    end
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function ()
      require("user.plugins.cmp")
    end
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    }
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function ()
      require "user.plugins.telescope"
    end,
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
    },
  },

  -- Code
  {
    "nacro90/numb.nvim",
    keys = ":",
    config = function ()
      require "user.plugins.numb"
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function ()
      require "user.plugins.comment"
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function ()
      require "user.plugins.indent"
    end
  },
  {
    "windwp/nvim-autopairs",
    event = {
      "InsertEnter",
    },
    dependencies = {
      "nvim-treesitter",
      "nvim-cmp"
    },
    config = function ()
      require("nvim-autopairs").setup{}
    end
  },
  {
    'kevinhwang91/nvim-ufo',
    keys = {
      "zc",
      "za",
      "zC",
      "zA",
      "zR",
      "zM"
    },
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function ()
      require "user.plugins.ufo"
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = {
      "BufRead",
    },
    config = function ()
      require "user.plugins.gitsigns"
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup{}
    end
  },

  -- UI
  {"nvim-tree/nvim-web-devicons"},
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function ()
      require "user.plugins.catppuccin"
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function ()
      require "user.plugins.tokyonight"
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = {
      "NeoTreeFocusToggle",
      "NeoTreeShowToggle",
    },
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require "user.plugins.neotree"
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function ()
      require "user.plugins.noice"
    end
  },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false
  },
  -- {"akinsho/toggleterm.nvim"},
  -- {"stevearc/dressing.nvim"},

  -- Others
  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    config = function ()
      require("obsidian").setup {
        dir = "~/Notes",
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
        note_id_func = function(givenTitle)
          local noteTitle
          if givenTitle ~= nil then
            -- If title is given, transform it into valid file name.
            noteTitle = givenTitle:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              noteTitle = tostring(os.time()) .. "-" .. string.char(math.random(65, 90))
            end
          end
          return noteTitle
        end
      }
    end
  },
}


require("lazy").setup(plugins, opts)
