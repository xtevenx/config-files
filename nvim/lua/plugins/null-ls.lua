local null_ls = require('null-ls')

null_ls.setup {
   sources = {
      -- https://github.com/danmar/cppcheck
      null_ls.builtins.diagnostics.cppcheck,
      -- https://github.com/charliermarsh/ruff/
      null_ls.builtins.diagnostics.ruff.with {
         extra_args = {
            '--select', 'A',
            '--select', 'B',
            '--select', 'C',
            '--select', 'E',
            '--select', 'F',
            '--select', 'I001',
            '--select', 'ICN001',
            '--select', 'N',
            '--select', 'Q',
            '--select', 'RET',
            '--select', 'UP',
            '--select', 'YTT',
         },
         prefer_local = '.venv/bin',
      },
      -- https://www.kernel.org/doc/html/latest/process/clang-format.html
      null_ls.builtins.formatting.clang_format.with {
         extra_args = { '-style', '{BasedOnStyle: LLVM, IndentWidth: 4}' },
      },
      -- https://github.com/prettier/prettier
      null_ls.builtins.formatting.prettier.with {
         extra_args = { '--single-quote' },
      },
      -- https://github.com/charliermarsh/ruff/
      null_ls.builtins.formatting.ruff.with {
         extra_args = {
            '--select', 'I001',
         },
         prefer_local = '.venv/bin',
      },
      -- https://github.com/google/yapf
      -- depends on: python-tomli
      null_ls.builtins.formatting.yapf.with {
         prefer_local = '.venv/bin',
      },
   },
}
