local ok, smartsplits = pcall(require, "smart-splits")
if not ok then return end

smartsplits.setup()

vim.keymap.set('n', '<C-Left>',  smartsplits.resize_left)
vim.keymap.set('n', '<C-Down>',  smartsplits.resize_down)
vim.keymap.set('n', '<C-Up>',    smartsplits.resize_up)
vim.keymap.set('n', '<C-Right>', smartsplits.resize_right)

vim.keymap.set('n', '<C-h>', smartsplits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smartsplits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smartsplits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smartsplits.move_cursor_right)
