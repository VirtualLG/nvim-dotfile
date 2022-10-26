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
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :lua require("utils").CleanExtraSpaces()
  endif
]]

