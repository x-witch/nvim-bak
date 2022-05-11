-- WARN: telescope 手动安装依赖 fd 和 ripgrep 和 fzf
-- https://github.com/sharkdp/fd
-- https://github.com/BurntSushi/ripgrep
-- NOTE: install ripgrep for live_grep picker

-- ====for live_grep raw====:
-- for rp usage: reference: https://segmentfault.com/a/1190000016170184
-- -i ignore case
-- -s 大小写敏感
-- -w match word
-- -e 正则表达式匹配
-- -v 反转匹配
-- -g 通配符文件或文件夹，可以用!来取反
-- -F fixed-string 原意字符串，类似python的 r'xxx'

-- examples:
-- command	Description
-- rg image utils.py	Search in a single file utils.py
-- rg image src/	Search in dir src/ recursively
-- rg image	Search image in current dir recursively
-- rg '^We' test.txt	Regex searching support (lines starting with We)
-- rg -i image	Search image and ignore case (case-insensitive search)
-- rg -s image	Smart case search
-- rg -F '(test)'	Search literally, i.e., without using regular expression
-- rg image -g '*.py'	File globing (search in certain files), can be used multiple times
-- rg image -g '!*.py'	Negative file globing (do not search in certain files)
-- rg image --type py or rg image -tpy1	Search image in Python file
-- rg image -Tpy	Do not search image in Python file type
-- rg -l image	Only show files containing image (Do not show the lines)
-- rg --files-without-match image	Show files not containing image
-- rg -v image	Inverse search (search files not containing image)
-- rg -w image	Search complete word
-- rg --count	Show the number of matching lines in a file
-- rg --count-matches	Show the number of matchings in a file
-- rg neovim --stats	Show the searching stat (how many matches, how many files searched etc.)

-- ====for fzf search=====
-- Token	Match type	Description
-- sbtrkt	fuzzy-match	Items that match sbtrkt
-- 'wild	exact-match (quoted)	Items that include wild
-- ^music	prefix-exact-match	Items that start with music
-- .mp3$	suffix-exact-match	Items that end with .mp3
-- !fire	inverse-exact-match	Items that do not include fire
-- !^music	inverse-prefix-exact-match	Items that do not start with music
-- !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("telescope not found!")
    return
end

-- if not pcall(require, "telescope") then
--   return
-- end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_layout = require "telescope.actions.layout"

local fileIgnorePatterns = os.getenv('TELESCOPE_FILE_IGNORE_PATTERNS')
  local fileIgnoreTable = nil
  if fileIgnorePatterns then
    fileIgnoreTable = {}
    for pattern in string.gmatch(fileIgnorePatterns, "%S+") do
     table.insert(fileIgnoreTable, pattern)
    end
  end

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end
  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end


telescope.setup {
  defaults = {
    file_ignore_patterns = fileIgnoreTable or nil,
    prompt_prefix = "> ", -- 
    selection_caret = "  ",
    entry_prefix = "  ",
    multi_icon = "<>",
    -- path_display = "truncate",
    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.select_horizontal,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        -- ["<C-y>"] = set_prompt_to_entry_value,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
        ["<C-_>"] = actions.which_key
        -- ["<M-p>"] = action_layout.toggle_prompt_position,
        -- ["<M-m>"] = actions.master_stack,
        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- This is nicer when used with smart-history plugin.
        -- ["<c-g>s"] = actions.select_all,
        -- ["<c-g>a"] = actions.add_selection,

        -- ["<c-space>"] = function(prompt_bufnr)
        --   local opts = {
        --     callback = actions.toggle_selection,
        --     loop_callback = actions.send_selected_to_qflist,
        --   }
        --   require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
        -- end,

        -- ["<C-w>"] = function()
        --   vim.api.nvim_input "<c-s-w>"
        -- end,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["?"] = actions.which_key
      },
    },

    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },

  pickers = {
    fd = {
      mappings = {
        n = {
          -- ["kj"] = "close",
        },
      },
    },

    -- git_branches = {
    --   mappings = {
    --     i = {
    --       ["<C-a>"] = false,
    --     },
    --   },
    -- },
  },

  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },

    -- fzy_native = {
    --   override_generic_sorter = true,
    --   override_file_sorter = true,
    -- },
    --
    -- fzf_writer = {
    --   use_highlighter = false,
    --   minimum_grep_characters = 6,
    -- },

    -- hop = {
    --   -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
    --   keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }, -- ... and more
    --
    --   -- Highlight groups to link to signs and lines; the below configuration refers to demo
    --   -- sign_hl typically only defines foreground to possibly be combined with line_hl
    --   sign_hl = { "WarningMsg", "Title" },
    --
    --   -- optional, typically a table of two highlight groups that are alternated between
    --   line_hl = { "CursorLine", "Normal" },
    --
    --   -- options specific to `hop_loop`
    --   -- true temporarily disables Telescope selection highlighting
    --   clear_selection_hl = false,
    --   -- highlight hopped to entry with telescope selection highlight
    --   -- note: mutually exclusive with `clear_selection_hl`
    --   trace_entry = true,
    --   -- jump to entry where hoop loop was started from
    --   reset_selection = true,
    -- },

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },

    -- frecency = {
    --   workspaces = {
    --     ["conf"] = "/home/tj/.config/nvim/",
    --     ["nvim"] = "/home/tj/build/neovim",
    --   },
    -- },
  },
}

-- pcall(require("telescope").load_extension, "cheat")
-- pcall(require("telescope").load_extension, "arecibo")
-- require("telescope").load_extension "flutter"

_ = require("telescope").load_extension "dap"
_ = require("telescope").load_extension "notify"
-- _ = require("telescope").load_extension "file_browser"
_ = require("telescope").load_extension "ui-select"
_ = require("telescope").load_extension "fzf"
-- _ = require("telescope").load_extension "git_worktree"
-- _ = require("telescope").load_extension "neoclip"

-- pcall(require("telescope").load_extension, "smart_history")
-- pcall(require("telescope").load_extension, "frecency")

if vim.fn.executable "gh" == 1 then
  pcall(require("telescope").load_extension, "gh")
  pcall(require("telescope").load_extension, "octo")
end

-- LOADED_FRECENCY = LOADED_FRECENCY or true
-- local has_frecency = true
-- if not LOADED_FRECENCY then
--   if not pcall(require("telescope").load_extension, "frecency") then
--     require "tj.telescope.frecency"
--   end

--   LOADED_FRECENCY = true
-- end
