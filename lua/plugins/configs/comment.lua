local present, nvim_comment = pcall(require, "Comment")

if not present then
  return
end

local comment_opts = {
  active = true,
  on_config_done = nil,
  ---Add a space b/w comment and the line
  ---@type boolean
  padding = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|function
  ignore = "^$",

  ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
  ---@type table
  mappings = {
    ---operator-pending mapping
    ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
  ---@type table
  toggler = {
    ---line-comment toggle
    line = "gcc",
    ---block-comment toggle
    block = "gbc",
  },

  ---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
  ---@type table
  opleader = {
    ---line-comment opfunc mapping
    line = "gc",
    ---block-comment opfunc mapping
    block = "gb",
  },

  ---Pre-hook, called before commenting the line
  ---@type function|nil
  -- pre_hook = pre_hook,
  pre_hook = nil,

  ---Post-hook, called after commenting is done
  ---@type function|nil
  post_hook = nil,
}

nvim_comment.setup(comment_opts)