-- return {
--   n = {
--     -- Navigate buffers
--     ["<C-Tab>"] = {
--       function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
--       desc = "Next buffer",
--     },
--     ["<C-S-Tab>"] = {
--       function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
--       desc = "Previous buffer",
--     },
--     -- close buffer: Ctrl + F4
--     ["<F28>"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" },
--     -- Move to next window
--     ["<C-Up>"] = {"<C-w>k", desc = "Move to split Up"},
--     ["<C-Down>"] = {"<C-w>j", desc = "Move to split Down"},
--     ["<C-Left>"] = {"<C-w>h", desc = "Move to split Left"},
--     ["<C-Right>"] = {"<C-w>l", desc = "Move to split Right"},
--     -- window resize    
--     ["<C-S-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
--     ["<C-S-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
--     ["<C-S-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
--     ["<C-S-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
--     -- close all buffers: Ctrl + Shift + F4
--     ["<F40>"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" },
--     -- "/" in keypad is not recognized atm
--     ["<C-/>"] = { function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, desc = "Toggle comment line" },
--
--   --   -- mappings seen under group name "Buffer"
--   --   ["<leader>bD"] = {
--   --     function()
--   --       require("astronvim.utils.status").heirline.buffer_picker(
--   --         function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
--   --       )
--   --     end,
--   --     desc = "Pick to close",
--   --   },
--   --   -- tables with the `name` key will be registered with which-key if it's installed
--   --   -- this is useful for naming menus
--   --   ["<leader>b"] = { name = "Buffers" },
--   --   -- quick save
--   --   -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
--   },
--   -- t = {
--   --   -- setting a mapping to false will disable it
--   --   -- ["<esc>"] = false,
--   -- },
-- }
-- taken from https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/mappings.lua
local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
local ui = require "astronvim.utils.ui"

local maps = require("astronvim.utils").empty_map_table()

local sections = {
  f = { desc = get_icon("Search", 1, true) .. "find" },
  p = { desc = get_icon("Package", 1, true) .. "packages" },
  A = { desc = "󰫣 ASTRO" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "lsp" },
  u = { desc = get_icon("Window", 1, true) .. "ui" },
  b = { desc = get_icon("Tab", 1, true) .. "buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "sort buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "debugger" },
  g = { desc = get_icon("Git", 1, true) .. "git" },
  S = { desc = get_icon("Session", 1, true) .. "SESSION" },
  t = { desc = get_icon("Terminal", 1, true) .. "terminal" },
}

-- reset keymaps - <space> menu + backspace
maps.n["h"] = { "" }
maps.n["j"] = { "" }
maps.n["k"] = { "" }
maps.n["l"] = { "" }
maps.n["<C-q>"] = { "" }
maps.n["<leader>/"] = is_available "Comment.nvim" and "" or nil
maps.v["<leader>/"] = is_available "Comment.nvim" and "" or nil
maps.n["<leader>w"] = { "" }
maps.n["<leader>q"] = { "" }
maps.n["<leader>Q"] = { "" }
maps.n["<leader>c"] = { "" }
maps.n["<leader>C"] = { "" }
maps.n["<leader>e"] = is_available "neo-tree.nvim" and { "" } or nil
maps.n["<leader>o"] = is_available "neo-tree.nvim" and { "" } or nil
maps.n["<F7>"]       = is_available "toggleterm.nvim" and { "" } or nil
maps.t["<F7>"]       = is_available "toggleterm.nvim" and { "" } or nil
maps.n["<C-'>"]      = is_available "toggleterm.nvim" and { "" } or nil
maps.t["<C-'>"]      = is_available "toggleterm.nvim" and { "" } or nil
maps.t["<leader>th"] = is_available "toggleterm.nvim" and { "" } or nil
maps.t["<leader>tv"] = is_available "toggleterm.nvim" and { "" } or nil

-- apply keymaps
maps.n["<leader>n"] = { "<cmd>enew<cr>", desc = "New File " }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Save " }
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "V-Split " }
maps.n["\\"] = { "<cmd>split<cr>", desc = "H-Split " }
maps.n["<M-1>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }

-- comments
maps.n["<C-/>"] = is_available "Comment.nvim" and { function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, desc = "comment line 󰆅" } or nil
maps.v["<C-/>"] = is_available "Comment.nvim" and { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "comment selection 󰆅" } or nil

-- terminal
maps.n[""]         = is_available "toggleterm.nvim" and { "<cmd>ToggleTerm<cr>", desc = "terminal 󱂬 " } or nil
maps.n["<leader>tf"] = is_available "toggleterm.nvim" and { "<cmd>ToggleTerm direction=float<cr>", desc = "float 󱂬 " } or nil
maps.n["<leader>tb"] = is_available "toggleterm.nvim" and { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "bottom 󱂩 " } or nil
maps.n["<leader>tr"] = is_available "toggleterm.nvim" and { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "right 󱂫 " } or nil


-- Reset keymaps - packages section
maps.n["<leader>p"] = sections.p
maps.n["<leader>pi"] = ""
maps.n["<leader>ps"] = ""
maps.n["<leader>pS"] = ""
maps.n["<leader>pu"] = ""
maps.n["<leader>pU"] = ""
maps.n["<leader>pa"] = ""
maps.n["<leader>pA"] = ""
maps.n["<leader>pv"] = ""
maps.n["<leader>pl"] = ""
maps.n["<leader>pm"] = is_available "mason.nvim" and "" or nil
maps.n["<leader>pM"] = is_available "mason.nvim" and "" or nil

-- Apply keymaps

maps.n["<leader>pp"] = is_available "lazy.nvim" and { function() require("lazy").home() end, desc = " plugins  " } or nil
maps.n["<leader>pP"] = is_available "mason.nvim" and { "<cmd>Mason<cr>", desc = " PACKAGES  " } or nil

maps.n["<leader>pc"] = is_available "lazy.nvim" and { function() require("lazy").check() end, desc = " check plugins  " } or nil
maps.n["<leader>pC"] = is_available "mason.nvim" and { "<cmd>MasonUpdateAll<cr>", desc = " CHECK PACKAGES  " } or nil

maps.n["<leader>pi"] = is_available "lazy.nvim" and { function() require("lazy").install() end, desc = " install plugins  " } or nil
maps.n["<leader>pI"] = is_available "mason.nvim" and { ":call feedkeys(':MasonInstall ')<cr>", desc = " INSTALL <PACKAGE>  " } or nil

maps.n["<leader>pl"] = is_available "lazy.nvim" and { function() require("lazy").log() end, desc = " log plugins  " } or nil
maps.n["<leader>pL"] = is_available "mason.nvim" and { "<cmd>MasonLog<cr>", desc = " LOG PACKAGES  " } or nil

maps.n["<leader>ps"] = is_available "lazy.nvim" and { function() require("lazy").sync() end, desc = " sync plugins  " } or nil
maps.n["<leader>pS"] = is_available "mason.nvim" and { nil, desc = " SYNC PACKAGES 󰜺 " } or nil -- not implemented yet

maps.n["<leader>pu"] = is_available "lazy.nvim" and { function() require("lazy").update() end, desc = " update plugins  " } or nil
maps.n["<leader>pU"] = is_available "mason.nvim" and { "<cmd>MasonUpdate<cr>", desc = " UPDATE PACKAGES  " } or nil

maps.n["<leader>A"] = sections.A
maps.n["<leader>Au"] = { "<cmd>AstroUpdate<cr>", desc = "󰫣 update program  " }
maps.n["<leader>AU"] = { "<cmd>AstroUpdatePackages<cr>", desc = "󰫣 UPDATE ALL (  +  )  " }
maps.n["<leader>Av"] = { "<cmd>AstroVersion<cr>", desc = "󰫣 version  " }
maps.n["<leader>Al"] = { "<cmd>AstroChangelog<cr>", desc = "󰫣 log  " }

-- Manage Buffers
maps.n["<C-Tab>"] =
  { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "buffer " }
maps.n["[b"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = " buffer",
}
maps.n[">b"] = {
  function() require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Move buffer tab right",
}
maps.n["<b"] = {
  function() require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Move buffer tab left",
}

maps.n["<leader>b"] = sections.b
maps.n["<leader>bc"] =
  { function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
maps.n["<leader>bC"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
maps.n["<leader>bl"] =
  { function() require("astronvim.utils.buffer").close_left() end, desc = "Close all buffers to the left" }
maps.n["<leader>bp"] = { function() require("astronvim.utils.buffer").prev() end, desc = "Previous buffer" }
maps.n["<leader>br"] =
  { function() require("astronvim.utils.buffer").close_right() end, desc = "Close all buffers to the right" }
maps.n["<leader>bs"] = sections.bs
maps.n["<leader>bse"] = { function() require("astronvim.utils.buffer").sort "extension" end, desc = "By extension" }
maps.n["<leader>bsr"] =
  { function() require("astronvim.utils.buffer").sort "unique_path" end, desc = "By relative path" }
maps.n["<leader>bsp"] = { function() require("astronvim.utils.buffer").sort "full_path" end, desc = "By full path" }
maps.n["<leader>bsi"] = { function() require("astronvim.utils.buffer").sort "bufnr" end, desc = "By buffer number" }
maps.n["<leader>bsm"] = { function() require("astronvim.utils.buffer").sort "modified" end, desc = "By modification" }

if is_available "heirline.nvim" then
  maps.n["<leader>bb"] = {
    function()
      require("astronvim.utils.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    end,
    desc = "Select buffer from tabline",
  }
  maps.n["<leader>bd"] = {
    function()
      require("astronvim.utils.status.heirline").buffer_picker(
        function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
      )
    end,
    desc = "Close buffer from tabline",
  }
  maps.n["<leader>b\\"] = {
    function()
      require("astronvim.utils.status.heirline").buffer_picker(function(bufnr)
        vim.cmd.split()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Horizontal split buffer from tabline",
  }
  maps.n["<leader>b|"] = {
    function()
      require("astronvim.utils.status.heirline").buffer_picker(function(bufnr)
        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Vertical split buffer from tabline",
  }
end

-- Navigate tabs
maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

-- Alpha
if is_available "alpha-nvim" then
  maps.n["<leader>h"] = {
    function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
        vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
      end
      require("alpha").start(false)
    end,
    desc = "Home Screen  ",
  }
end

-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>g"] = sections.g
  maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  maps.n["<leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  maps.n["<leader>gL"] = { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
  maps.n["<leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  maps.n["<leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  maps.n["<leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  maps.n["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  maps.n["<leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  maps.n["<leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  maps.n["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }
end


-- Session Manager
if is_available "neovim-session-manager" then
  maps.n["<leader>S"] = sections.S
  maps.n["<leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
  maps.n["<leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
  maps.n["<leader>Sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
  maps.n["<leader>S."] =
    { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
end
if is_available "resession.nvim" then
  maps.n["<leader>S"] = sections.S
  maps.n["<leader>Sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
  maps.n["<leader>Ss"] = { function() require("resession").save() end, desc = "Save this session" }
  maps.n["<leader>St"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
  maps.n["<leader>Sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
  maps.n["<leader>Sf"] = { function() require("resession").load() end, desc = "Load a session" }
  maps.n["<leader>S."] = {
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
    desc = "Load current directory session",
  }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<leader>l"] = sections.l
  maps.n["<leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
end

-- Telescope
if is_available "telescope.nvim" then
  maps.n["<leader>f"] = sections.f
  maps.n["<leader>g"] = sections.g
  maps.n["<leader>gb"] =
    { function() require("telescope.builtin").git_branches { use_file_path = true } end, desc = "Git branches" }
  maps.n["<leader>gc"] = {
    function() require("telescope.builtin").git_commits { use_file_path = true } end,
    desc = "Git commits (repository)",
  }
  maps.n["<leader>gC"] = {
    function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
    desc = "Git commits (current file)",
  }
  maps.n["<leader>gt"] =
    { function() require("telescope.builtin").git_status { use_file_path = true } end, desc = "Git status" }
  maps.n["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
  maps.n["<leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  maps.n["<leader>f/"] =
    { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find words in current buffer" }
  maps.n["<leader>fa"] = {
    function()
      local cwd = vim.fn.stdpath "config" .. "/.."
      local search_dirs = {}
      for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
        if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
        if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
      end
      if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
        utils.notify("No user configuration files found", vim.log.levels.WARN)
      else
        if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          search_dirs = search_dirs,
          cwd = cwd,
          follow = true,
        } -- call telescope
      end
    end,
    desc = "Find AstroNvim config files",
  }
  maps.n["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  maps.n["<leader>fc"] = { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" }
  maps.n["<leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
  maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
  maps.n["<leader>fF"] = {
    function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
    desc = "Find all files",
  }
  maps.n["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  maps.n["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  maps.n["<leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  if is_available "nvim-notify" then
    maps.n["<leader>fn"] =
      { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
    maps.n["<leader>uD"] =
      { function() require("notify").dismiss { pending = true, silent = true } end, desc = "Dismiss notifications" }
  end
  maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
  maps.n["<leader>ft"] =
    { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
  maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
  maps.n["<leader>fW"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      }
    end,
    desc = "Find words in all files",
  }
  maps.n["<leader>l"] = sections.l
  maps.n["<leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }
end

-- Terminal for plugins
if is_available "toggleterm.nvim" then
  maps.n["<leader>t"] = sections.t
  if vim.fn.executable "lazygit" == 1 then
    maps.n["<leader>g"] = sections.g
    maps.n["<leader>gg"] = {
      function()
        local worktree = require("astronvim.utils.git").file_worktree()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
        utils.toggle_term_cmd("lazygit " .. flags)
      end,
      desc = "lazygit ",
    }
    maps.n["<leader>tl"] = maps.n["<leader>gg"]
  end
  if vim.fn.executable "node" == 1 then
    maps.n["<leader>tn"] = { function() utils.toggle_term_cmd "node" end, desc = "node 󰎙" }
  end
  local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
  if vim.fn.executable(gdu) == 1 then
    maps.n["<leader>tu"] = ""
    maps.n["<leader>td"] = { function() utils.toggle_term_cmd(gdu) end, desc = "disks 󰡦" }
  end
  if vim.fn.executable "btm" == 1 then
    maps.n["<leader>tt"] = ""
    maps.n["<leader>tm"] = { function() utils.toggle_term_cmd "btm" end, desc = "monitor 󰨇" }
  end
  local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
  if python then
    maps.n["<leader>tp"] = { function() utils.toggle_term_cmd(python) end, desc = "python " }
  end
end

if is_available "nvim-dap" then
  maps.n["<leader>d"] = sections.d
  maps.v["<leader>d"] = sections.d
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
  maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
  maps.n["<F21>"] = { -- Shift+F9
    function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    desc = "Debugger: Conditional Breakpoint",
  }
  maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
  maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
  maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
  maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
  maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
  maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
  maps.n["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
  maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
  maps.n["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
  maps.n["<leader>dC"] = {
    function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    desc = "Conditional Breakpoint (S-F9)",
  }
  maps.n["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
  maps.n["<leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
  maps.n["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
  maps.n["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
  maps.n["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
  maps.n["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
  maps.n["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
  maps.n["<leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
  maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }

  if is_available "nvim-dap-ui" then
    maps.n["<leader>dE"] = {
      function()
        vim.ui.input({ prompt = "Expression: " }, function(expr)
          if expr then require("dapui").eval(expr, { enter = true }) end
        end)
      end,
      desc = "Evaluate Input",
    }
    maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
    maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
    maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
  end
end

-- Improved Code Folding
if is_available "nvim-ufo" then
  maps.n["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" }
  maps.n["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }
  maps.n["zr"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" }
  maps.n["zm"] = { function() require("ufo").closeFoldsWith() end, desc = "Fold more" }
  maps.n["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" }
end

-- Stay in indent mode
maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
maps.v["<Tab>"] = { ">gv", desc = "Indent line" }

-- Improved Terminal Navigation
maps.t["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }

maps.n["<leader>u"] = sections.u
-- Custom menu for modification of the user experience
if is_available "nvim-autopairs" then maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" } end
maps.n["<leader>ub"] = { ui.toggle_background, desc = "Toggle background" }
if is_available "nvim-cmp" then maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" } end
if is_available "nvim-colorizer.lua" then
  maps.n["<leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
end
maps.n["<leader>ud"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" }
maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
maps.n["<leader>ui"] = { ui.set_indent, desc = "Change indent setting" }
maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens" }
maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
maps.n["<leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle Notifications" }
maps.n["<leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" }
maps.n["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" }
maps.n["<leader>uu"] = { ui.toggle_url_match, desc = "Toggle URL highlight" }
maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
maps.n["<leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlighting (buffer)" }
maps.n["<leader>uh"] = { ui.toggle_foldcolumn, desc = "Toggle foldcolumn" }

-- utils.set_mappings(astronvim.user_opts("mappings", maps))

return maps;
