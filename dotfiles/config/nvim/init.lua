vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>q', ':call ToggleQuickfixList()<CR>')
vim.keymap.set('n', '<leader>l', ':call ToggleLocationList()<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')
vim.keymap.set('v', '<leader>c', '"*y<CR>')

-- Make prg
vim.opt.makeprg = './.make'

-- Disable swap file
vim.opt.swapfile = false

-- Use undo
vim.opt.undofile = true

-- Don't allow hidden edited buffers
vim.opt.hidden = false

-- Buffers
vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[B', ':bfirst<CR>', { silent = true })
vim.keymap.set('n', ']B', ':blast<CR>', { silent = true })

-- Quickfix and location
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']l', ':lnext<CR>')
vim.keymap.set('n', '[l', ':lprev<CR>')

vim.keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { silent = true })

vim.keymap.set('n', 'Y', 'yy')

-- Navigational leader shortcuts
vim.keymap.set('n', '<Space>f', 'F', { silent = true })
vim.keymap.set('n', '<Space>t', 'T', { silent = true })
vim.keymap.set('n', '<Space>d', 'D', { silent = true })
vim.keymap.set('n', '<Space>4', '$', { silent = true })
vim.keymap.set('n', '<Space>5', '%', { silent = true })
vim.keymap.set('n', '<Space>6', '^', { silent = true })
vim.keymap.set('n', '<Space>8', '*', { silent = true })

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"


-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

--local add = MiniDeps.add
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

require('colors').setup(add)
add('skywind3000/asyncrun.vim')
add('echasnovski/mini.icons')
add('echasnovski/mini.pick')
add('echasnovski/mini.statusline')
add('echasnovski/mini.completion')
add('echasnovski/mini.files')
add('echasnovski/mini.animate')
add('echasnovski/mini.snippets')
add('echasnovski/mini.extra')
add('echasnovski/mini.visits')
add('milkypostman/vim-togglelist')
add('kana/vim-arpeggio')
add('neovim/nvim-lspconfig')
add({ source = 'nvim-treesitter/nvim-treesitter', hooks = { post_checkout = function() vim.cmd('TSUpdate') end } })

local escape = "<Esc>:nohlsearch<CR>"
vim.fn['arpeggio#map']('n', '', 0, 'fw', '<C-W>')
vim.fn['arpeggio#map']('i', '', 0, 'jk', '<Esc>')
vim.fn['arpeggio#map']('n', '', 0, 'io', ':w<CR>')
vim.fn['arpeggio#map']('n', '', 0, 'ui', ':w<CR>:AsyncRun -program=make<CR>')



-- Lualine
--require('lualine').setup {
--  options = {
--    icons_enabled = true,
--  },
--  sections = {
--    lualine_x = {
--      {
--        'g:asyncrun_status',
--        fmt = function(str)
--          return vim.g.asyncrun_status or ''
--        end
--      }
--    }
--  },
--}

-- LSP key mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)


-- Lspconfig
local lspconfig = require('lspconfig')


-- Lspconfig with gopls
lspconfig.gopls.setup {
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
    },
  },
}

lspconfig.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

require('mini.icons').setup()
require('mini.statusline').setup()
require('mini.files').setup()
require('mini.extra').setup()
require('mini.visits').setup()
require('mini.completion').setup({
  --vim.opt.completeopt:append('fuzzy')
})
require('mini.animate').setup({
  scroll = {
    enable = false
  }
})
require('mini.pick').setup({
  mappings = {
    move_down = '<C-j>',
    move_up = '<C-k>',
  }
})

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { silent = true })

-- Pick files
vim.keymap.set('n', '<leader>f', function() MiniPick.builtin.files({ tool = "rg" }) end)
-- Pick buffers
vim.keymap.set('n', '<leader>b', function() MiniPick.registry.buffers({ tool = "rg" }) end)
-- Pick "visits" and exclude current buffer
function pick(recency)
  local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p')
  MiniExtra.pickers.visit_paths({
    filter = function(path_data)
      return path_data.path ~= current_path
    end,
    sort = MiniVisits.gen_sort.default({ recency_weight = recency }),
  })
end

vim.keymap.set('n', '<leader>v', function()
  return pick(0.5)
end)
vim.keymap.set('n', '<leader>g', function()
  return pick(1.0)
end)

require('mini.statusline').setup({
  content = {

    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
      --local asyncrun_status = vim.g.asyncrun_status or ''

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        --{ hl = 'MiniStatuslineFilename', strings = { asyncrun_status } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  }
})

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    gen_loader.from_lang(),
  },
  mappings = {
    expand = '<C-j>',
    jump_next = '<Esc>',
    jump_prev = '<C-h>',
    stop = '<C-c>',
  },
})


-- Configure diagnostics to disable signs and virtual_text by default
vim.diagnostic.config({
  signs = false,
  virtual_text = false,
  underline = true,
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { "go", "lua" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  }
})

-- Show diagnostics temporarily (until cursor moves)
local function show_diagnostics_until_cursor_moves()
  vim.diagnostic.config({ virtual_text = true })
  local group = vim.api.nvim_create_augroup("TempDiagnostics", { clear = true })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    once = true,
    callback = function()
      vim.diagnostic.config({ virtual_text = false })
      vim.api.nvim_del_augroup_by_id(group)
    end,
  })
end

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = false })
  vim.schedule(function()
    show_diagnostics_until_cursor_moves()
  end)
end, { desc = "Go to previous diagnostic & show inline temporarily" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = false })
  vim.schedule(function()
    show_diagnostics_until_cursor_moves()
  end)
end, { desc = "Go to next diagnostic & show inline temporarily" })

vim.keymap.set("n", "<leader>d", function()
  show_diagnostics_until_cursor_moves()
end, { desc = "Show inline diagnostic temporarily" })
