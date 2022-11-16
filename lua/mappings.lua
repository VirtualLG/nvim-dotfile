local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes Interpret
--    normal_mode = "n",
--    insert_mode = "i",
--    visual_mode = "v",
--    visual_block_mode = "x",
--    term_mode = "t",
--    command_mode = "c",

-- Normal --
keymap("n", "<C-h>", "<C-w>h", opts)   		-- window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<ESC>", ":noh <CR>", opts)         -- 取消高亮
-- keymap("n", "<leader>l", ":nohl<cr>", opts)  -- no highlight
keymap("n", ",w", ":w<cr>", opts)               -- save buffer
keymap("n", ",q", ":e ~/buffer <cr>", opts)     -- open a buffer
keymap("n", "Q", ":q <cr>", opts)    		-- quit buffer
keymap("n", "ZZ", ":lua require('utils').SaveAndExit()<cr>", opts)  -- save & exit project
-- Resize with arrows
keymap("n", "<A-=>", ":resize +2<CR>", opts)
keymap("n", "<A-->", ":resize -2<CR>", opts)
keymap("n", "<A-<>", ":vertical resize -2<CR>", opts)
keymap("n", "<A->>", ":vertical resize +2<CR>", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- keymap("n", "<leader>n", ":set nu! <CR>", opts)
keymap("n", "<leader>n", "set rnu! <CR>", opts)

-- Spell checking
keymap("n", ",ss", ":setlocal spell! <CR>", opts)  -- spell checking toggle

-- Window zoom
keymap("n", ",z", ":lua require('utils').WindowZoom() <CR>", opts)

-- Insert --
keymap("i", "jl", "<ESC>", opts)        -- Press jl fast for ESC
keymap("i", "<C-b>", "<ESC>^i", opts)   -- Jump to start of line
keymap("i", "<C-e>", "<END>", opts)     -- Jump to end of line
keymap("i", "<C-h>", "<Left>", opts)    -- move left
keymap("i", "<C-l>", "<Right>", opts)   -- move right
keymap("i", "<C-j>", "<Down>", opts)    -- move down
keymap("i", "<C-k>", "<Up>", opts)      -- move up

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- toggle quickfix
keymap("n", "<C-q>", ":lua require('utils').ToggleQuickFix() <cr>", opts)
keymap("v", "<C-q>", ":lua require('utils').ToggleQuickFix() <cr>", opts)

local M = {}

M.nvimtree = function()
  keymap("n", "<C-n>", ":NvimTreeToggle <CR>", opts)
  keymap("n", "<leader>e", ":NvimTreeFocus <CR>", opts)
end

M.hop = function()
  keymap("n", ";c", ":HopChar2<cr>", opts)
  keymap("n", ";w", ":HopWord<cr>", opts)
  keymap("n", ";l", ":HopLineStart<cr>", opts)
  keymap("n", ";p", ":HopPattern<cr>", opts)
end

M.telescope = function()
  -- find
  keymap("n", "<C-p>",      ":Telescope find_files <CR>", opts)   -- find files
  keymap("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", opts) -- find all
  keymap("n", "<leader>fw", ":Telescope live_grep <CR>", opts)    -- live grep
  keymap("n", "<leader>fs", ":Telescope grep_string <CR>", opts)  -- grep string under cursor
  keymap("n", "<leader>ff", ":Telescope buffers <CR>", opts)      -- find buffers
  keymap("n", "<leader>fh", ":Telescope help_tags <CR>", opts)    -- help page
  keymap("n", "<leader>fo", ":Telescope oldfiles <CR>", opts)     -- find oldfiles
  keymap("n", "<leader>fk", ":Telescope keymaps <CR>", opts)      -- show keys

  -- git
  keymap("n", "<leader>gc", ":Telescope git_commits <CR>", opts)  -- git commits
  keymap("n", "<leader>gs", ":Telescope git_status <CR>", opts)   -- git status

  -- pick a hidden term
  -- keymap("n", "<leader>ff", ":Telescope find_files <CR>", opts)

  -- theme switcher
  -- keymap("n", "<leader>ff", ":Telescope find_files <CR>", opts)

  -- extensions
  keymap("n", "<leader>fd", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
end

M.bufferline = function()
  keymap("n", "H" , ":BufferLineCyclePrev <CR>", opts)      -- cycle prev
  keymap("n", "BH", ":BufferLineMovePrev <CR>", opts)       -- move prev
  keymap("n", "L" , ":BufferLineCycleNext <CR>", opts)      -- cycle next
  keymap("n", "BL", ":BufferLineMoveNext <CR>", opts)       -- move next
  keymap("n", "b1", ":BufferLineGoToBuffer 1 <CR>", opts)   -- GoTo buffer
  keymap("n", "b2", ":BufferLineGoToBuffer 2 <CR>", opts)
  keymap("n", "b3", ":BufferLineGoToBuffer 3 <CR>", opts)
  keymap("n", "b4", ":BufferLineGoToBuffer 4 <CR>", opts)
  keymap("n", "b5", ":BufferLineGoToBuffer 5 <CR>", opts)
  keymap("n", "b6", ":BufferLineGoToBuffer 6 <CR>", opts)
  keymap("n", "b7", ":BufferLineGoToBuffer 7 <CR>", opts)
  keymap("n", "b8", ":BufferLineGoToBuffer 8 <CR>", opts)
  keymap("n", "b9", ":BufferLineGoToBuffer 9 <CR>", opts)
  keymap("n", "bp", ":BufferLinePick <CR>", opts)           -- Buffer Pick
  keymap("n", "bh", ":BufferLineCloseLeft <CR>", opts)      -- BufferLine Close Left
  keymap("n", "bl", ":BufferLineCloseRight <CR>", opts)     -- BufferLine Close Right
  keymap("n", "Bp", ":BufferLineTogglePin <CR>", opts)      -- Buffer pin toggle
  keymap("n", "bc", ":bdelete <CR>", opts)                  -- Buffer Close
end

M.trouble = function()
  keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
  keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
  keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
  keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
  keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
  keymap("n", "gr",         "<cmd>Trouble lsp_references<cr>", opts)
  keymap("n", "<C-9>",      "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})", opts)
  keymap("n", "<C-0>",      "<cmd>lua require('trouble').next({skip_groups = true, jump = true})", opts)
end

M.symbols = function()
  keymap("n", "<leader>s", "<cmd>SymbolsOutline <cr>", opts)
end

M.fugitive = function()
  keymap("n", ",b", "<cmd>Git blame <cr>", opts)
end

M.translator = function()
  keymap("n", "<leader>t", "<cmd>TranslateW <cr>", opts)
  keymap("v", "<leader>t", "<cmd>TranslateW <cr>", opts)
end

return M
