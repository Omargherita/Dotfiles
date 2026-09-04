return {
  { "Mofiqul/vscode.nvim",
    lazy     = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        style                = "dark",
        transparent          = true,   -- use terminal (Kitty) bg instead of VS grey
        italic_comments      = true,
        disable_nvimtree_bg  = true,
      })
      vim.cmd.colorscheme("vscode")
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
