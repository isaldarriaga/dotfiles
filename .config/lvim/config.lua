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

-- go window up
lvim.keys.normal_mode["<C-Up>"] = "<C-w>k"
lvim.keys.insert_mode["<C-Up>"] = "<Esc><C-w>k<CR>"

-- go window down
lvim.keys.normal_mode["<C-Down>"] = "<C-w>j"
lvim.keys.insert_mode["<C-Down>"] = "<Esc><C-w>j<CR>"

-- go window left
lvim.keys.normal_mode["<C-Left>"] = "<C-w>h"
lvim.keys.insert_mode["<C-Left>"] = "<Esc><C-w>h<CR>"

lvim.keys.normal_mode["<C-Right>"] = "<C-w>l"
lvim.keys.insert_mode["<C-Right>"] = "<Esc><C-w>l<CR>"

-- terminal: <C-S-t>

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
