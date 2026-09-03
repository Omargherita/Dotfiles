-- pywal.nvim — reads colors from ~/.cache/wal/ (populated by pywal16 via
-- kde-material-you-colors) and applies them as a Neovim colorscheme.
-- Repo: https://github.com/AlphaTechnolog/pywal.nvim
-- This is the actively maintained successor to dylanaraps/wal.vim and
-- the archived Vtechgo/pywal.nvim.

return {
  {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",
    -- Load before other UI plugins so highlights are set first
    priority = 1001,
    config = function()
      local ok, pywal = pcall(require, "pywal")
      if not ok then
        vim.notify("[pywal.nvim] module not found — skipping", vim.log.levels.WARN)
        return
      end

      -- Check that wal cache exists; fall back gracefully if daemon hasn't run yet
      local cache = vim.fn.expand("~/.cache/wal/colors.sh")
      if vim.fn.filereadable(cache) == 0 then
        vim.notify(
          "[pywal.nvim] ~/.cache/wal/colors.sh not found.\n" ..
          "Run kde-material-you-colors once to generate it.",
          vim.log.levels.WARN
        )
        return
      end

      pywal.setup()
      vim.cmd.colorscheme("pywal")
    end,
  },
}
