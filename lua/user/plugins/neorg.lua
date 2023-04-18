local neorg_status_ok, neorg = pcall(require, "neorg")
if not neorg_status_ok then
  return
end

neorg.setup{
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.norg.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/Notes",
        },
      },
    },
  },
}
