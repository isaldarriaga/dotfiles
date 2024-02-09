---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<tab>"] = "",
    ["<S-tab>"] = ""
 }
}

M.tabufline = {
  plugin = true,
  n = {
    ["<C-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["<C-S-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}
return M
