vim.g.mapleader = " "

local opts = {noremap = true, silent = true}
local term_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", " ", "<Nop>", opts)

--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal模式 --
-- 正常模式下按 ESC 取消高亮显示
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-- 用 H 和 L 代替 ^ 与 $
keymap("n", "H", "^", opts)
keymap("v", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "L", "$", opts)

-- 将 C-u 和 C-d 调整为上下滑动 10 行而不是半页
keymap("n", "<C-u>", "10k", opts)
keymap("n", "<C-d>", "10j", opts)

-- 修改分屏大小
keymap("n", "<C-up>", "<cmd>res +1<CR>", opts)
keymap("n", "<C-down>", "<cmd>res -1<CR>", opts)
keymap("n", "<C-left>", "<cmd>vertical resize-1<CR>", opts)
keymap("n", "<C-right>", "<cmd>vertical resize+1<CR>", opts)

-- 退出
keymap("n", "Q", ":q<CR>", opts)

-- 加速j和k
keymap("n", "j", "<Plug>(faster_move_j)", {noremap = false, silent = true})
keymap("n", "k", "<Plug>(faster_move_k)", {noremap = false, silent = true})

-- 通过 leader cs 切换拼写检查
-- keymap("n", "<leader>cs", "<cmd>set spell!<CR>", opts)

-- insert模式 --
-- 插入模式下 jj 退出插入模式
keymap("i", "jj", "<Esc>", opts)

-- 插入模式下的上下左右移动
keymap("i", "<A-k>", "<up>", opts)
keymap("i", "<A-j>", "<down>", opts)
keymap("i", "<A-h>", "<left>", opts)
keymap("i", "<A-l>", "<right>", opts)

------------- 插件快捷键 -------------

-- nvim-tree 文件目录
--  <leader>1 打开文件树
keymap("n", "<leader>1", "<cmd>NvimTreeToggle<CR>", opts)
-- 按 leader fc 在文件树中找到当前以打开文件的位置
keymap("n", "<leader>fc", "<cmd>NvimTreeFindFile<CR>", opts)

-- aerial 代码大纲
-- 打开、关闭大纲预览 <leader>a

-- copilot
keymap("i", "<C-l>", "copilot#Accept('')", {silent = true, expr = true})
-- 使用 C-l 确认补全
-- 使用 M-[ 查看上一个补全
-- 使用 M-[ 查看下一个补全
-- 使用 C-[ 关闭补全

-- bufferline
-- 关闭当前 buffer，由 bufdelete 插件所提供的方法
keymap("n", "<C-q>", "<cmd>Bdelete!<CR>", opts)
-- 切换上一个缓冲区
keymap("n", "<C-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
-- 切换下一个缓冲区
keymap("n", "<C-l>", "<cmd>BufferLineCycleNext<CR>", opts)
-- 关闭左侧缓冲区
keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", opts)
-- 关闭右侧缓冲区
keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", opts)

-- Neoformat 格式化
keymap("n", "<leader>fl", "<cmd>Neoformat<CR>", opts)

-- nvim-dap-ui 显示或隐藏调试界面
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
--nvim-dap调试
-- 打断点
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
-- 开启调试或到下一个断点处
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
-- 单步进入执行（会进入函数内部，有回溯阶段）
keymap("n", "<F6>", "<cmd>lua require'dap'.step_into()<CR>", opts)
-- 单步跳过执行（不进入函数内部，无回溯阶段）
keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
-- 步出当前函数
keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<CR>", opts)
-- 重启调试
keymap("n", "<F9>", "<cmd>lua require'dap'.run_last()<CR>", opts)
-- 退出调试（关闭调试，关闭 repl，关闭 ui，清除内联文本）
keymap(
    "n",
    "<F10>",
    "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>",
    opts
)

-- nvim-notify 显示历史弹窗记录（需安装 telescope 插件）
keymap("n", "<leader>fn", "<cmd>lua require('telescope').extensions.notify.notify()<CR>", opts)

-- sniprun
keymap("n", "<leader>rf", ":%SnipRun<cr>", opts)
keymap("v", "<leader>rs", ":%SnipRun<cr>", opts)

-- vista打开大纲预览
-- keymap("n", "<leader>2", "<cmd>Vista!!<CR>", opts)

-- switch
keymap("n", "gs", ":Switch<cr>", opts)

-- telescope
-- 查找文件
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>", opts)
-- 查找文字
-- keymap("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>", opts)
-- 已打开buffers中查找
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>", opts)
-- 查找帮助文档
-- keymap("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>", opts)
-- 查找最近打开的文件
-- keymap("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown<CR>", opts)
-- 查找 marks 标记
-- keymap("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>", opts)

-- ToggleTerm 内置终端
-- 打开终端,也可以用Ctrl+\打开或关闭
keymap("n", "<leader>tt", "<cmd>exe v:count.'ToggleTerm'<CR>", opts)
-- 打开python终端
-- keymap("n", "<leader>tp", "<cmd>lua require('toggleterm').pyterm()<CR>", opts)
