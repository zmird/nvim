local M = {}

M.OpenAgenda = function ()
  require('orgmode').action('agenda.prompt')
end

M.OpenCapture = function ()
  require('orgmode').action('capture.prompt')
end

return M
