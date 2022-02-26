vim.bo.expandtab = true                     
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4                     
vim.bo.softtabstop = 4 
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:⏎")

-- 一键运行python
vim.cmd(
    [[
map <F5> :call RunPython()<CR>
func! RunPython()
	exec "w"
	if &filetype=='python'
	    set splitbelow
	    :sp
	    :term python3.9 %
		" exec "!time python3.9 %"
	endif
endfunc
]]
)


-- 自动创建python头部信息
vim.cmd(
    [[
autocmd BufNewFile *.py,*.tex exec ":call SetTitle()"
map <F1> :call SetTitle()<CR>
func! SetTitle() 
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding:UTF-8 -*-")
        call append(line(".")+1, "# File Name: ".expand("%"))
        call append(line(".")+2, "# Author: 🐬 xssaw ")
        call append(line(".")+3, "# Created Time: ".strftime("%c"))
    endif
    normal Go 
endfunc
]]
)
