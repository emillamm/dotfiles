-- Indentation settings
vim.bo.expandtab = true    -- Use spaces instead of tabs
vim.bo.shiftwidth = 2      -- Number of spaces for auto-indent
vim.bo.tabstop = 2         -- Number of spaces a tab counts for
vim.bo.softtabstop = 2     -- Number of spaces for soft tabs
--
-- Attach an autocmd for formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = 0,
  callback = function()
    vim.lsp.buf.format()
  end,
})
