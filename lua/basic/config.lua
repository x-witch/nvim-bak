-- 自动切换输入法（Fcitx 框架）
vim.g.FcitxToggleInput = function()
    local input_status = tonumber(vim.fn.system("fcitx-remote"))
    if input_status == 2 then
        vim.fn.system("fcitx-remote -c")
    end
end
vim.cmd("autocmd InsertLeave * call FcitxToggleInput()")

-- 是否透明背景
vim.g.background_transparency = true
-- 指定代码片段存储路径
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippet"
