local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
  return
end

treesitter.setup {
	ensure_installed = {"c", "cpp", "css", "dart", "go", "html", "java",
		"javascript", "json", "lua", "regex", "rust", "scss", "tsx",
		"typescript", "python", "yaml"},
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true },
}