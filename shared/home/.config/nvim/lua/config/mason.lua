require("mason-lspconfig").setup({
  ensure_installed = {
    -- LSP
    "biome",
    "css-lsp",
    "html-lsp",
    "htmx-lsp",
    "json-lsp",
    "marksman",
    "rust-analyzer",
    "taplo",
    "typos-lsp",
    "yaml-language-server",
    -- DAP
    "codelldb",
    "js-debug-adapter",
    -- formatter
    "markdownlint",
    "shfmt",
    "stylua",
  },
})
