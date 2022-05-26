local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null-ls not found!")
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup({
  debug = false,
  sources = {
    formatting.autopep8, -- for python
    formatting.stylua, -- for lua
    -- formatting.clang_format, -- for cpp
    -- formatting.gofmt, -- for golang
    -- diagnostics.flake8,
    formatting.prettier.with({
      -- 比默认少了 markdown
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
      },
      prefer_local = "node_modules/.bin",
    }),
    completion.spell,

    -- code actions ---------------------
    code_actions.gitsigns,
    code_actions.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",

  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
    -- NOTE: 如果想要禁止某种语言在save时format，可以添加判定
    -- if client.name == "xxx" then
    --
    -- end
    -- auto format when save file
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
})
