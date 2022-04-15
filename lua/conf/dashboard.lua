vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_preview_command = 'cat'
vim.g.dashboard_preview_pipeline = 'lolcat'
vim.g.dashboard_preview_file_height = 10
vim.g.dashboard_preview_file_width = 20
vim.g.dashboard_preview_file = '~/.config/nvim/lua/utils/ascii_art'
vim.g.dashboard_session_directory = "~/.cache/nvim/session"
vim.g.dashboard_custom_footer = {"🐬 Have A Good Day!"}
vim.g.dashboard_custom_section = {
        a = {
                description = { "     新 文 件  NON no" },
                command = "DashboardNewFile",
        },
        b = {
                description = { "     查找文件  SPC ff" },
                -- command = "Telescope fd",
                command = "Telescope fd find_command=fd,--hidden",
        },
        c = {
                description = { "     已用文件  SPC fo" },
                command = "Telescope oldfiles",
        },
        d = {
                description = { "     跳转标记  SPC fm" },
                command = "Telescope marks",
        },
        e = {
                description = { "     查看内容  SPC fg" },
                command = "Telescope live_grep",
        },
        -- f = {
        --         description = { "     查看主题  SPC tc" },
        --         command = "Telescope colorscheme",
        -- },
        -- g = {
        --         description = { "    ∂ 查看命令  SPC fc" },
        --         command = "Telescope commands",
        -- },
        -- h = {
        --         description = { "     查看帮助  SPC fa" },
        --         command = "Telescope man_pages",
        -- },
}
-- vim.g.dashboard_disable_at_vimenter = 0
