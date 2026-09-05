return {
  { "williamboman/mason.nvim", opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- unofficial registry, required for Roslyn
      },
    } },
  { "neovim/nvim-lspconfig" },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- Hook workspace/projectInitializationComplete to auto-refresh semantic tokens
      local orig_handler = vim.lsp.config["roslyn"]
        and vim.lsp.config["roslyn"].handlers
        and vim.lsp.config["roslyn"].handlers["workspace/projectInitializationComplete"]

      vim.lsp.config("roslyn", {
        handlers = {
          ["workspace/projectInitializationComplete"] = function(err, result, ctx)
            if orig_handler then
              pcall(orig_handler, err, result, ctx)
            end
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            if client then
              for bufnr in pairs(client.attached_buffers) do
                if vim.api.nvim_buf_is_loaded(bufnr) and vim.lsp.semantic_tokens then
                  pcall(vim.lsp.semantic_tokens.force_refresh, bufnr)
                end
              end
            end
          end,
        },
      })

      -- Intercept outgoing range requests to clamp out-of-bounds end_line:
      -- Neovim sends end_line = line_count, which triggers ArgumentOutOfRangeException in Roslyn
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "roslyn" and not client._range_clamped then
            client._range_clamped = true
            local orig_request = client.request
            client.request = function(self, method, params, handler, bufnr)
              if method == "textDocument/semanticTokens/range" and params and params.range and bufnr and vim.api.nvim_buf_is_valid(bufnr) then
                local num_lines = vim.api.nvim_buf_line_count(bufnr)
                if num_lines > 0 and params.range["end"] and params.range["end"].line >= num_lines then
                  local last_idx = num_lines - 1
                  local last_line = vim.api.nvim_buf_get_lines(bufnr, last_idx, num_lines, false)[1] or ""
                  params.range["end"].line = last_idx
                  params.range["end"].character = #last_line
                end
              end
              return orig_request(self, method, params, handler, bufnr)
            end

            -- Ensure tokens refresh after initial background compilation completes
            local bufnr = args.buf
            for _, delay in ipairs({ 1200, 2500, 4500 }) do
              vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(bufnr) and vim.lsp.semantic_tokens then
                  vim.lsp.semantic_tokens.force_refresh(bufnr)
                end
              end, delay)
            end
          end
        end,
      })
    end,
  },
  { "tris203/rzls.nvim", ft = "razor", opts = {} }, -- Razor/.cshtml support
}
