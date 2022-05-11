-- https://github.com/williamboman/nvim-lsp-installer

-- local DEFAULT_SETTINGS = {
--   -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
--   ensure_installed = {},
--   -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
--   -- Can either be:
--   --   - false: Servers are not automatically installed.
--   --   - true: All servers set up via lspconfig are automatically installed.
--   --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
--   --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
--   automatic_installation = false,
--   ui = {
--     icons = {
--       -- The list icon to use for installed servers.
--       server_installed = "◍",
--       -- The list icon to use for servers that are pending installation.
--       server_pending = "◍",
--       -- The list icon to use for servers that are not installed.
--       server_uninstalled = "◍",
--     },
--     keymaps = {
--       -- Keymap to expand a server in the UI
--       toggle_server_expand = "<CR>",
--       -- Keymap to install the server under the current cursor position
--       install_server = "i",
--       -- Keymap to reinstall/update the server under the current cursor position
--       update_server = "u",
--       -- Keymap to check for new version for the server under the current cursor position
--       check_server_version = "c",
--       -- Keymap to update all installed servers
--       update_all_servers = "U",
--       -- Keymap to check which installed servers are outdated
--       check_outdated_servers = "C",
--       -- Keymap to uninstall a server
--       uninstall_server = "X",
--     },
--   },
--
--   -- The directory in which to install all servers.
--   install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
--
--   pip = {
--     -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
--     -- and is not recommended.
--     --
--     -- Example: { "--proxy", "https://proxyserver" }
--     install_args = {},
--   },
--
--   -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
--   -- debugging issues with server installations.
--   log_level = vim.log.levels.INFO,
--
--   -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
--   -- servers that are requested to be installed will be put in a queue.
--   max_concurrent_installers = 4,
-- }

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("nvim-lspconfig not found!")
  return
end

lsp_installer.setup({
    ensure_installed = { "pyright", "sumneko_lua" }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local lspconfig = require("nvim-lspconfig")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.sumneko_lua"),
  -- bashls = require("lsp.config.bash"),
  pyright = require("lsp.pyright"),
  -- html = require("lsp.config.html"),
  -- cssls = require("lsp.config.css"),
  -- emmet_ls = require("lsp.config.emmet"),
  -- jsonls = require("lsp.config.json"),
  -- tsserver = require("lsp.config.ts"),
  -- rust_analyzer = require("lsp.config.rust"),
  -- yamlls = require("lsp.config.yamlls"),
  -- remark_ls = require("lsp.config.markdown"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end
