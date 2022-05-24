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
  -- virtual_text = { prefix = "●", source = "always" },
  virtual_text = false,
  -- signs = {
  --   active = signs,
  -- },
  signs = true,
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

-- 配置 nvim-lsp-installer，它只负责下载 LSP 服务器
local nvim_lsp_installer = require("nvim-lsp-installer")
nvim_lsp_installer.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { "sumneko_lua", "pyright", "jsonls" },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = false,
  -- github = {
  --   -- 针对中国用户，如果 LSP 服务器下载太慢，可以使用下面的镜像站
  --   -- download_url_template = "https://hub.fastgit.xyz/%s/releases/download/%s/%s",
  --   download_url_template = "https://github.com/%s/releases/download/%s/%s",
  -- },
  -- max_concurrent_installers = 20,
}

-- 需要通过 lspconfig 插件启动 LSP 服务器,所以这里将它导入进来
local lspconfig = require("lspconfig")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 5, prefix = "●", severity_limit = "Warning" },
  severity_sort = true,
})

-- 在 LSP 启动配置中添加一个 header，告诉 neovim 当出现帮助信息和签名信息的浮浮动窗口后应该为此窗口添加上一个边框
-- 悬浮文档和签名帮助有浮动边框
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", }),
}


-- 这是一个回调函数，在 LSP 服务器开始工作前会自动调用
local function on_attach(client, bufnr)
  -- set up buffer keymaps
  require("aerial").on_attach(client, bufnr)
  require "lsp_signature".on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end


-- 启动 LSP 服务器
local language_servers_config = {
  sumneko_lua = require("lsp.svr-settings.sumneko_lua"),
  pyright = require('lsp.svr-settings.pyright'),
  jsonls = require('lsp.svr-settings.jsonls'),
}

-- 循环 LSP 服务器名称和配置
for server_name, server_settings in pairs(language_servers_config) do
  local server_available, server = nvim_lsp_installer.get_server(server_name)
  -- 判断 LSP 服务器是否有效
  if server_available then
    -- 判断 LSP 服务器是否已下载
    -- 若未下载则自动下载
    ---@diagnostic disable-next-line: undefined-field
    if not server:is_installed() then
      vim.notify("Install Language Server: " .. server_name, "info", { title = "Language Server" })
      ---@diagnostic disable-next-line: undefined-field
      server:install()
    else
      -- 如果 LSP 服务器已经下载，则将配置文件导入
      local lsp_config = {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = server_settings.settings,
        flags = {
          debounce_text_changes = 150,
        },
      }
      -- 启动 LSP 服务器
      lspconfig[server_name].setup(lsp_config)
    end
  end
end

-- lspconfig.sumneko_lua.setup {
--   handlers = handlers,
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = require('lsp.svr-settings.sumneko_lua').settings,
-- }
--
--
-- lspconfig.pyright.setup {
--   handlers = handlers,
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = require('lsp.svr-settings.pyright').settings,
-- }
--
-- lspconfig.jsonls.setup {
--   handlers = handlers,
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = require('lsp.svr-settings.jsonls').settings,
-- }
