-- Treat specific JSON files that support comments as JSONC
vim.filetype.add({
  filename = {
    ['devbox.json'] = 'jsonc',
  },
})
