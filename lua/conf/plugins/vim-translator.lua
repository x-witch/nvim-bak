-- https://github.com/voldikss/vim-translator
vim.g.translator_default_engines = {"bing", "youdao", "haici"}

-- 翻译成中文

vim.api.nvim_set_keymap("n", "<leader>tsc", ":Translate --target_lang=zh --source_lang=auto<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>tsc", ":TranslateW --target_lang=zh --source_lang=auto<CR>", {noremap = true, silent = true})
-- 翻译成英文
vim.api.nvim_set_keymap("n", "<leader>tse", ":Translate --target_lang=en --source_lang=auto<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>tse", ":TranslateW --target_lang=en --source_lang=auto<CR>", {noremap = true, silent = true})
-- 替换成中文
vim.api.nvim_set_keymap("n", "<leader>trc", ":TranslateR --target_lang=zh --source_lang=auto<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>trc", ":TranslateR --target_lang=zh --source_lang=auto<CR>", {noremap = true, silent = true})
-- 替换成英文
vim.api.nvim_set_keymap("n", "<leader>tre", ":TranslateR --target_lang=en --source_lang=auto<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>tre", ":TranslateR --target_lang=en --source_lang=auto<CR>", {noremap = true, silent = true})
