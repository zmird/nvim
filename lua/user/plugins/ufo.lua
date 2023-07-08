local ufo_status_ok, ufo = pcall(require, "ufo")
if not ufo_status_ok then
  return
end

ufo.setup({
  open_fold_hl_timeout = 0,
  close_fold_kinds = {'imports', 'comment'},
  preview = {
    win_config = {
        border = {'', '─', '', '', '', '─', '', ''},
        winhighlight = 'Normal:Folded',
        winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>'
    }
  },
  provider_selector = function()
      return {'treesitter', 'indent'}
  end
})
