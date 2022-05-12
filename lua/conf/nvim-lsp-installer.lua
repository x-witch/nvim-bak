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

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("conf.nvim-lspconfig").on_attach,
    capabilities = require("conf.nvim-lspconfig").capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }

  -- -- { key: 服务器名， value: 配置文件 }
  -- -- key 必须为下列网址列出的 server name，不可以随便写
  -- -- https://github.com/williamboman/nvim-lsp-installer#available-lsps
  local servers = {
    -- 语言服务器名称：配置文件
    sumneko_lua = require("lsp.sumneko_lua"),
    pyright = require("lsp.pyright"),
    -- tsserver = require("lsp.tsserver"),
    -- html = require("lsp.html"),
    -- cssls = require("lsp.cssls"),
    -- gopls = require("lsp.gopls"),
    -- jsonls = require("lsp.jsonls"),
    -- zeta_note = require("lsp.zeta_note"),
    -- sqls = require("lsp.sqls"),
    -- vuels = require("lsp.vuels")
  }
  for _, lsp in pairs(servers) do
    -- require('lspconfig')[lsp].setup {}
    opts = vim.tbl_deep_extend("force", lsp, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
