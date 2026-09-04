# dotfiles

My personal configuration files for Neovim and Kitty, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── kitty/
│   └── .config/kitty/
│       ├── kitty.conf              # Main terminal config
│       └── themes/
│           └── cold-frost.conf     # Theme ("Obsidian Cold Monochrome")
└── nvim/
    └── .config/nvim/
        ├── init.lua                # Entry point (lazy.nvim bootstrap & Treesitter autocmd)
        ├── lazy-lock.json          # Plugin lockfile
        └── lua/
            ├── options.lua         # Editor options & diagnostics
            └── plugins/
                ├── ui.lua          # vscode.nvim, Treesitter, Telescope, Neo-tree, etc.
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
git clone git@github.com:Omargherita/Dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install all configs
stow kitty nvim

# Or install individually
stow kitty
stow nvim
```

Neovim will auto-install [lazy.nvim](https://github.com/folke/lazy.nvim) and all plugins on first launch.

---

## Neovim

### Plugins

| Category | Plugin(s) |
|----------|-----------|
| **Plugin manager** | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| **Colorscheme** | [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) |
| **Syntax** | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |
| **Fuzzy finder** | [Telescope](https://github.com/nvim-telescope/telescope.nvim) |
| **File explorer** | [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) |
| **Statusline** | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |
| **Keybind hints** | [which-key.nvim](https://github.com/folke/which-key.nvim) |
| **Completion** | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + friendly-snippets |
| **Formatting** | [conform.nvim](https://github.com/stevearc/conform.nvim) — CSharpier on save |
| **Debugging** | [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) + nvim-dap-virtual-text + netcoredbg |
| **LSP / C#** | [Mason](https://github.com/williamboman/mason.nvim) + [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) + [rzls.nvim](https://github.com/tris203/rzls.nvim) |
| **Git** | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) |

### Colorscheme

[vscode.nvim](https://github.com/Mofiqul/vscode.nvim) is the active theme, configured with:
- **Style:** Dark mode (`dark`)
- **Transparency:** Enabled (`transparent = true`), using the terminal (Kitty) background
- **Italics:** Italic comments enabled
- **Treesitter:** Auto-highlighting is enabled for buffers on `FileType`, `BufReadPost`, and `BufNewFile` whenever a parser is installed.

### Key Mappings

`<leader>` and `<localleader>` are both `Space`.

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

### Completion

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` / `<S-Tab>` | Next / previous item |

---

## Kitty

### Theming

Kitty uses the static **`themes/cold-frost.conf`** ("Obsidian Cold Monochrome") theme. It is a custom monochrome palette built around pure blacks, cool greys, and dark cold steel accents. Only errors, warnings, success, and info hints carry color, with window border colors configured directly within the theme.

### Highlights

- **Font:** JetBrainsMono Nerd Font, 11.5pt, ligatures enabled
- **Transparency:** 82% opacity with blur radius 48 (frosted glass effect), adjustable at runtime
- **Cursor:** Beam with smooth trail animation
- **Tab bar:** Powerline slanted style, positioned at top
- **Scrollback:** 10,000 lines
- **Other:** Copy-on-select, URL detection, focus-follows-mouse

### Key Mappings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+F5` | Reload config |
| `Ctrl+=` / `Ctrl++` / `Ctrl+-` | Increase / increase / decrease font size |
| `Ctrl+0` | Reset font size |
| `Ctrl+Shift+T` | New tab (CWD) |
| `Ctrl+Shift+W` | Close tab |
| `Ctrl+Shift+]` / `Ctrl+Shift+[` | Next / previous tab |
| `Ctrl+Shift+Enter` / `Ctrl+Shift+D` | New window split (CWD) |
| `Ctrl+Shift+Q` | Close window |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous window |
| `Ctrl+Shift+U` / `Ctrl+Shift+M` | Increase / decrease opacity |
| `Ctrl+Shift+Delete` | Reset opacity to default |
