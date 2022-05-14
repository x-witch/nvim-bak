-- https://github.com/tami5/lspsaga.nvim
-- lsp UI相关设置

local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("lspsaga not found!")
  return
end

lspsaga.setup(
  {
  -- 提示边框样式：round、single、double
  -- use_saga_diagnostic_sign = true,
  border_style = "round",
  error_sign = " ",
  warn_sign = " ",
  hint_sign = " ",
  infor_sign = " ",
  diagnostic_header_icon = " ",
  -- 正在写入的行提示
  code_action_icon = " ",
  code_action_prompt = {
    -- 显示写入行提示
    -- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
    enable = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true
  },
  -- 快捷键配置
  code_action_keys = {
    quit = "<Esc>",
    exec = "<CR>"
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>"
  }
}
)
-- lspsaga keymappings
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Lspsaga rename<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
-- -- use goto preview instead as below.
-- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>Lspsaga preview_definition<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>Lspsaga signature_help<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
-- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", opts)
-- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", opts)
-- -- goto preview keymappigs
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
