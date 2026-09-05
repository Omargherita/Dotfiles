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
        ├── after/
        │   └── queries/
        │       └── c_sharp/
        │           └── highlights.scm # Custom Treesitter highlight queries (methods & types)
        └── lua/
            ├── options.lua         # Editor options & diagnostics
            └── plugins/
                ├── ui.lua          # vscode.nvim, Treesitter, Telescope, Neo-tree, etc.
                ├── completion.lua  # nvim-cmp + LuaSnip
                ├── formatting.lua  # conform.nvim (CSharpier on save)
                ├── debugging.lua   # nvim-dap + netcoredbg (C#/.NET)
                ├── csharp.lua      # Roslyn LSP + Razor support (semantic tokens fix)
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

### C# LSP & Semantic Highlighting

- **Roslyn LSP (`lua/plugins/csharp.lua`):**
  - **Range Request Clamping:** Intercepts outgoing `textDocument/semanticTokens/range` LSP requests to clamp out-of-bounds `end_line` values. Neovim can send `line_count` as the end line index, which triggers an unhandled `ArgumentOutOfRangeException` in Roslyn.
  - **Auto-Refresh Semantic Tokens:** Hooks `workspace/projectInitializationComplete` and adds staggered refreshes (1200ms, 2500ms, 4500ms) on `LspAttach` so syntax tokens populate automatically once background solution compilation finishes.
- **Custom Treesitter Queries (`after/queries/c_sharp/highlights.scm`):**
  - Extends Treesitter queries with prioritized patterns for PascalCase type detection (`@type`), static and member method invocations (`@function.method.call`), and member accesses, providing crisp highlighting before and alongside LSP semantic tokens.

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

### Theming & Material You Engine Integration

Kitty supports both a static monochrome theme and dynamic wallpaper-driven theming integrated with [kde-material-you-colors](https://github.com/luisbocanegra/kde-material-you-colors) and [pywal](https://github.com/dylanaraps/pywal):

- **Static Theme:** `themes/cold-frost.conf` ("Obsidian Cold Monochrome") — built around pure blacks, cool greys, and dark cold steel accents. Only errors, warnings, success, and info hints carry color.
- **Dynamic Theming:** Regenerates `~/.cache/wal/colors-kitty.conf` and updates running terminal sessions whenever wallpaper changes.

#### Material You Color Realism & Vibrance Overhaul

By default, stock `kde-material-you-colors` blended terminal ANSI colors 95% toward neutral white (`tones_neutral[99]`) in dark mode (and neutral black in light mode). This stripped all saturation, producing washed-out, pastel, virtually monochromatic syntax highlighting in terminals and Neovim.

To restore realistic color separation and vivid personality, the color generation engine was customized:

1. **Semantic ANSI Palette Mapping (`schemeconfigs.py`):**
   - Maps terminal ANSI color slots directly to functional Material Design 3 tonal palettes:
     - `color1` (Red): Error palette (tone 65 dark / tone 48 light)
     - `color2` (Green): Tertiary palette (tone 65 dark / tone 45 light)
     - `color3` (Yellow): Secondary + tertiary blend (tone 68/62 dark / tone 48/44 light)
     - `color4` (Blue): Primary accent palette (tone 68 dark / tone 46 light)
     - `color5` (Magenta): Error + primary cross-blend (rotates hue)
     - `color6` (Cyan): Tertiary + secondary cross-blend
     - `color7` (White/FG): Neutral tone 90 dark / tone 20 light
2. **HCT Perceptual Chroma Boost (`color_utils.py`):**
   - Added `boost_chroma(hex_color, multiplier=2.0, min_chroma=48.0)` using Google's HCT (Hue, Chroma, Tone) color space.
   - Enforces a minimum chroma floor of 48 and doubles saturation, preventing analogous wallpaper palettes from collapsing into dull, low-contrast pastels while maintaining exact perceptual luminance.
3. **Balanced Neutral Blending:**
   - Replaced the aggressive 95% neutral dilution with a subtle 15% neutral blend, preserving wallpaper harmony while keeping syntax tokens punchy and distinct.

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
