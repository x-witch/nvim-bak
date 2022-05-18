-- 更多样式定制，参见：https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- 1. 安装 nvim-lspconfig
-- 2. 安装对应 language server(需要nvim-lsp-installer自动安装)
-- 3. 配置对应语言 require('lspconfig').xx.setup{…}
-- 4. :lua print(vim.inspect(vim.lsp.buf_get_clients())) 查看 LSP 连接状态-- Setup installer & lsp configs
-- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" }
-- 安装i,更新u,检查版本c,全部更新U,检测过时版本C,卸载X


-- Setup lsp-config & installer

-- 诊断样式定制

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


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

-- TODO: Use lsp_signature instead
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

require("nvim-lsp-installer").setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { "sumneko_lua", "pyright", "jsonls" },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = false,
}

local lspconfig = require("lspconfig")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 5, prefix = "●", severity_limit = "Warning" },
  severity_sort = true,
})

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", }),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
  require("aerial").on_attach(client, bufnr)
  require "lsp_signature".on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- Order matters

lspconfig.jsonls.setup {
  handlers = handlers,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = require('lsp.svr-settings.jsonls').settings,
}

lspconfig.sumneko_lua.setup {
  handlers = handlers,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = require('lsp.svr-settings.sumneko_lua').settings,
}


lspconfig.pyright.setup {
  handlers = handlers,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = require('lsp.svr-settings.pyright').settings,
}


for _, server in ipairs { "cssls", "html", } do
  lspconfig[server].setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
