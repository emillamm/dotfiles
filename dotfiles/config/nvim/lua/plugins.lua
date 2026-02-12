local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Plugin declarations
add('skywind3000/asyncrun.vim')
add('kana/vim-arpeggio')
add('neovim/nvim-lspconfig')
add('echasnovski/mini.icons')
add('echasnovski/mini.pick')
add('echasnovski/mini.statusline')
add('echasnovski/mini.completion')
add('echasnovski/mini.files')
add('echasnovski/mini.animate')
add('echasnovski/mini.snippets')
add('echasnovski/mini.extra')
add('echasnovski/mini.visits')
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

-- Immediate setup
now(function()
  require('mini.icons').setup()
  require('mini.extra').setup()
  require('mini.visits').setup()
  require('mini.files').setup()
  require('mini.completion').setup()

  require('mini.pick').setup({
    mappings = {
      move_down = '<C-j>',
      move_up = '<C-k>',
    }
  })

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

        return MiniStatusline.combine_groups({
          { hl = mode_hl,                  strings = { mode } },
          { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=',
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, location } },
        })
      end,
    }
  })

  -- LSP servers
  vim.lsp.enable('gopls')
  vim.lsp.enable('kotlin_language_server')
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('cue')

  -- Diagnostics
  vim.diagnostic.config({
    signs = false,
    virtual_text = false,
    underline = true,
  })

  -- Treesitter highlighting and indentation
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'lua' },
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end)

-- Deferred setup
later(function()
  require('mini.animate').setup({
    scroll = { enable = false },
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
end)
