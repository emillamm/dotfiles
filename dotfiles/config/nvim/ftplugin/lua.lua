-- Indentation settings
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Format on save
local group = vim.api.nvim_create_augroup("LuaFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = 0,
  callback = function()
    vim.lsp.buf.format()
  end,
})
