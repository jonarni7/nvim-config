local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  view = {
    width = 30,
    side = "left",
  },
}
