local M = {}

M.config_mason = function()
  local __mason_settings = {
      ui = {
	  check_outdated_packages_on_open = true,   -- 打开 :Mason 窗口时，自动检查新版本

	  -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
	  border = "none",   -- :Mason 窗口边框样式，与 nvim_open_win() 相同

	  icons = {
	      package_installed = "✓",
	      package_pending = "➜",
	      package_uninstalled = "✗",
	  },

	  keymaps = {
	      toggle_package_expand = "<CR>",
	      install_package = "i",
	      update_package = "u",
	      check_package_version = "c",
	      update_all_packages = "U",
	      check_outdated_packages = "C",
	      uninstall_package = "X",
	      cancel_installation = "<C-c>",
	      apply_language_filter = "<C-f>",
	  },
      },

      -- The directory in which to install packages.
      install_root_dir = vim.fn.stdpath "data" .. "/mason",

      pip = {
	  -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
	  -- and is not recommended.
	  --
	  -- Example: { "--proxy", "https://proxyserver" }
	  install_args = {},
      },

      log_level = vim.log.levels.INFO,  -- log 级别

      max_concurrent_installers = 4,    -- 最大同时安装数目

      github = {
	  -- The template URL to use when downloading assets from GitHub.
	  -- The placeholders are the following (in order):
	  -- 1. The repository (e.g. "rust-lang/rust-analyzer")
	  -- 2. The release version (e.g. "v0.3.0")
	  -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
	  download_url_template = "https://github.com/%s/releases/download/%s/%s",
      },
  }

  return require("mason").setup(__mason_settings)
end

M.config_mason_lsp = function()
  local present, mason_lspconfig = pcall(require, "mason-lspconfig")

  if not present then
    return
  end

  local __mason_lsp_settings = {
    -- 自动安装的 lsp server 列表，该选项与下面的自动安装无关
    ensure_installed = { "clangd", "pyright", "rust_analyzer", "sumneko_lua" },

    -- 是否自动安装通过 nvim lspconfig 配置的 server, 与上述选项无关
    -- 可能值:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
  }

  mason_lspconfig.setup(__mason_lsp_settings)
end

M.config_gentags = function()
  vim.cmd [[
     g:loaded_gentags#ctags=1
  ]]
end


return M
