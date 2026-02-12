-- JSON/JSONC language server (vscode-langservers-extracted)
-- Install: brew install vscode-langservers-extracted
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
}
