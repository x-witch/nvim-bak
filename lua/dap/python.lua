-- python3 -m pip install debugpy

local dap_install = require("dap-install")
dap_install.config(
  "python",
  {}
-- { -- use default config
--     adapters = {
--         type = "executable",
--         command = "/home/nure/.local/share/nvim/dapinstall/python/bin/python",
--         args = {"-m", "debugpy.adapter"}
--     },
--     configurations = {
--         {
--             type = "python",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             pythonPath = function()
--               return "/usr/bin/python3"
--               -- return vim.g.python_path
--             end,
--         },
--     }
-- }
)
