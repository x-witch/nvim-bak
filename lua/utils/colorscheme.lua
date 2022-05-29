-- cursor color: #61AFEF
-- local colorscheme = "catppuccin"
local colorscheme = "everforest"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

if colorscheme == "catppuccin" then
  require "conf.themes.catppuccin"
elseif colorscheme == "everforest" then
  -- require "conf.themes.everforest"
  vim.cmd("colorscheme everforest")
end
