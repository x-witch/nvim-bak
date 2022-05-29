-- 加载缓存优化 ./cache/nvim/luacache_chunks文件
require('impatient') -- This needs to be first
require('filetype')
require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.autocmds")
require('conf.themes.colorscheme')
require('conf.plugins')
require('conf.lsp')
require("utils.custom")

