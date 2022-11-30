local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    -- https://github.com/danmar/cppcheck
    -- Run `pacman -S cppcheck`
    null_ls.builtins.diagnostics.cppcheck,
    -- https://github.com/PyCQA/flake8
    -- Run `pip install flake8`
    null_ls.builtins.diagnostics.flake8.with {
      prefer_local = ".venv/bin",
    },
    -- https://github.com/PyCQA/pylint
    -- Run `pip install pylint`
    null_ls.builtins.diagnostics.pylint.with {
      prefer_local = ".venv/bin",
    },
    -- https://www.kernel.org/doc/html/latest/process/clang-format.html
    -- Comes with `pacman -S clang`
    -- <ELSE> Run `npm install -g clang-format`
    null_ls.builtins.formatting.clang_format.with {
      extra_args = { '-style', '{BasedOnStyle: LLVM, IndentWidth: 4}' },
    },
    -- https://github.com/PyCQA/isort
    -- Run `pip install isort`
    null_ls.builtins.formatting.isort.with {
      prefer_local = ".venv/bin",
    },
    -- https://github.com/google/yapf
    -- Run `pip install yapf`
    null_ls.builtins.formatting.yapf.with {
      prefer_local = ".venv/bin",
    },
  },
}
