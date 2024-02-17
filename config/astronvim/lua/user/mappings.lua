-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- mode
  n = {
  --   lefthand side of the map
  
    -- Next buffer: Ctrl + Tab 
    ["<C-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    -- Previous buffer: Ctrl + Shift + Tab
    ["<C-S-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
-- jump window up: Ctrl + Up
["<C-Up>"] = "<C-w>k",
["<C-Up>"] = "<Esc><C-w>k<CR>",

-- jump window down: Ctrl + Down
["<C-Down>"] = "<C-w>j",
["<C-Down>"] = "<Esc><C-w>j<CR>",

-- jump window left: Ctrl + Left
["<C-Left>"] = "<C-w>h",
["<C-Left>"] = "<Esc><C-w>h<CR>",

-- jump window right: Ctrl + Right
["<C-Right>"] = "<C-w>l",
["<C-Right>"] = "<Esc><C-w>l<CR>",

["<C-S-Up>"] = ":resize -2<CR>",
["<C-S-Down>"] = ":resize +2<CR>",
["<C-S-Left>"] = ":vertical resize -2<CR>",
["<C-S-Right>"] = ":vertical resize +2<CR>",
  --
  --   -- mappings seen under group name "Buffer"
  --   ["<leader>bD"] = {
  --     function()
  --       require("astronvim.utils.status").heirline.buffer_picker(
  --         function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
  --       )
  --     end,
  --     desc = "Pick to close",
  --   },
  --   -- tables with the `name` key will be registered with which-key if it's installed
  --   -- this is useful for naming menus
  --   ["<leader>b"] = { name = "Buffers" },
  --   -- quick save
  --   -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  -- t = {
  --   -- setting a mapping to false will disable it
  --   -- ["<esc>"] = false,
  -- },
}
