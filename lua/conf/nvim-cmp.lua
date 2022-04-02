-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/vim-vsnip
-- https://github.com/hrsh7th/cmp-vsnip
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/hrsh7th/cmp-path
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/hrsh7th/cmp-cmdline
-- https://github.com/f3fora/cmp-spell
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/lukas-reineke/cmp-under-comparator
-- https://github.com/tzachar/cmp-tabnine
-- FIX: tabline 在某些计算机上有 1 个 BUG
-- 当出现：TabNine is not executable等字样时，需要手动执行（仅限 Manjaro）：
--    rm ~/.local/share/nvim/plugged/cmp-tabnine/binaries
--    ~/.local/share/nvim/plugged/cmp-tabnine/install.sh

-- luasnip setup
local luasnip = require("luasnip")
local lspkind = require("lspkind")
-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup(
    ---@diagnostic disable-next-line: redundant-parameter
    {
        -- 指定补全引擎
        snippet = {
            expand = function(args)
                -- 使用 vsnip 引擎
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        -- 指定补全源（安装了补全源插件就在这里指定）
        sources = cmp.config.sources(
            {
                {name = "vsnip"},
                {name = "nvim_lsp"},
                {name = "luasnip"},
                {name = "path"},
                {name = "buffer"},
                {name = "cmdline"},
                {name = "spell"},
                {name = "cmp_tabnine"}
            }
        ),
        -- 格式化补全菜单
        formatting = {
            format = lspkind.cmp_format(
                {
                    with_text = true,
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        return vim_item
                    end
                }
            )
        },
        -- 对补全建议排序
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                require("cmp-under-comparator").under,
                require("cmp_tabnine.compare"),
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order
            }
        },
        -- 绑定补全相关的按键
        mapping = {
            -- 上一个
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            -- 下一个
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- 选择补全
            ["<CR>"] = cmp.mapping.confirm(),
            --  出现或关闭补全
            ["<C-k>"] = cmp.mapping(
                {
                    i = function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end,
                    c = function()
                        if cmp.visible() then
                            cmp.close()
                        else
                            cmp.complete()
                        end
                    end
                }
            ),
            -- 类似于 IDEA 的功能，如果没进入选择框，
            -- tab 会选择下一个，如果进入了选择框，tab 会确认当前选择
            -- ["<Tab>"] = cmp.mapping(
            --     function(fallback)
            --         if cmp.visible() then
            --             local entry = cmp.get_selected_entry()
            --             if not entry then
            --                 cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
            --             end
            --             cmp.confirm()
            --         else
            --             fallback()
            --         end
            --     end,
            --     {"i", "s", "c"}
            -- )

            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                else
                    fallback()
                end
            end
        }
    }
)

--重写插件方法,为了实现function 后,自动追加()
local keymap = require("cmp.utils.keymap")
cmp.confirm = function(option)
    option = option or {}
    local e = cmp.core.view:get_selected_entry() or (option.select and cmp.core.view:get_first_entry() or nil)
    if e then
        cmp.core:confirm(
        e,
        {
            behavior = option.behavior
        },
        function()
            local myContext = cmp.core:get_context({reason = cmp.ContextReason.TriggerOnly})
            cmp.core:complete(myContext)
            --function() 自动增加()
                if
                    e and e.resolved_completion_item and
                    (e.resolved_completion_item.kind == 3 or e.resolved_completion_item.kind == 2)
                    then
                        vim.api.nvim_feedkeys(keymap.t("()<Left>"), "n", true)
                    end
                end
                )
                return true
            else
                if vim.fn.complete_info({"selected"}).selected ~= -1 then
                    keymap.feedkeys(keymap.t("<C-y>"), "n")
                    return true
                end
                return false
            end
        end

-- 命令行 / 模式提示
cmp.setup.cmdline(
    "/",
    {
        sources = {
            {name = "buffer"}
        }
    }
)
-- 命令行 : 模式提示
cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)
