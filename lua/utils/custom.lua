-- 获取平台图标
local platform_icons = {
  MAC = " ",
  UNIX = " ",
  WINDOWS = " "
}

-- 获取平台 Python 解释器路径
local platform_python = {
  MAC = "/usr/local/bin/python3",
  UNIX = "/usr/bin/python3",
  WINDOWS = "C:\\Python\\python.exe"
}

-- 获取平台 undotree 路径
local platform_undotree = {
  MAC = "~/.config/nvim/undodir",
  UNIX = "~/.config/nvim/undodir",
  WINDOWS = "C:\\Users\\%USERNAME%\\AppData\\Local\\nvim\\undodir"
}

-- 获取平台 代码片段存储路径
local platform_snippet = {
  MAC = "~/.config/nvim/snippets",
  UNIX = "~/.config/nvim/snippets",
  WINDOWS = "C:\\Users\\%USERNAME%\\AppData\\Local\\nvim\\snippets"
}

-- 获取平台 lint 配置文件路径
local platform_lint = {
  MAC = "~/.config/nvim/lint",
  UNIX = "~/.config/nvim/lint",
  WINDOWS = "C:\\Users\\%USERNAME%\\AppData\\Local\\nvim\\lint"
}

-- 数据库链接地址
-- vim.g.dbs = {
--     {
--         name = "dev",
--         url = "mysql://nrnn@192.168.0.120/db1"
--     },
--     {
--         name = "local",
--         url = "mysql://root@localhost:3306/test"
--     }
-- }

-- 获取平台信息
vim.g.platform_info = vim.bo.fileformat:upper()
-- 获取平台图标
vim.g.platform_icon = platform_icons[vim.g.platform_info]
-- Python 解释器目录
vim.g.python_path = platform_python[vim.g.platform_info]
-- 指定代码片段存储路径
vim.g.vsnip_snippet_dir = platform_snippet[vim.g.platform_info]
-- 指定 undotree 缓存存放路径
vim.g.undotree_dir = "~/.cache/nvim/undodir"
-- 指定 lint 配置文件路径
vim.g.lint_config_path = platform_lint[vim.g.platform_info]
-- 指定 translate 代理服务器
vim.g.translator_proxy_url = "socks5://127.0.0.1:7890"
-- 是否开启透明背景
vim.g.background_transparency = false


-- 设置跳出自动补全的括号
-- vim.cmd(
-- [[
-- func SkipPair()
--     if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
--         return "\<ESC>la"
--     else
--         return "\t"
--     endif
-- endfunc
-- " 将tab键绑定为跳出括号
-- inoremap <TAB> <c-r>=SkipPair()<CR>
-- ]]
-- )

-- WSL yank support
-- vim.cmd [[
-- let s:clip = '/mnt/c/Windows/System32/clip.exe'
-- if executable(s:clip)
--     augroup WSLYank
--         autocmd!
--         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--     augroup END
-- endif
-- ]]
