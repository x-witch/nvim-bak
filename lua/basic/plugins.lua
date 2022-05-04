local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
 local status_ok, packer = pcall(require, "packer")
 if not status_ok then
  return
 end

-- Have packer use a popup window
packer.init {
  display = {
     open_fn = function()
       return require("packer.util").float { border = "rounded" }
     end,
  },
}

--  useage
-- use {
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

-- Install your plugins here
return packer.startup(function(use)
    -- 包管理器
    use "wbthomason/packer.nvim"
    use 'lewis6991/impatient.nvim'  -- 插件缓存
    use "kyazdani42/nvim-web-devicons" -- icons
    use "rcarriga/nvim-notify"  --通知
    use "nvim-lua/popup.nvim"  -- 弹窗
    use "nvim-lua/plenary.nvim"  -- lua开发模块
    use "nathom/filetype.nvim"
    use 'dstein64/vim-startuptime'  -- 启动时间
    -- 中文文档
    use {
        "yianwillis/vimcdoc",
        event = { "BufRead", "BufNewFile" }
    }


    ------------- LSP & 补全 -------------
    use "neovim/nvim-lspconfig"  -- LSP 基础服务
    use "williamboman/nvim-lsp-installer"  -- 自动安装LSP服务器
    use "j-hui/fidget.nvim"  -- LSP进度提示
    use "tami5/lspsaga.nvim" -- LSP UI 美化
    use "mfussenegger/nvim-lint"  -- 扩展LSP诊断
    use "kosayoda/nvim-lightbulb"  -- codeaction 提示代码行为
    -- use "jose-elias-alvarez/null-ls.nvim"
    use "ray-x/lsp_signature.nvim"  -- 获得函数签名

    -- 自动补全系列插件
    use {
       "hrsh7th/nvim-cmp",
       requires = {
           { "hrsh7th/cmp-buffer" }, -- 缓冲区补全
           { "hrsh7th/cmp-path" }, -- 路径补全
           { "hrsh7th/cmp-cmdline" }, -- 命令补全
           { "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
           { "hrsh7th/cmp-nvim-lsp" }, -- 替换内置 omnifunc，获得更多补全
           { "onsails/lspkind-nvim" }, -- 为补全添加类似 vscode 的图标
           { "hrsh7th/cmp-vsnip" }, -- 适用于 vsnip 的代码片段源
           -- { "hrsh7th/vim-vsnip" }, -- vsnip 引擎，用于获得代码片段支持
           -- {"f3fora/cmp-spell"}, -- 拼写建议
           -- {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
           -- { "lukas-reineke/cmp-under-comparator" }, -- 让补全结果的排序更加智能
       }
   }
   use "github/copilot.vim"  -- git copilot 自动补全
   -- tabnine 源,提供基于 AI 的智能补全
   use {
       "tzachar/cmp-tabnine",
       run = "./install.sh"
   }
   -- 代码片段
   use "L3MON4D3/LuaSnip"
   use "rafamadriz/friendly-snippets"


    ------------- DAP -------------
   use "mfussenegger/nvim-dap" -- 代码调试基础插件
   use "ravenxrz/DAPInstall.nvim"
   use "theHamsta/nvim-dap-virtual-text"  -- 为代码调试提供内联文本
   use "rcarriga/nvim-dap-ui"  -- 提供UI界面



   ------------- 个性化 -------------
   -- 优秀的暗色主题
   use {
       "catppuccin/nvim",
       as = "catppuccin"
   }
   -- use 'folke/tokyonight.nvim'  -- tokyonight主题
   use "goolord/alpha-nvim"  --欢迎界面
   use "akinsho/bufferline.nvim"  -- 顶部标签栏
   use "famiu/bufdelete.nvim" -- 删除 buffer 时不影响现有布局
   use 'nvim-lualine/lualine.nvim'  -- 底部状态栏
   -- 加速 j 和 k 移动
   use {
       "PHSix/faster.nvim",
       event = "VimEnter"
   }

   ------------- 常用工具 -------------

   -- 目录大纲
   use "kyazdani42/nvim-tree.lua"  -- 文件树
   -- use "liuchengxu/vista.vim"  -- 代码大纲
   use "stevearc/aerial.nvim"  -- 代码大纲

   -- telescope
   use "nvim-telescope/telescope.nvim"
   use {
       "nvim-telescope/telescope-fzf-native.nvim",
       run = "make",
   }
   use "nvim-telescope/telescope-ui-select.nvim"
   use "nvim-telescope/telescope-live-grep-raw.nvim"
   use "nvim-telescope/telescope-dap.nvim"
   use "BurntSushi/ripgrep" -- 文字查找
   use "sharkdp/fd" -- 文件查找

   ------------- 代码编辑 -------------

   -- 语法高亮
   use {
       "nvim-treesitter/nvim-treesitter",
       run = { ":TSupdate" }
   }
   -- use "numToStr/Comment.nvim"  -- 代码注释
   use "terrortylor/nvim-comment"  -- 代码注释
   use "JoosepAlviste/nvim-ts-context-commentstring"
   use "p00f/nvim-ts-rainbow" -- 彩虹括号
   use "sbdchd/neoformat"  -- 代码格式化
   use "windwp/nvim-autopairs"  -- 自动匹配括号
   use "ur4ltz/surround.nvim"  -- 修改包裹
   -- 快速更改单词
   use {
       "AndrewRadev/switch.vim",
       load_file = true,
       event = { "BufRead", "BufNewFile" }
   }


   ------------- 语言工具 -------------

   use "iamcco/markdown-preview.nvim"  -- markdown 预览
   use "Vimjas/vim-python-pep8-indent"  -- python缩进
   -- emmet 补全
   use {
       "mattn/emmet-vim",
       ft = {
           "html", "css", "javascript", "typescript", "vue", "xml"
       }
   }

   ------------- 编辑体验 -------------

   use "norcalli/nvim-colorizer.lua"  -- 显示网页颜色
   use "lukas-reineke/indent-blankline.nvim"  -- 显示缩进线
   use "kevinhwang91/nvim-hlslens"  -- 搜索时显示条目
   use "folke/which-key.nvim"  -- 显示绑定键位

   -- use "voldikss/vim-translator"  -- 翻译


   ------------- 功能增强 -------------

   use "akinsho/toggleterm.nvim"  -- 内置终端

   -- 显示滚动条
   use {
       "petertriho/nvim-scrollbar",
       load_file = true,
       event = { "BufRead", "BufNewFile" }
   }
   use "Pocco81/AutoSave.nvim"  -- 自动保存

   -- 运行代码片段
   use {
       'michaelb/sniprun',
       run = 'bash ./install.sh',
   }
   use "ethanholz/nvim-lastplace"  -- 自动恢复最后一次光标位置
   use "folke/lsp-colors.nvim"  -- 为不支持LSP高亮的主题提供默认高亮方案
   -- use "rmagatti/auto-session"  -- 自动会话管理



   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if packer_bootstrap then
    require('packer').sync()
    end
end)
