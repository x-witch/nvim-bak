-- python3 -m pip install debugpy

-- return {
--     adapters = {
--         type = "executable",
--         command = "python3",
--         args = {"-m", "debugpy.adapter"}
--     },
--     configurations = {
--         {
--             type = "python",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             pythonPath = function()
--                 return vim.g.python_path
--             end
--         }
--     }
-- }

local dap_install = require("dap-install")
dap_install.config(
	"python",
  {}
  -- { -- use default config
  --     adapters = {
  --         type = "executable",
  --         command = "/home/raven/.local/share/nvim/dapinstall/python/bin/python",
  --         args = {"-m", "debugpy.adapter"}
  --     },
  --     configurations = {
  --         {
  --             type = "python",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             pythonPath = function()
  --               return "/usr/bin/python"
  --             end,
  --         },
  --     }
-- }
)
