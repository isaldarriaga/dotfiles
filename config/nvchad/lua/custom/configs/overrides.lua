local M = {}

M.treesitter = {
  ensure_installed = {
    "angular",
    "bash",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "git_config",
    "gitignore",
    "graphql",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "proto",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- LSP
    "biome",
    "css-lsp",
    "html-lsp",
    "htmx-lsp",
    "json-lsp",
    "lua-language-server",
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
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
