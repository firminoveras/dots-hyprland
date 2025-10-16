local ok, hop = pcall(require, "hop")
if not ok then return end

hop.setup()

local ok_hint, hop_hint = pcall(require, "hop.hint")
if not ok_hint then return end

local directions = hop_hint.HintDirection
vim.keymap.set('', 'f', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false }) end, { remap = true })
vim.keymap.set('', 'F', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false }) end, { remap = true })
