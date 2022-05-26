-- cursor color: #61AFEF
local colorscheme = "catppuccin"
-- local colorscheme = "rose-pine"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

if colorscheme == "catppuccin" then
  require "conf.themes.catppuccin"
elseif colorscheme == "rose-pine" then
  require "conf.themes.rose-pine"
end
