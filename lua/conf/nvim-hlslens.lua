-- https://github.com/kevinhwang91/nvim-hlslens
-- 其实不用管下面这些键位绑定是什么意思，总之按下这些键位后会出现当前搜索结果的条目数量
-- https://github.com/kevinhwang91/nvim-hlslens
-- hutps://github.com/kevinhwang91/nvim-hlslens

local config = {
  calm_down = true,
  nearest_only = false,
  override_lens = function(render, plist, nearest, idx, r_idx)
    local sfw = vim.v.searchforward == 1
    local indicator, text, chunks
    local abs_r_idx = math.abs(r_idx)
    if abs_r_idx > 1 then
      indicator = string.format('%d%s', abs_r_idx, sfw ~= (r_idx > 1) and '' or '')
    elseif abs_r_idx == 1 then
      indicator = sfw ~= (r_idx == 1) and '' or ''
    else
      indicator = ''
    end

    local lnum, col = unpack(plist[idx])
    if nearest then
      local cnt = #plist
      if indicator ~= '' then
        text = string.format('[%s %d/%d]', indicator, idx, cnt)
      else
        text = string.format('[%d/%d]', idx, cnt)
      end
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
    else
      text = string.format('[%s %d]', indicator, idx)
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
    end
    render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
  end
}
require('hlslens').setup(config)
require("scrollbar.handlers.search").setup()
