local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  vim.notify("nvim-treesitter.configs not found!")
  return
end

local options = {
  ensure_installed = {
    "lua",
    "c",
    "rust",
    "python",
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  additional_vim_regex_highlighting = false,

  indent = {
    enable = true,
  },
}

treesitter.setup(options)

