return {
  { "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
        idle = {
            enabled = true,
            timeout = 900000,
            show_status = true,
            ignore_focus = true,
            unidle_on_focus = true,
            smart_idle = true,
            details = "idling",
        },
      display = {
        theme  = "default",
        flavor = "accent", -- language-coloured icon backgrounds
        view   = "full",   -- large language icon + small Neovim icon
      },
      text = {
        editing   = function(opts) return "Editing "   .. opts.filename end,
        viewing   = function(opts) return "Viewing "   .. opts.filename end,
        workspace = function(opts)
          local home = vim.fn.expand("~")
          -- If cord detected a real workspace root (not home), use it
          if opts.workspace_dir ~= home then
            return "In " .. opts.workspace
          end
          -- Otherwise derive from the open file's directory
          local file_dir = vim.fn.expand("%:p:h")
          if file_dir ~= "" and file_dir ~= home then
            return "In " .. vim.fn.fnamemodify(file_dir, ":t")
          end
          return nil
        end,
      },
      timestamp = { enabled = true },
      advanced = {
        workspace = {
          -- detect project roots even without .git
          root_markers = { ".git", ".hg", ".svn", "*.csproj", "*.sln", "package.json", "Cargo.toml" },
          limit_to_cwd = false,
        },
      },
    },
  },
}
