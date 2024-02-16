return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.editing-support.todo-comments-nvim" },
    { import = "astrocommunity.colorscheme.tokyonight-nvim" },
    -- { import = "astrocommunity.media.pets-nvim" },
    -- configure imported plugins
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
        }
    },
    {
        "giusgad/pets.nvim",
        opts = {
          row = 4,
        }
    },
}
