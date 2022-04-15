-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

local filetype_table = {
    "NvimTree",
    "aerial"
}
local function disable_built_component()
    local filetype = vim.bo.filetype
    for _, ft in ipairs(filetype_table) do
        if filetype == ft then
            return false
        end
    end
    return true
end

local function enable_built_component()
    local filetype = vim.bo.filetype
    for _, ft in ipairs(filetype_table) do
        if filetype == ft then
            return true
        end
    end
    return false
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = "auto"
    theme = bubbles_theme,
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    -- component_separators = '|',
    -- section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    -- lualine_a = {
    --   { 'mode', separator = { left = '' }, right_padding = 2 },
    -- },
    -- lualine_b = { 'filename', 'branch' },
    -- lualine_c = { 'fileformat' },
    -- lualine_x = {},
    -- lualine_y = { 'filetype', 'progress' },
    -- lualine_z = {
    --   { 'location', separator = { right = '' }, left_padding = 2 },
    -- },
    lualine_a = {
        {"mode", cond = disable_built_component},
        {"filetype", cond = enable_built_component}
    },
    lualine_b = {
        {"branch", cond = disable_built_component},
        {"diff", cond = disable_built_component},
        {"diagnostics", cond = disable_built_component}
    },
    lualine_c = {
        {"filename", cond = disable_built_component},
        -- {gps.get_location, cond = gps.is_available}
    },
    lualine_x = {
        {"encoding", cond = disable_built_component},
        {"fileformat", cond = disable_built_component},
        {"filetype", cond = disable_built_component}
    },
    lualine_y = {
        {"progress", cond = disable_built_component}
    },
    lualine_z = {
        {"location", cond = disable_built_component}
    }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
