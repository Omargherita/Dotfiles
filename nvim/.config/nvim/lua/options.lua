-- Line numbers: absolute on current line, relative on all others
vim.opt.number         = true
vim.opt.relativenumber = true


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
