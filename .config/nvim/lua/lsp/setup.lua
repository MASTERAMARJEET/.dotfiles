local M = {}

local diag_signs = require("utils").diagnostics_signs
-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = diag_signs.error },
    { name = "DiagnosticSignWarn", text = diag_signs.warn },
    { name = "DiagnosticSignHint", text = diag_signs.hint },
    { name = "DiagnosticSignInfo", text = diag_signs.info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
    )
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = {
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = "rounded",
    }
  )
end

return M