-- Line numbers: absolute on current line, relative on all others
vim.opt.number         = true
vim.opt.relativenumber = true

-- Tab / Indentation settings
vim.opt.tabstop     = 4  -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth  = 4  -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab   = true -- Convert tabs to spaces

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
  virtual_text = true,   -- show message inline at end of line
  underline    = true,   -- underline the offending text
  update_in_insert = false,
})
