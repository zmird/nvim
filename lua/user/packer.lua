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
    "lewis6991/impatient.nvim",
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
    "hrsh7th/cmp-nvim-lsp",                               -- LSP completions
    "hrsh7th/cmp-nvim-lua",                               -- Lua completions
    "hrsh7th/cmp-nvim-lsp-signature-help",                -- LSP signature help
    "saadparwaiz1/cmp_luasnip",                           -- Snippet completions
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
    -- "tamago324/nlsp-settings.nvim",                       -- Language server settings defined in json
    "jose-elias-alvarez/null-ls.nvim",                    -- Formatters and linters
    "tami5/lspsaga.nvim",                                 -- LSP saga
    "folke/lsp-trouble.nvim",                             -- LSP trouble
  }

  -- Telescope
  use {
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      after = {
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
      },
      config = function ()
        require "user.plugins.telescope"
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cmd = "Telescope",
    },
    {
      "nvim-telescope/telescope-project.nvim",
      cmd = "Telescope",
    },
  }

  -- Treesitter
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      run = function ()
        pcall(vim.cmd, ":TSUpdate")
      end,
      -- event = { "BufRead", "BufNewFile" },
      -- config = function ()
      --   require "user.plugins.treesitter"
      -- end,
    },
    {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter"
    },
    'JoosepAlviste/nvim-ts-context-commentstring'
  }

  -- Code
  use {
    "nacro90/numb.nvim",                                     -- Peek lines by :number
    {
      "folke/todo-comments.nvim",                              -- Adds a todo comment
      event = "BufRead",
    },
    {
      "folke/twilight.nvim",
      cmd = "ZenMode",
      config = function ()
        require "user.plugins.twilight"
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",                           -- Color hex codes
      event = "BufRead",
      config = function ()
        require "user.plugins.colorizer"
      end,
    },
    {
      "AndrewRadev/splitjoin.vim",                             -- Converts onelines to multilines
      event = "BufRead",
    },
    {
      "numToStr/Comment.nvim",
      -- event = "BufRead",
      config = function ()
        require "user.plugins.comment"
      end
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function ()
        require("user.plugins.indent")
      end
    },
    { 
      "mattn/emmet-vim",
      event = "BufRead",
    },
    {
      "folke/zen-mode.nvim",
      disable = false,
      cmd = "ZenMode",
      config = function ()
        require "user.plugins.zen_mode"
      end,
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
    "goolord/alpha-nvim",
    "akinsho/nvim-bufferline.lua",
      "akinsho/toggleterm.nvim",
    {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function ()
        require "user.plugins.nvim_tree"
      end,
    },
    {
      "hoob3rt/lualine.nvim",
      -- disable = true,
      requires = {
         "nvim-gps",
         "github-nvim-theme"
      }
    },
  }

  -- Git
  use {
    -- "sindrets/diffview.nvim",
    -- {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function ()
        require "user.plugins.gitsigns"
      end
    -- },
  }


  -- Others
  use {
    "antoinemadec/FixCursorHold.nvim",                          -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    {
      "mrjones2014/legendary.nvim",
      cmd = "Legendary",
      config = function ()
        require "user.plugins.legendary" 
      end,
    },
  }

  if packer_bootstrap then
    packer.sync()
  end
end)
