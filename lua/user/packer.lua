local packer_status_ok, packer = pcall(require, "packer")

-- Automatically install packer
if not packer_status_ok then
  print "Cloning packer.."

  local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

  vim.fn.delete(packer_path, "rf") -- remove the dir before cloning
  packer_bootstrap = vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "1",
    packer_path,
  }

  vim.cmd "packadd packer.nvim"

  packer_status_ok, packer = pcall(require, "packer")

  if packer_status_ok then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    return
  end
else
  vim.cmd "packadd packer.nvim"
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  git = {
    clone_timeout = 6000, -- seconds
  },
  auto_clean = true,
  compile_on_sync = true,
  -- compile_path = compile_path
}

packer.startup(function(use)
  -- Packer can manage itself
  use { "wbthomason/packer.nvim" }

  -- Needed to load first
  use {
    -- { "lewis6991/impatient.nvim",
    --   rocks = "mpack" },
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nathom/filetype.nvim",
    "zmird/nvim-web-devicons",
  }

  -- Themes
  use { 
    "projekt0n/github-nvim-theme"
  }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",                                   -- Completion plugin
    "hrsh7th/cmp-buffer",                                 -- Buffer completions
    "hrsh7th/cmp-path",                                   -- Path completions
    "hrsh7th/cmp-cmdline",                                -- Cmdline completions
    "saadparwaiz1/cmp_luasnip",                           -- Snippet completions
    "hrsh7th/cmp-nvim-lsp",                               -- LSP completions
    "hrsh7th/cmp-nvim-lua",                               -- Lua completions
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",                                       -- Snippet engine
    "rafamadriz/friendly-snippets",                           -- A bunch of snippets to use
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",                              -- Enable LSP
    "williamboman/nvim-lsp-installer",                    -- Simple to use language server installer
    "tamago324/nlsp-settings.nvim",                       -- Language server settings defined in json
    "jose-elias-alvarez/null-ls.nvim",                    -- Formatters and linters
    "tami5/lspsaga.nvim",                                  -- LSP saga
    "simrat39/lsp-trouble.nvim",                          -- LSP trouble
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    -- {
    --   "nvim-telescope/telescope.nvim",
    --   requires = {
    --     "nvim-lua/popup.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "nvim-telescope/telescope-fzf-native.nvim"
    --   },
    --   cmd = "telescope",
    -- },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make"
    },
    "nvim-telescope/telescope-project.nvim",
  }

  -- Treesitter
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      run = function ()
        pcall(vim.cmd, ":TSUpdate")
      end
    },
    {
      "SmiteshP/nvim-gps",
      -- after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter"
    },
    'JoosepAlviste/nvim-ts-context-commentstring'
  }

  -- Code
  use {
    "numToStr/Comment.nvim",
    "mattn/emmet-vim",
    "lukas-reineke/indent-blankline.nvim",                   -- Visualize indentation
    "AndrewRadev/splitjoin.vim",                             -- Converts onelines to multilines
    "folke/todo-comments.nvim",                              -- Adds a todo comment
    "norcalli/nvim-colorizer.lua",                           -- Color hex codes
    "nacro90/numb.nvim",                                     -- Peek lines by :number
    "folke/twilight.nvim",
    {
      "folke/zen-mode.nvim",
      disable = false
    },
    {
      "windwp/nvim-autopairs",
      after = {
        "nvim-treesitter",
        "nvim-cmp"
      }
    }                                                             -- Auto pairs for brackets
  }

  -- UI
  use {
    "glepnir/dashboard-nvim",
    "kyazdani42/nvim-tree.lua" ,
    "akinsho/nvim-bufferline.lua" ,
    "rcarriga/nvim-notify" ,
    {
      "hoob3rt/lualine.nvim",
      requires = {
         "nvim-gps",
         "github-nvim-theme"
      }
    },
  }

  -- Git
  use {
    "TimUntersberger/neogit",
    -- "sindrets/diffview.nvim",
    "lewis6991/gitsigns.nvim",
  }


  -- Others
  use {
    "antoinemadec/FixCursorHold.nvim",                          -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    -- use { "akinsho/nvim-toggleterm.lua" }
    {
      "folke/which-key.nvim",
      event = "BufWinEnter"
    },
    {
      "vuki656/package-info.nvim",
      disable = false
    }                                                           -- Packages info in packages.json files

  }

  if packer_bootstrap then
    packer.sync()
  end
end)
