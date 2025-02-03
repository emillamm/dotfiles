-- Create an autocommand group for Go files
local group = vim.api.nvim_create_augroup("GoImports", { clear = true })
local util = require("vim.lsp.util")

-- Helper that silently checks for code actions of a certain kind
-- and applies them only if they exist.
local function apply_code_action_if_available(context)
  local params = util.make_range_params()
  params.context = context

  -- Synchronously request possible code actions
  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if not results or vim.tbl_isempty(results) then
    return
  end

  -- Check if any server returned any actual actions
  for _, server_result in pairs(results) do
    if server_result.result and #server_result.result > 0 then
      -- We found at least one code action
      vim.lsp.buf.code_action({
        context = context,
        apply = true,
      })
      break
    end
  end
end

-- Attach an autocmd for formatting + organize imports
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = 0,
  callback = function()
    -- First do a standard format
    vim.lsp.buf.format()

    -- Then attempt an organize imports action, if available
    apply_code_action_if_available({ only = { "source.organizeImports" } })
  end,
})
