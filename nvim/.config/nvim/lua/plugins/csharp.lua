return {
  { "williamboman/mason.nvim", opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- unofficial registry, required for Roslyn
      },
    } },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "seblyng/roslyn.nvim", ft = "cs", opts = {} },
  { "tris203/rzls.nvim", ft = "razor", opts = {} }, -- Razor/.cshtml support
}
