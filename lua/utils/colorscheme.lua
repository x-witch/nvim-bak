-- cursor color: #61AFEF
local colorscheme = "catppuccin"
-- local colorscheme = "github_light"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

if colorscheme == "catppuccin" then
  require "themes.catppuccin"
elseif colorscheme == "github_*" then
  require "themes.github-nvim-theme"
end
