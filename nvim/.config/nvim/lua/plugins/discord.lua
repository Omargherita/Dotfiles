return {
  { "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
      display = {
        theme  = "default",
        flavor = "accent", -- language-coloured icon backgrounds
        view   = "full",   -- large language icon + small Neovim icon
      },
      text = {
        editing   = function(opts) return "Editing "   .. opts.filename end,
        viewing   = function(opts) return "Viewing "   .. opts.filename end,
        workspace = function(opts) return "In "        .. opts.workspace end,
      },
      timestamp = { enabled = true },
    },
  },
}
