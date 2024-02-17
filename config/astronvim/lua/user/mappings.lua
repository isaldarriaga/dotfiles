return {
  n = {
    ["<C-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<C-S-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- Ctrl + F4
    ["<F28>"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" },

    ["<C-Up>"] = {"<C-w>k", desc = "Move to split Up"},
    ["<C-Down>"] = {"<C-w>j", desc = "Move to split Down"},
    ["<C-Left>"] = {"<C-w>h", desc = "Move to split Left"},
    ["<C-Right>"] = {"<C-w>l", desc = "Move to split Right"},
    
    ["<C-S-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    ["<C-S-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    ["<C-S-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    ["<C-S-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    -- Ctrl + Shift + F4
    ["<F40>"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
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
