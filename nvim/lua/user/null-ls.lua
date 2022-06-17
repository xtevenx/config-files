local null_ls = require('null-ls')

null_ls.setup {
  on_attach = require('aerial').on_attach,
  sources = {
    -- https://github.com/danmar/cppcheck
    -- Consult README in the repository
    null_ls.builtins.diagnostics.cppcheck,
    -- https://github.com/PyCQA/flake8
    -- Run `pip install flake8`
    null_ls.builtins.diagnostics.flake8,
    -- https://github.com/amperser/proselint
    -- Run `pip install proselint`
    null_ls.builtins.diagnostics.proselint, -- this is a joke :)
    -- https://github.com/PyCQA/pylint
    -- Run `pip install pylint`
    null_ls.builtins.diagnostics.pylint,
    -- https://www.kernel.org/doc/html/latest/process/clang-format.html
    -- Run `npm install -g clang-format`
    null_ls.builtins.formatting.clang_format.with {
      extra_args = { '-style', '{BasedOnStyle: LLVM, IndentWidth: 4}' },
    },
    -- https://github.com/PyCQA/isort
    -- Run `pip install isort`
    null_ls.builtins.formatting.isort,
    -- https://github.com/google/yapf
    -- Run `pip install yapf`
    null_ls.builtins.formatting.yapf,
  },
}

-- Keymaps
vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>')

local choose_nls = { 'c', 'cpp' }
for _, ft in ipairs(choose_nls) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      vim.keymap.set('n', '<leader>f', "<cmd>lua vim.lsp.buf.format({ name = 'null-ls' })<CR>", { buffer = true })
    end,
  })
end
