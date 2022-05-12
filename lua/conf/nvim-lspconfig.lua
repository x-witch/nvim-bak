-- https://github.com/neovim/nvim-lspconfig
-- 更多样式定制，参见：https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- 1. 安装 nvim-lspconfig
-- 2. 安装对应 language server(需要nvim-lsp-installer自动安装)
-- 3. 配置对应语言 require('lspconfig').xx.setup{…}
-- 4. :lua print(vim.inspect(vim.lsp.buf_get_clients())) 查看 LSP 连接状态

local M = {}

-- TODO: backfill this to template
M.setup = function()
  -- 诊断样式icon
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  -- 诊断样式定制
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { order = "rounded", })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", })
end

-- 高亮
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

  -- lspsaga keymappings
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Lspsaga rename<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  -- use goto preview instead as below.
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>Lspsaga preview_definition<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>Lspsaga signature_help<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", opts)
  -- goto preview keymappigs
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  -- lsp_highlight_document(client)  -- use RRethy/vim-illuminate instead
  lsp_keymaps(bufnr)
  -- add outline support for evey lanuage
  require("aerial").on_attach(client, bufnr)
  require "lsp_signature".on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)


return M
