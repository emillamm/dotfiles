local group = vim.api.nvim_create_augroup("GoImports", { clear = true })

local function apply_code_action_if_available(context)
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" })
  if #clients == 0 then return end

  local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding)
  params.context = context

  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if not results or vim.tbl_isempty(results) then
    return
  end

  for _, server_result in pairs(results) do
    if server_result.result and #server_result.result > 0 then
      vim.lsp.buf.code_action({
        context = context,
        apply = true,
      })
      break
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = 0,
  callback = function()
    vim.lsp.buf.format()
    apply_code_action_if_available({ only = { "source.organizeImports" } })
  end,
})
