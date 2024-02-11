-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- options
-- vim.opt.relativenumber = true

-- keymaps

-- buffer navigation
lvim.keys.normal_mode["<C-Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.insert_mode["<C-Tab>"] = "<Esc>:BufferLineCycleNext<CR>"

lvim.keys.normal_mode["<C-S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.insert_mode["<C-S-Tab>"] = "<Esc>:BufferLineCyclePrev<CR>"

-- close: <C-F4>
-- lvim.keys.normal_mode["<C-F4>"] = ":BufferKill<CR>"
-- lvim.keys.insert_mode["<C-Tab>"] = "<Esc>:BufferKill<CR>"

-- close all: <C-S-F4>

-- window navigation

-- jump window up
lvim.keys.normal_mode["<C-Up>"] = "<C-w>k"
lvim.keys.insert_mode["<C-Up>"] = "<Esc><C-w>k<CR>"

-- jump window down
lvim.keys.normal_mode["<C-Down>"] = "<C-w>j"
lvim.keys.insert_mode["<C-Down>"] = "<Esc><C-w>j<CR>"

-- jump window left
lvim.keys.normal_mode["<C-Left>"] = "<C-w>h"
lvim.keys.insert_mode["<C-Left>"] = "<Esc><C-w>h<CR>"

-- jump window right
lvim.keys.normal_mode["<C-Right>"] = "<C-w>l"
lvim.keys.insert_mode["<C-Right>"] = "<Esc><C-w>l<CR>"

-- terminal: <C-S-t>

-- resizing
lvim.keys.normal_mode["<C-S-Up>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<C-S-Down>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<C-S-Left>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["<C-S-Right>"] = ":vertical resize +2<CR>"

-- LSP
-- go to definition: <F12>
-- go to references: <S-F12>
-- rename: F2

-- EDITING TEXT
-- toggle case: <C-u>
-- delete line: <C-S-l>
-- save: <C-s>
-- indenting <tab>
lvim.keys.visual_mode["<Tab>"] = ">gv"
lvim.keys.visual_mode["<S-Tab>"] = "<gv"

-- move line up: <A-Up>
lvim.keys.normal_mode["<A-Down>"] = ":m .+1<CR>=="
lvim.keys.insert_mode["<A-Down>"] = "<Esc>:m .+1<CR>=="

-- move line down: <A-Down>
lvim.keys.normal_mode["<A-Up>"] = ":m .-2<CR>=="
lvim.keys.insert_mode["<A-Up>"] = "<Esc>:m .-2<CR>=="

-- MULTILINE
-- add selection: <A-j>
-- remove selectedL <A-S-j>
-- select all: <C-S-A-j>

-- NEOTREE
-- rename: F2

-- PLUGINS

lvim.plugins = {
  -- git blame
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = true }
    end,
  },
  -- merge/diff tool
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- auto-close html tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- jump by searching with 2 chars
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- css colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,        -- #RGB hex codes
        RRGGBB = true,     -- #RRGGBB hex codes
        RRGGBBAA = true,   -- #RRGGBBAA hex codes
        rgb_fn = true,     -- CSS rgb() and rgba() functions
        hsl_fn = true,     -- CSS hsl() and hsla() functions
        css = true,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,     -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  -- preview LSP definition, references, impl in floating window
  {
  "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    }
  end
},
}
