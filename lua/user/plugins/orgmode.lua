local orgmode_status_ok, orgmode = pcall(require, "orgmode")
if not orgmode_status_ok then
  return
end

local orgbullets_status_ok, orgbullets = pcall(require, "org-bullets")
if not orgbullets_status_ok then
  return
end

orgmode.setup {
  org_agenda_files = {"~/Notes/**/*"},
  org_default_notes_file = '~/Notes/org/index.org',
  org_capture_templates = {
    n = { 
      description = 'Note',
      template = '%^{TITLE}\n  %U\n\n%?' 
    } 
  },
}
orgmode.setup_ts_grammar()

orgbullets.setup {
  concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
  symbols = {
    -- headlines can be a list
    headlines = { "◉", "○", "✸", "✿" },
    checkboxes = {
      half = { "", "OrgTSCheckboxHalfChecked" },
      done = { "✓", "OrgDone" },
      todo = { "˟", "OrgTODO" },
    },
  }
}
