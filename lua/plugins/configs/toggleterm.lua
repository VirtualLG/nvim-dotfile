local present, toggleterm = pcall(require, "toggleterm")

if not present then
  vim.notify("toggleterm not found!")
  return
end

local options = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1',
  autochdir = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',

  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

toggleterm.setup(options)

function set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd[[
  autocmd! TermOpen term://* lua set_terminal_keymaps()
]]

local Terminal = require("toggleterm.terminal").Terminal

local htop = Terminal:new({
  cmd = "htop",
  direction = "float",
  float_opts = {
    border = "double",
  },
})

function _htop_toggle()
  htop:toggle()
end

vim.api.nvim_set_keymap("n", ",h", "<cmd>lua _htop_toggle()<CR>", {noremap = true, silent = true})

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "tab",
  -- float_opts = {
  --   border = "double",
  -- },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", ",g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

