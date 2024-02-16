return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.editing-support.todo-comments-nvim" },
        -- configure
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
        }
    }
}
