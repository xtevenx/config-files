local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    -- https://github.com/danmar/cppcheck
    -- Can install with pacman.
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
    -- Can install with pacman.
    null_ls.builtins.formatting.clang_format.with {
      extra_args = { '-style', '{BasedOnStyle: LLVM, IndentWidth: 4}' },
    },
    -- https://github.com/PyCQA/isort
    null_ls.builtins.formatting.isort.with {
      prefer_local = '.venv/bin',
    },
    -- https://github.com/google/yapf
    null_ls.builtins.formatting.yapf.with {
      prefer_local = '.venv/bin',
    },
  },
}
