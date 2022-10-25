local options = {
  laststatus = 3, 		           -- global statusline
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  title = true,                            -- set 'titlestring' to 'filename [+=-] (path) - VIM'
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cursorline = true,                       -- highlight the current line
  cursorcolumn = false,                    -- cursor column.
  colorcolumn = "81",                        -- highlight column 81

  -- Indenting
  expandtab = false,                       -- don't convert tabs to spaces
  shiftwidth = 8,                          -- the number of spaces inserted for each indentation
  autoindent = true,
  smartindent = true,                      -- make indenting smarter again
  tabstop = 8,                             -- insert 8 spaces for a tab

  -- Case Sensitive
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}

  cmdheight = 1,                           -- keep status bar position close to bottom
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  mouse = "",                              -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showtabline = 2,                         -- always show tabs
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 400,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 250,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- keep 8 height offset from above and bottom
  sidescrolloff = 8,                       -- keep 8 width offset from left and right
  foldenable = false,                      -- no fold to be applied when open a file
  foldlevel = 99,                          -- if not set this, fold will be everywhere
}

vim.opt.shortmess:append "c"

-- vim.cmd "highlight LineNR cterm=none ctermfg=Yellow ctermbg=none"
-- vim.cmd "highlight CursorLineNR cterm=bold ctermfg=Yellow ctermbg=none"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

--Remap space as leader key
vim.g.mapleader = " "

-- WSL yank support
vim.cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
]]

-- set guitablabel=%{GuiTabLabel()}

