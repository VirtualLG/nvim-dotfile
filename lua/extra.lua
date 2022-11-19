-- -----------------------------------------
-- autocmd
-- -----------------------------------------

-- Clear extra space in the line end
vim.cmd[[
  if has("autocmd")
    autocmd BufWritePre * :%s/\s\+$//e
  endif
]]

vim.cmd[[
  if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :lua require("utils").ClearExtraSpaces()
  endif
]]

vim.cmd[[
  let tags_db = findfile("GTAGS", ".;")
  let tags_path = ""

  if (!empty(tags_db) && filereadable(tags_db))
    let tags_path = strpart(tags_db, 0, match(tags_db, "/GTAGS$"))
  endif

  if tags_path != ""
    exe "chdir " . tags_path
  endif
]]

-- Config DAP
require("plugins.configs.dap")
