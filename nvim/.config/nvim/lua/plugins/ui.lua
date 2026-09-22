local function set_ufo_highlights()
  vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "UfoFoldedBg", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { fg = "#7c7c7c", bg = "NONE", italic = true })
end

set_ufo_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ufo_highlights })

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
  { "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
      vim.o.foldcolumn    = "1"
      vim.o.foldlevel     = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable    = true
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds()  end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    },
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  ⋯ %d lines "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            table.insert(newVirtText, { chunkText, chunk[2] })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
        return newVirtText
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
      set_ufo_highlights()
    end,
  },
}
