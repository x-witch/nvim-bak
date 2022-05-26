local options = {
  background = "dark",
  -- 设定各种文本的字符编码
  encoding = "utf-8",
  -- 设定在无操作时，交换文件刷写到磁盘的等待毫秒数（默认为 4000）
  updatetime = 100,
  -- 设定等待按键时长的毫秒数
  timeoutlen = 500,
  -- 命令行高
  cmdheight = 1,
  -- 是否在屏幕最后一行显示命令
  showcmd = true,
  -- 是否允许缓冲区未保存时就切换
  hidden = true,
  -- 是否开启 xterm 兼容的终端 24 位色彩支持
  termguicolors = true,
  -- 是否高亮当前文本行
  cursorline = true,
  -- 是否开启语法高亮
  syntax = "enable",
  -- 是否显示绝对行号
  number = true,
  -- 是否显示相对行号
  relativenumber = true,
  -- Set the width of the number column, default is 4
  numberwidth = 2,
  -- 设定光标上下两侧最少保留的屏幕行数
  scrolloff = 10,
  sidescrolloff = 10,
  -- 是否支持鼠标操作
  mouse = "a",
  -- 是否启用系统剪切板
  clipboard = "unnamedplus",
  -- 是否开启备份文件
  backup = false,
  -- 是否换行
  wrap = false,
  -- 是否开启交换文件
  swapfile = false,
  -- 是否特殊显示空格等字符
  list = true,
  -- 是否开启自动缩进
  autoindent = true,
  -- 设定自动缩进的策略为 plugin
  filetype = "plugin",
  -- Highlight while searching
  incsearch = true,
  -- 是否开启高亮搜索
  hlsearch = true,
  -- 是否在插入括号时短暂跳转到另一半括号上
  showmatch = true,
  -- 是否开启命令行补全
  wildmenu = true,
  -- 是否在搜索时忽略大小写
  ignorecase = true,
  -- 是否开启在搜索时如果有大写字母，则关闭忽略大小写的选项
  smartcase = true,
  -- 是否开启单词拼写检查
  -- spell = true
  -- 设定单词拼写检查的语言
  -- spelllang = "en_us,cjk"
  -- 是否开启代码折叠
  foldenable = false,
  -- 指定代码折叠的策略是按照缩进进行的
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  -- 指定代码折叠的最高层级为 100
  foldlevel = 100,
  -- Natural line breaks
  linebreak = true,
  -- vertical diff split view
  diffopt = "vertical,filler,internal,context:4",
  sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,globals",
  iskeyword = "@,48-57,_,-,192-255",
  fillchars = "vert:┃,horiz:━,verthoriz:╋,horizup:┻,horizdown:┳,vertleft:┫,vertright:┣",
}

-- vim.opt.whichwrap:append("<>[]hl")  --允许backspace和光标跨越行边界
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
-- vim.opt.listchars:append("tab:↹ ")
vim.opt.shortmess:append('c')
-- vim.opt.formatoptions:remove('c')
-- vim.opt.formatoptions:remove('r')
-- vim.opt.formatoptions:remove('o')
vim.opt_global.formatoptions = vim.opt_global.formatoptions - { "c", "r", "o" }

for k, v in pairs(options) do
  vim.opt[k] = v
end

