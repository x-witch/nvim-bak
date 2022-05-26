local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  -- size = 20,
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  -- TODO: add my own keymapping to <space-t>
  open_mapping = [[<c-\>]],
  hide_numbers = false,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float", -- 'vertical' | 'horizontal' | 'window' | 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  -- ctrl l preserved for clear terminal content
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal


-- NOTE: need to install lazygit first
-- sudo add-apt-repository ppa:lazygit-team/release
-- sudo apt-get update
-- sudo apt-get install lazygit
-- TODO: 这个命令暂时不起作用

-- For lazygit
-- local lazygit = Terminal:new {
--   cmd = "lazygit",
--   dir = "git_dir",
--   direction = "float",
--   hidden = true,
--   float_opts = {
--     border = "curved",
--   },
-- }

-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end
--
-- local node = Terminal:new({ cmd = "node", hidden = true })
--
-- function _NODE_TOGGLE()
-- 	node:toggle()
-- end
--
-- local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
--
-- function _NCDU_TOGGLE()
-- 	ncdu:toggle()
-- end
--
-- local htop = Terminal:new({ cmd = "htop", hidden = true })
--
-- function _HTOP_TOGGLE()
-- 	htop:toggle()
-- end
--
local python_toggle = Terminal:new({ cmd = "python3", hidden = true })
-- function _PYTHON_TOGGLE()
-- 	python:toggle()
-- end
-- 定义新的方法
toggleterm.pyterm = function()
  python_toggle:toggle()
end
