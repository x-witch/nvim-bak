-- https://github.com/lukas-reineke/indent-blankline.nvim
require("indent_blankline").setup(
    {
        -- 显示当前所在区域
        show_current_context = true,
        -- 显示当前所在区域的开始位置
        show_current_context_start = true,
        -- 显示行尾符
        show_end_of_line = true
    }
)
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
  -- 'startify',
  "dashboard",
  -- 'dotooagenda',
  -- 'log',
  -- 'fugitive',
  -- 'gitcommit',
  -- 'packer',
  -- 'vimwiki',
  -- 'markdown',
  -- 'json',
  -- 'txt',
  -- 'vista',
  -- 'help',
  -- 'todoist',
  -- 'NvimTree',
  -- 'peekaboo',
  -- 'git',
  -- 'TelescopePrompt',
  -- 'undotree',
  -- 'flutterToolsOutline',
  "" -- for all buffers without a file type
}
vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "block",
  "list_literal",
  "selector",
  "^if",
  "^table",
  "if_statement",
  "while",
  "for"
}
-- because lazy load indent-blankline so need readd this autocmd
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
