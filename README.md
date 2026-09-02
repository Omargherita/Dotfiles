# dotfiles

My personal configuration files for Neovim and Kitty, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── kitty/
│   └── .config/kitty/
│       ├── kitty.conf          # Main terminal config
│       └── themes/
│           └── cold-frost.conf # Custom "Obsidian Cold" color theme
└── nvim/
    └── .config/nvim/
        ├── init.lua            # Entry point (lazy.nvim bootstrap)
        ├── lazy-lock.json      # Plugin lockfile
        └── lua/
            ├── options.lua     # Editor options & diagnostics
            └── plugins/
                ├── ui.lua          # Colorscheme, Treesitter, Telescope, Neo-tree, etc.
                ├── completion.lua  # nvim-cmp + LuaSnip
                ├── formatting.lua  # conform.nvim (CSharpier on save)
                ├── debugging.lua   # nvim-dap + netcoredbg (C#/.NET)
                ├── csharp.lua      # Roslyn LSP + Razor support
                └── git.lua         # gitsigns.nvim
```

## Requirements

| Tool | Purpose |
|------|---------|
| [GNU Stow](https://www.gnu.org/software/stow/) | Symlink management |
| [Neovim](https://neovim.io/) ≥ 0.10 | Editor |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) | Font used by both configs |

## Installation

Clone the repo and use `stow` to symlink the configs into your home directory:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install all configs
stow kitty nvim

# Or install individually
stow kitty
stow nvim
```

Neovim will auto-install [lazy.nvim](https://github.com/folke/lazy.nvim) and all plugins on first launch.

## Neovim

### Plugins

| Category | Plugin(s) |
|----------|-----------|
| **Plugin manager** | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| **Colorscheme** | [rose-pine](https://github.com/rose-pine/neovim) — Moon variant with custom warm palette |
| **Syntax** | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |
| **Fuzzy finder** | [Telescope](https://github.com/nvim-telescope/telescope.nvim) |
| **File explorer** | [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) |
| **Statusline** | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |
| **Keybind hints** | [which-key.nvim](https://github.com/folke/which-key.nvim) |
| **Completion** | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) |
| **Formatting** | [conform.nvim](https://github.com/stevearc/conform.nvim) — CSharpier on save |
| **Debugging** | [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) + netcoredbg |
| **LSP / C#** | [Mason](https://github.com/williamboman/mason.nvim) + [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) + [rzls.nvim](https://github.com/tris203/rzls.nvim) |
| **Git** | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) |

### Key Mappings

`<leader>` is `Space`.

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer (Neo-tree) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fo` | Recent files |
| `<leader>fd` | Diagnostics |
| `<leader>db` | Toggle breakpoint |
| `<F5>` | Continue (DAP) |
| `<F10>` | Step over (DAP) |
| `<F11>` | Step into (DAP) |

## Kitty

### Theme — Obsidian Cold Frost

A custom monochrome theme built around pure blacks, cool greys, and dark cold steel accent tones. Desaturated by design — only errors, warnings, success, and info hints carry any color.

### Highlights

- **Font:** JetBrainsMono Nerd Font, 11.5pt, ligatures enabled
- **Transparency:** 82% opacity with blur radius 48 (frosted glass effect)
- **Cursor:** Beam with smooth trail animation
- **Tab bar:** Powerline slanted style, positioned at top
- **Scrollback:** 10,000 lines

### Key Mappings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+F5` | Reload config |
| `Ctrl+=` / `Ctrl+-` | Increase / decrease font size |
| `Ctrl+0` | Reset font size |
| `Ctrl+Shift+T` | New tab (CWD) |
| `Ctrl+Shift+W` | Close tab |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous tab |
| `Ctrl+Shift+Enter` | New window split (CWD) |
| `Ctrl+Shift+]` / `[` | Next / previous window |
| `Ctrl+Shift+U` / `M` | Increase / decrease opacity |
| `Ctrl+Shift+Delete` | Reset opacity |
