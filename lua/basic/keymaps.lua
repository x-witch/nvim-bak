vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymaps = {}

keymaps.register = function(group_keymap)
  for _, key_map in pairs(group_keymap) do
    key_map.options.desc = key_map.description
    vim.keymap.set(key_map.mode, key_map.lhs, key_map.rhs, key_map.options)
  end
end

--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymaps.register({
  {
    mode = { "" },
    lhs = " ",
    rhs = "<Nop>",
    options = { silent = true },
    description = "Remap space as leader key",
  },
  -- Normal 模式
  {
    mode = { "n" },
    lhs = "<ESC>",
    rhs = ":nohlsearch<CR>",
    options = { silent = true },
    description = "正常模式下按 ESC 取消高亮显示",
  },
  {
    mode = { "n", "v" },
    lhs = "H",
    rhs = "^",
    options = { silent = true },
    description = "用 H 和 L 代替 ^ 与 $",
  },
  {
    mode = { "n", "v" },
    lhs = "L",
    rhs = "$",
    options = { silent = true },
    description = "用 H 和 L 代替 ^ 与 $",
  },
  {
    mode = { "n" },
    lhs = "<C-u>",
    rhs = "10k",
    options = { silent = true },
    description = "将 C-u 和 C-d 调整为上下滑动 10 行而不是半页",
  },
  {
    mode = { "n" },
    lhs = "<C-d>",
    rhs = "10j",
    options = { silent = true },
    description = "将 C-u 和 C-d 调整为上下滑动 10 行而不是半页",
  },
  {
    mode = { "n" },
    lhs = "<C-up>",
    rhs = "<cmd>res +1<CR>",
    options = { silent = true },
    description = "修改分屏大小",
  },
  {
    mode = { "n" },
    lhs = "<C-down>",
    rhs = "<cmd>res -1<CR>",
    options = { silent = true },
    description = "修改分屏大小",
  },
  {
    mode = { "n" },
    lhs = "<C-left>",
    rhs = "<cmd>vertical resize-1<CR>",
    options = { silent = true },
    description = "修改分屏大小",
  },
  {
    mode = { "n" },
    lhs = "<C-right>",
    rhs = "<cmd>vertical resize+1<CR>",
    options = { silent = true },
    description = "修改分屏大小",
  },
  {
    mode = { "n" },
    lhs = "Q",
    rhs = ":q<CR>",
    options = { silent = true },
    description = "退出",
  },
  {
    mode = { "n" },
    lhs = "j",
    rhs = "<Plug>(faster_move_j)",
    options = { noremap = false, silent = true },
    description = "加速j和k",
  },
  {
    mode = { "n" },
    lhs = "k",
    rhs = "<Plug>(faster_move_k)",
    options = { noremap = false, silent = true },
    description = "加速j和k",
  },
  -- {
  --   mode = { "n" },
  --   lhs = "<leader>cs",
  --   rhs = ":set spell!<cr>",
  --   options = { silent = true },
  --   description = "Enable or disable spell checking",
  -- },

  -- insert模式
  {
    mode = { "i" },
    lhs = "jj",
    rhs = "<Esc>",
    options = { silent = true },
    description = "插入模式下 jj 退出插入模式",
  },
  {
    mode = { "i" },
    lhs = "<A-k>",
    rhs = "<up>",
    options = { silent = true },
    description = "插入模式下的上下左右移动",
  },
  {
    mode = { "i" },
    lhs = "<A-j>",
    rhs = "<down>",
    options = { silent = true },
    description = "插入模式下的上下左右移动",
  },
  {
    mode = { "i" },
    lhs = "<A-h>",
    rhs = "<left>",
    options = { silent = true },
    description = "插入模式下的上下左右移动",
  },
  {
    mode = { "i" },
    lhs = "<A-l>",
    rhs = "<right>",
    options = { silent = true },
    description = "插入模式下的上下左右移动",
  },
  {
    mode = { "t" },
    lhs = "<esc>",
    rhs = "<c-\\><c-n>",
    options = { silent = true },
    description = "Escape terminal insert mode",
  },

  -- 插件快捷键 --
  -- nvim-tree
  {
    mode = { "n" },
    lhs = "<leader>1",
    rhs = "<cmd>NvimTreeToggle<CR>",
    options = { silent = true },
    description = "打开 nvim-tree 文件目录",
  },
  {
    mode = { "n" },
    lhs = "<leader>fc",
    rhs = "<cmd>NvimTreeFindFile<CR>",
    options = { silent = true },
    description = "在文件树中找到当前以打开文件的位置",
  },
  -- copilot
  {
    mode = { "i" },
    lhs = "<C-J>",
    rhs = "copilot#Accept('')",
    options = { silent = true, expr = true },
    description = "github AI 补全",
  },
  -- undotree
  {
    mode = { "n" },
    lhs = "<leader>2",
    rhs = "<cmd>UndotreeToggle<CR>",
    options = { silent = true },
    description = "打开undotree",
  },
  -- bufferline
  {
    mode = { "n" },
    lhs = "<C-q>",
    rhs = "<cmd>Bdelete!<CR>",
    options = { silent = true },
    description = "关闭当前 buffer，由 bufdelete 插件所提供",
  },
  {
    mode = { "n" },
    lhs = "<C-h>",
    rhs = "<cmd>BufferLineCyclePrev<CR>",
    options = { silent = true },
    description = "切换上一个缓冲区",
  },
  {
    mode = { "n" },
    lhs = "<C-l>",
    rhs = "<cmd>BufferLineCycleNext<CR>",
    options = { silent = true },
    description = "切换下一个缓冲区",
  },
  {
    mode = { "n" },
    lhs = "<leader>bh",
    rhs = "<cmd>BufferLineCloseLeft<CR>",
    options = { silent = true },
    description = "关闭左侧缓冲区",
  },
  {
    mode = { "n" },
    lhs = "<leader>bl",
    rhs = "<cmd>BufferLineCloseRight<CR>",
    options = { silent = true },
    description = "关闭右侧缓冲区",
  },
  {
    mode = { "n" },
    lhs = "<M-1>",
    rhs = "<Cmd>BufferLineGoToBuffer 1<CR>",
    options = { silent = true },
    description = "选择buffer按顺序",
  },
  {
    mode = { "n" },
    lhs = "<M-2>",
    rhs = "<Cmd>BufferLineGoToBuffer 2<CR>",
    options = { silent = true },
    description = "选择buffer按顺序",
  },
  {
    mode = { "n" },
    lhs = "<M-3>",
    rhs = "<Cmd>BufferLineGoToBuffer 3<CR>",
    options = { silent = true },
    description = "选择buffer按顺序",
  },
  {
    mode = { "n" },
    lhs = "<leader>fl",
    rhs = "<cmd>Neoformat<CR>",
    options = { silent = true },
    description = "Neoformat 格式化",
  },
  {
    mode = { "n" },
    lhs = "<leader>fn",
    rhs = "<cmd>lua require('telescope').extensions.notify.notify()<CR>",
    options = { silent = true },
    description = "nvim-notify 显示历史弹窗记录（需安装 telescope 插件）",
  },
  -- sniprun
  {
    mode = { "n" },
    lhs = "<leader>rf",
    rhs = ":%SnipRun<cr>",
    options = { silent = true },
    description = "sniprun",
  },
  {
    mode = { "v" },
    lhs = "<leader>rs",
    rhs = ":%SnipRun<cr>",
    options = { silent = true },
    description = "sniprun",
  },
  -- switch
  {
    mode = { "n" },
    lhs = "gs",
    rhs = ":Switch<cr>",
    options = { silent = true },
    description = "switch",
  },
})

return keymaps
