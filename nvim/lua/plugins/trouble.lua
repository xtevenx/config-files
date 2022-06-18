vim.api.nvim_create_autocmd('BufLeave', {
  callback = function()
    if vim.bo.filetype == 'Trouble' then
      vim.cmd('TroubleClose')
    end
  end,
})
