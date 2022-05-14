-- 更多样式定制，参见：https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- 1. 安装 nvim-lspconfig
-- 2. 安装对应 language server(需要nvim-lsp-installer自动安装)
-- 3. 配置对应语言 require('lspconfig').xx.setup{…}
-- 4. :lua print(vim.inspect(vim.lsp.buf_get_clients())) 查看 LSP 连接状态-- Setup installer & lsp configs
-- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" }
-- 安装i,更新u,检查版本c,全部更新U,检测过时版本C,卸载X


-- Setup lsp-config & installer

-- 诊断样式定制
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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

require("nvim-lsp-installer").setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { "sumneko_lua", "pyright", "jsonls" },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = false,
}
local lspconfig = require("lspconfig")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", }),
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
