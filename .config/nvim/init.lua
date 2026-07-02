-- ~/.config/nvim/init.lua
-- Single-file Neovim config for WSL2
-- Requires: Neovim 0.12+, git in PATH
--
-- ──────────────────────────────────────────────
-- install mini.nvim via vim.pack (built-in 0.12+)
-- cached in stdpath('data')
-- ──────────────────────────────────────────────
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
  { src = 'https://github.com/sainnhe/edge' },
})

-- ──────────────────────────────────────────────
-- CORE OPTIONS
-- ──────────────────────────────────────────────

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true
vim.opt.wrap           = true
vim.opt.termguicolors  = true        -- required by colorscheme + animate + hipatterns
vim.opt.clipboard      = 'unnamedplus' -- share clipboard with Windows (needs win32yank.exe in PATH)
vim.opt.signcolumn     = 'yes'       -- prevent layout shifts from diff/git signs
vim.opt.splitright     = true
vim.opt.splitbelow     = true

-- ──────────────────────────────────────────────
-- mini.nvim MODULES (all disabled by default)
-- ──────────────────────────────────────────────

-- mini.ai ─ Extended text objects (a/i variants for brackets, quotes, tags, etc.)
require('mini.ai').setup()

-- mini.align ─ Align text interactively (ga / gA operators)
-- require('mini.align').setup()

-- mini.animate ─ Smooth animations for cursor, scroll, resize, and window open/close
require('mini.animate').setup({
  cursor = {
    enable = true,
    timing = require('mini.animate').gen_timing.linear({ 
      duration = 60, -- Duration in milliseconds (Default is 250)
      unit = 'total' 
    }),
    -- Customize how the target coordinates are handled
    path = require('mini.animate').gen_path.line({
      predicate = function()
	      return true
      end,
    }),
  },
  scroll = {
    enable = false,
  }
})

-- mini.base16 ─ Build a full colorscheme from a Base16 palette
-- require('mini.base16').setup({ palette = require('mini.base16').mini_palette('#112641', '#e2e98f', 75) })

-- mini.basics ─ Sensible default options, mappings, and autocommands in one call
require('mini.basics').setup()

-- mini.bracketed ─ Jump to/from bracket-like delimiters with [ and ] prefixes
require('mini.bracketed').setup()

-- mini.bufremove ─ Remove/wipe buffers without closing their windows
-- require('mini.bufremove').setup()

-- mini.clue ─ Show pending keymap hints after a delay (like which-key.nvim)
require('mini.clue').setup()

-- mini.colors ─ Interactive colorscheme explorer and real-time tweaker
require('mini.colors').setup()

-- mini.comment ─ Toggle comments with gcc (line) and gc (motion/visual)
require('mini.comment').setup()

-- mini.completion ─ Autocompletion with LSP and buffer sources
require('mini.completion').setup()

-- mini.cursorword ─ Highlight all occurrences of the word under the cursor
require('mini.cursorword').setup()

-- mini.deps ─ Full plugin manager (an alternative to vim.pack for advanced workflows)
local deps = require('mini.deps')
deps.setup()

-- mini.diff ─ Gutter signs for git hunks + toggle inline diff overlay
require('mini.diff').setup()

-- mini.doc ─ Generate vimdoc help files from Lua annotation comments
-- require('mini.doc').setup()

-- mini.extra ─ Extra pickers for mini.pick and additional text objects for mini.ai
require('mini.extra').setup()

-- mini.files ─ Two-pane file explorer (edit directory buffers to manipulate files)
require('mini.files').setup()

-- mini.fuzzy ─ Fuzzy matching helper used internally by mini.pick and mini.completion
require('mini.fuzzy').setup()

-- mini.git ─ Git integration: status, inline blame, hunk navigation, log
require('mini.git').setup()

-- mini.hipatterns ─ Highlight arbitrary patterns (hex colors, TODO/FIXME, etc.)
require('mini.hipatterns').setup()

-- mini.hues ─ Generate a full colorscheme from two seed hex colors
-- require('mini.hues').setup({ background = '#11262d', foreground = '#c0c8cc' })

-- mini.icons ─ Icon provider that integrates with mini.files, mini.pick, mini.statusline
require('mini.icons').setup()

-- mini.indentscope ─ Animated indent-scope indicator line
require('mini.indentscope').setup()

-- mini.input ─ Customizable replacement for vim.ui.input()
-- require('mini.input').setup()

-- mini.jump ─ Enhanced f/F/t/T motions that highlight targets and support repeat
-- require('mini.jump').setup()

-- mini.jump2d ─ Jump to any visible position in two keystrokes (like leap/hop)
-- require('mini.jump2d').setup()

-- mini.keymap ─ Extra key mapping helpers and combo/chord support
require('mini.keymap').setup()

-- mini.map ─ Minimap sidebar with configurable symbols and integration hooks
require('mini.map').setup()

-- mini.misc ─ Miscellaneous helpers: zoom window, put blank line, restore cursor, etc.
require('mini.misc').setup()

-- mini.move ─ Move lines or visual selections with Alt+hjkl
require('mini.move').setup()

-- mini.notify ─ Replace vim.notify() with a floating notification history log
require('mini.notify').setup()

-- mini.operators ─ Custom operators: sort, replace with register, multiply text
-- require('mini.operators').setup()

-- mini.pairs ─ Auto-close brackets, quotes, and other pairs
--require('mini.pairs').setup({
--  mappings = {
--    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' }, -- Base pattern
--    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
--    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
--    
--    -- Force quotes to only trigger if the right side is empty/end of line
--    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].' },
--    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\].' },
--    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].' },
--  }
--})

require('mini.pairs').setup({
  mappings = {
    -- Open actions (brackets)
    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^%w][^%w]' },
    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^%w][^%w]' },
    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^%w][^%w]' },
    
    -- Closeopen actions (quotes and backticks)
    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w][^%w]' },
    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w][^%w]' },
    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w][^%w]' },
  }
})

-- mini.pick ─ Fuzzy finder for files, grep, buffers, LSP symbols, and more
require('mini.pick').setup()

-- mini.sessions ─ Save and restore named sessions
-- require('mini.sessions').setup()

-- mini.snippets ─ Snippet management and expansion
-- require('mini.snippets').setup()

-- mini.splitjoin ─ Split/join arguments, tables, arrays (gS to split, gJ to join)
-- require('mini.splitjoin').setup()

-- mini.starter ─ Configurable start screen with sections and items
require('mini.starter').setup()

-- mini.statusline ─ Lightweight statusline with built-in LSP/git sections
require('mini.statusline').setup()

-- mini.surround ─ Add (sa), delete (sd), replace (sr) surrounding characters
require('mini.surround').setup()

-- mini.tabline ─ Buffer list displayed in the tabline
-- require('mini.tabline').setup()

-- mini.test ─ Testing framework for authoring Neovim plugin test suites
-- require('mini.test').setup()

-- mini.trailspace ─ Highlight trailing whitespace; MiniTrailspace.trim() to remove
-- require('mini.trailspace').setup()

-- mini.visits ─ Track and jump to frequently/recently visited files
require('mini.visits').setup()

-- ──────────────────────────────────────────────
-- THEME [N/A]
-- ──────────────────────────────────────────────

-- ──────────────────────────────────────────────
-- KEYMAPS
-- ──────────────────────────────────────────────

vim.g.mapleader = " "

vim.keymap.set("n", "t", function()
    local minifiles = require("mini.files")
    if not minifiles.close() then
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      minifiles.open(path)
  end
end, { desc = "toggle mini files" })

-- ──────────────────────────────────────────────
-- AUTOCMDS
-- ──────────────────────────────────────────────

local show_dotfiles = true
local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})
