local icons = require("user.icons")

vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_disable_statusline = true
vim.g.dashboard_custom_header = {"", "", "", "", ""}
vim.g.dashboard_custom_section = {
    a = {description = {icons.timer ..      ' Reload Last Session            SPC s l'}, command = 'SessionLoad'},
    b = {description = {icons.fileNoBg ..   ' Recently Opened Files          SPC f o'}, command = 'Telescope oldfiles'},
    d = {description = {icons.ribbonNoBg .. ' Jump to Bookmark               SPC f m'}, command = 'Telescope marks'},
    c = {description = {icons.folderNoBg .. ' Open Project                   SPC f p'}, command = 'Telescope project'},
    e = {description = {icons.search ..     ' Find File                      SPC f f'}, command = 'Telescope find_files'},
    g = {description = {icons.gears ..      ' Open Neovim Configuration      SPC f c'}, command = ':e ~/.config/nvim/init.lua'},
}

-- Display number of loaded plugins
vim.cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")
vim.api.nvim_exec([[
    let g:dashboard_custom_footer = ['Loaded '..packages..' packages']
]], false)
