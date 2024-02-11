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
lvim.keys.normal_mode["<C-S-Tab>"] = ":BufferLineCyclePrev<CR>"
-- close: <C-F4>


-- close all: <C-S-F4>

-- window

-- navigation
-- up: <C-Up>
-- down: <C-Down>
-- left: <C-Left>
-- right: <C-Right>

-- resizing
-- bigger: <C-S-Up>
-- smaller: <C-S-Down>

-- LSP
-- go to definition: <F12>
-- go to references: <S-F12>
-- rename: F2

-- INSERT MODE
-- toggle case: <C-u>
-- delete line: <C-S-l>
-- save: <C-s>
--
-- MULTILINE
-- add selection: <A-j>
-- remove selectedL <A-S-j>
-- select all: <C-S-A-j>

-- NEOTREE
-- rename: F2
