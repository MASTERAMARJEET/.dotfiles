local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local clear_autocmds = vim.api.nvim_clear_autocmds

local M = {}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(clients)
      -- filter out clients that you don't want to use
      return vim.tbl_filter(function(client)
        return client.name ~= "tsserver" and client.name ~= "sumneko_lua"
      end, clients)
    end,
    bufnr = bufnr,
  })
end
local format_on_save = augroup("format_on_save", { clear = true })
local function lsp_format_on_save(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    clear_autocmds({ group = "format_on_save", buffer = bufnr })
    autocmd("BufWritePre", {
      group = format_on_save,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

local lsp_doc_highlight_grp = augroup("lsp_document_highlight", {})
local function lsp_highlight_document(client, bufnr)
  if client.supports_method("textDocument/document_highlight") then
    clear_autocmds({
      group = lsp_doc_highlight_grp,
      buffer = bufnr,
    })
    autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      group = lsp_doc_highlight_grp,
    })
    autocmd("CursorMoved", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      group = lsp_doc_highlight_grp,
    })
  end
end

local function lsp_keymaps(bufnr)
  local load_keymaps = require("keymaps.helpers").load_keymaps
  local keymaps = require("keymaps.lsp")
  load_keymaps(keymaps, bufnr)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)
  lsp_format_on_save(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
