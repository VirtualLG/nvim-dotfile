local M = {}

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.ends_with = function(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

-- file exist?
M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end


M.SaveAndExit = function()
  -- wirte all buffer first
  vim.api.nvim_command(":wa")
  -- quit all buffer
  vim.api.nvim_command(":qa")
end

-- gtags
M.GtagsRefernce = function()
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find c " .. word)
  vim.api.nvim_command(":copen")
end

M.GtagsText = function()
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find t " .. word)
  vim.api.nvim_command(":copen")
end

-- GuiTabLabel
-- M.GuiTabLabel = funciton()
--   local label = ''
--   let bufnrlist = tabpagebuflist(v:lnum)

--   " Add '+' if one of the buffers in the tab page is modified
--   for bufnr in bufnrlist
--     if getbufvar(bufnr, "&modified")
--       let label = '+'
--       break
--     endif
--   endfor

--   " Append the number of windows in the tab page if more than one
--   let wincount = tabpagewinnr(v:lnum, '$')
--   if wincount > 1
--     let label ..= wincount
--   endif
--   if label != ''
--     let label ..= ' '
--   endif

--   " Append the buffer name
--   return label .. bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
-- end

-- Delete trailing white space on save, useful for some filetypes :)
M.ClearExtraSpaces = function()
  vim.cmd [[
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  ]]
end

-- Toggle window fullscreen
M.WindowZoom = function()
  vim.cmd [[
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
      let cur_winview = winsaveview()
      let cur_bufname = bufname('')
      tabclose

      " restore the view
      if cur_bufname == bufname('')
          call winrestview(cur_winview)
      endif
    else
      tab split
    endif
  ]]
end

-- Toggle Quick Fix Window
M.ToggleQuickFix = function()
  vim.cmd [[
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen 20
    else
        cclose
    endif
  ]]
end

return M
