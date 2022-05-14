local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufEnter", {
  pattern = { "*" },
  callback = (function()
    local cursor_hidden_ft = {
      "NvimTree",
      "aerial",
    }
    return function()
      if vim.tbl_contains(cursor_hidden_ft, vim.bo.filetype) then
        vim.o.guicursor = "n-v:hor1-Cursorline,"
      else
        vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
      end
    end
  end)(),
})

-- nvim-tree 自动关闭
-- autocmd("BufEnter", {
--   nested = true,
--   group = myAutoGroup,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--       vim.cmd("quit")
--     end
--   end,
-- })

-- 自动切换输入法（Fcitx 框架）
-- vim.g.FcitxToggleInput = function()
--   local input_status = tonumber(vim.fn.system("fcitx-remote"))
--   if input_status == 2 then
--     vim.fn.system("fcitx-remote -c")
--   end
-- end
-- vim.cmd("autocmd InsertLeave * call FcitxToggleInput()")

-- autocmd({ "InsertLeave" }, {
--   pattern = { "*" },
--   callback = function()
--     local input_status = tonumber(vim.fn.system("fcitx5-remote"))
--     if input_status == 2 then
--       vim.fn.system("fcitx5-remote -c")
--     end
--   end,
-- })

-- 自动切换输入法，需要安装 im-select
-- https://github.com/daipeihust/im-select
-- autocmd("InsertLeave", {
--   group = myAutoGroup,
--   callback = require("utils.im-select").macInsertLeave,
-- })
-- autocmd("InsertEnter", {
--   group = myAutoGroup,
--   callback = require("utils.im-select").macInsertEnter,
-- })
--
-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

-- 保存时自动格式化
autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh" },
  callback = vim.lsp.buf.formatting_sync,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 200
    })
  end,
  pattern = "*",
})
