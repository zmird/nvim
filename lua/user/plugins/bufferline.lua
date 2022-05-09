local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

bufferline.setup{
	options = {
		offsets = {{filetype = "NvimTree", text = "", padding = 1}},
		buffer_close_icon = icons.cross,
		modified_icon = icons.dot,
		close_icon = icons.error,
		left_trunc_marker = icons.arrowLeftCircle,
		right_trunc_marker = icons.arrowRightCircle,
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		show_tab_indicators = true,
		enforce_regular_tabs = false,
		view = "multiwindow",
		show_buffer_close_icons = true,
		separator_style = "thin",
		diagnostics = false,
		diagnostics_update_in_insert = false,
		-- mappings = "true"
	}
}