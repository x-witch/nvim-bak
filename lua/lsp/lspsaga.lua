-- https://github.com/tami5/lspsaga.nvim
-- lsp UI相关设置

-- 自定义图标
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lspkind
local lspkind = require("lspkind")
lspkind.init({
  -- default: true
  -- with_text = true,
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = "codicons",
  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

local lspsaga = require("lspsaga")
lspsaga.setup({ -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    -- open = "o",
    open = "<CR>",
    vsplit = "s",
    split = "i",
    -- quit = "q",
    quit = "<ESC>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    -- quit = "q",
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_keys = {
    -- quit = "<C-c>",
    quit = "<ESC>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
})

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
  format = lspkind.cmp_format({
    mode = "symbol_text",
    --mode = 'symbol', -- show only symbol annotations

    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
      -- Source 显示提示来源
      vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
      return vim_item
    end,
  }),
}

return M


-- local status_ok, lspsaga = pcall(require, "lspsaga")
-- if not status_ok then
--   vim.notify("lspsaga not found!")
--   return
-- end
--
-- lspsaga.setup(
--   {
--   -- 提示边框样式：round、single、double
--   -- use_saga_diagnostic_sign = true,
--   border_style = "round",
--   error_sign = " ",
--   warn_sign = " ",
--   hint_sign = " ",
--   infor_sign = " ",
--   diagnostic_header_icon = " ",
--   -- 正在写入的行提示
--   code_action_icon = " ",
--   code_action_prompt = {
--     -- 显示写入行提示
--     -- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
--     enable = false,
--     sign = true,
--     sign_priority = 40,
--     virtual_text = true
--   },
--   -- 快捷键配置
--   code_action_keys = {
--     quit = "<Esc>",
--     exec = "<CR>"
--   },
--   rename_action_keys = {
--     quit = "<C-c>",
--     exec = "<CR>"
--   }
-- }
-- )
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
