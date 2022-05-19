-- https://github.com/kevinhwang91/nvim-hlslens
-- 其实不用管下面这些键位绑定是什么意思，总之按下这些键位后会出现当前搜索结果的条目数量

local status_ok, hlslens = pcall(require, "hlslens")
if not status_ok then
  vim.notify("hlslens not found!")
  return
end

hlslens.setup({
  calm_down = true,
  nearest_only = true,
  nearest_float_when = 'always',
})
require("scrollbar.handlers.search").setup()

