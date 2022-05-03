-- https://github.com/Pocco81/AutoSave.nvim
local status_ok, autosave = pcall(require, "autosave")
if not status_ok then
  vim.notify("autosave not found!")
  return
end

autosave.setup(
    {
        enabled = true,
        -- execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        execution_message = "",
        -- 触发自动保存的事件（退出插入模式或者普通模式下文本内容发生改变）
        events = {"InsertLeave", "TextChanged"},
        -- 自动保存时的提示信息
        conditions = {
            exists = true,
            filename_is_not = { "plugins.lua" },
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
