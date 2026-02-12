-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clipboard
vim.keymap.set('v', '<leader>c', '"*y<CR>')

-- Buffers
vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[B', ':bfirst<CR>', { silent = true })
vim.keymap.set('n', ']B', ':blast<CR>', { silent = true })

-- Quickfix and location list navigation
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']l', ':lnext<CR>')
vim.keymap.set('n', '[l', ':lprev<CR>')

-- Quickfix/location list toggle (replaces vim-togglelist)
local function toggle_qf()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 and win.loclist == 0 then
      vim.cmd('cclose')
      return
    end
  end
  vim.cmd('copen')
end

local function toggle_loc()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 and win.loclist == 1 then
      vim.cmd('lclose')
      return
    end
  end
  local ok = pcall(vim.cmd, 'lopen')
  if not ok then
    vim.notify('No location list', vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>q', toggle_qf)
vim.keymap.set('n', '<leader>l', toggle_loc)

-- Clear search highlighting
vim.keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { silent = true })

-- Yank line
vim.keymap.set('n', 'Y', 'yy')

-- Navigational leader shortcuts
vim.keymap.set('n', '<Space>f', 'F', { silent = true })
vim.keymap.set('n', '<Space>t', 'T', { silent = true })
vim.keymap.set('n', '<Space>d', 'D', { silent = true })
vim.keymap.set('n', '<Space>4', '$', { silent = true })
vim.keymap.set('n', '<Space>5', '%', { silent = true })
vim.keymap.set('n', '<Space>6', '^', { silent = true })
vim.keymap.set('n', '<Space>8', '*', { silent = true })

-- Arpeggio chords
vim.fn['arpeggio#map']('n', '', 0, 'fw', '<C-W>')
vim.fn['arpeggio#map']('i', '', 0, 'jk', '<Esc>')
vim.fn['arpeggio#map']('n', '', 0, 'io', ':w<CR>')
vim.fn['arpeggio#map']('n', '', 0, 'ui', ':w<CR>:AsyncRun -program=make<CR>')

-- LSP
local opts = { silent = true }
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

-- Mini.files toggle
local minifiles_toggle = function()
  if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { silent = true })

-- Mini.pick
vim.keymap.set('n', '<leader>f', function() MiniPick.builtin.files({ tool = "rg" }) end)
vim.keymap.set('n', '<leader>b', function() MiniPick.registry.buffers({ tool = "rg" }) end)

-- Mini.visits
local function pick_visits(recency)
  local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p')
  MiniExtra.pickers.visit_paths({
    filter = function(path_data)
      return path_data.path ~= current_path
    end,
    sort = MiniVisits.gen_sort.default({ recency_weight = recency }),
  })
end

vim.keymap.set('n', '<leader>v', function() pick_visits(0.5) end)
vim.keymap.set('n', '<leader>g', function() pick_visits(1.0) end)

-- Diagnostics navigation
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
  vim.diagnostic.jump({ count = -1, float = false })
  vim.schedule(function()
    show_diagnostics_until_cursor_moves()
  end)
end, { desc = "Go to previous diagnostic & show inline temporarily" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = false })
  vim.schedule(function()
    show_diagnostics_until_cursor_moves()
  end)
end, { desc = "Go to next diagnostic & show inline temporarily" })

vim.keymap.set("n", "<leader>d", function()
  show_diagnostics_until_cursor_moves()
end, { desc = "Show inline diagnostic temporarily" })
