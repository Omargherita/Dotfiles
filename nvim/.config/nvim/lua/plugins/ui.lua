return {
  { "rose-pine/neovim", name = "rose-pine", priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
        -- Override the moon palette: pure black bg + cold purple text tones
        palette = {
          moon = {
            base    = "#0f0d0a",  -- near-black dark charcoal, subtle warmth
            surface = "#171410",  -- panels/sidebars
            overlay = "#1e1a14",  -- floating windows, popups
            muted   = "#6b4f30",  -- dimmed text, line numbers — sienna
            subtle  = "#9b7248",  -- secondary text — mid-tan
            text    = "#d8c4a2",  -- main text — warm parchment/sand
          },
        },
        highlight_groups = {
          -- Keywords (namespace, using, return, if, class, ...): warm white
          ["@keyword"]          = { fg = "#f5ede0" },
          ["@keyword.modifier"] = { fg = "#f5ede0" },  -- public, private, static...
          ["@keyword.import"]   = { fg = "#f5ede0" },  -- using, namespace
          ["@keyword.type"]     = { fg = "#f5ede0" },  -- enum, struct, class, interface
          ["@keyword.operator"] = { fg = "#f5ede0" },  -- new, typeof, sizeof, is, as
          ["Keyword"]           = { fg = "#f5ede0" },  -- fallback (non-TS files)
          ["Statement"]         = { fg = "#f5ede0" },  -- vim legacy fallback

          -- Builtin types (string, int, bool, void, ...): white — they're keywords
          ["@type.builtin"]     = { fg = "#f5ede0" },

          -- User-defined types (class/struct names): warm gold — distinct from keywords
          ["@type"]             = { fg = "gold" },
          ["Type"]              = { fg = "gold" },

          -- Storage class fallback (non-TS)
          ["@storageclass"]     = { fg = "#f5ede0" },
          ["StorageClass"]      = { fg = "#f5ede0" },
        },
      })
      vim.cmd.colorscheme("rose-pine-moon")
    end,
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = {
      ensure_installed = { "c_sharp", "lua", "vim", "vimdoc", "html", "css", "javascript", "json", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    } },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    },
  },
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" } },
  },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
}
