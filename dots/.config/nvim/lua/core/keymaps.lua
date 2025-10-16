local function map(mode, lhs, rhs, desc, bufnr)
  local opts = {}
  opts.noremap = true
  opts.silent = true
  if desc ~= nil then opts.desc = desc end
  if bufnr ~= nil then opts.buffer = bufnr end
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Search
map('n', '<Esc>', ':noh<CR><Esc>')

-- Pack
map('n', '<leader>p', '', ' Packages')
map('n', '<leader>pu', ':lua vim.pack.update()<CR>', ' Update')
map('n', '<leader>pi', ':lua vim.pack.get()<CR>', ' Info')
map('n', '<leader>pm', ':Mason<cr>', ' Mason')

-- Telescope
map('n', '<leader>f', '', ' Find')
map('n', '<leader>ff', ':Telescope find_files<CR>', '󰱼 Find Files')
map('n', '<leader>fw', ':Telescope live_grep<CR>', '󱎸 Find Words')
map('n', '<leader>fF', ':lua require("plugins.telescope").find_all_files()<CR>', '󱈆 Find All Files')
map('n', '<leader>fW', ':lua require("plugins.telescope").find_all_words()<CR>', '󰨼 Find All Words')
map('n', '<leader>fb', ':Telescope buffers<CR>', '󰩉 Find Buffer')
map('n', '<leader>fo', ':Telescope oldfiles<CR>', '󰨭 Find Old')
map('n', '<leader>fm', ':Telescope marks<CR>', '󱤇 Find Marks')

-- Buffers
map('n', '<leader>b', '', '󰓩 Buffers')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>c', ':bd<CR>')
map('n', '<leader>W', ':SudaWrite<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<M-w>', ':w<CR>')
map('n', '<M-W>', ':SudaWrite<CR>')
map('n', '<M-q>', ':q<CR>')
for i = 1, 9 do map('n', '<A-' .. i .. '>', ':lua require("bufferline").go_to(' .. i .. ', true)<CR>') end
map('n', "<M-'>", ':BufferLineCycleNext<CR>')
map('n', '<A-J>', ':BufferLineMovePrev<CR>')
map('n', '<A-K>', ':BufferLineMoveNext<CR>')
map('n', '<leader>b[', ':BufferLineCyclePrev<CR>', ' Prev Buffer')
map('n', '<leader>b]', ':BufferLineCycleNext<CR>', ' Next Buffer')
map('n', '<leader>bj', ':BufferLineMovePrev<CR>', ' Move Left')
map('n', '<leader>bk', ':BufferLineMoveNext<CR>', ' Move Right')
map('n', '<leader>bw', ':w<CR>', '󰆓 Write')
map('n', '<leader>bq', ':q<CR>', ' Close')
map('n', '<leader>bW', ':w!<CR>', '󰽂 Force Write')
map('n', '<leader>bQ', ':q!<CR>', ' Force Close')
map('n', '<leader>bx', ':BufferLineCloseOthers<CR>', ' Close Others')
map('n', '<leader>ba', ':lua require("sllm").toggle_llm_buffer()<CR>', ' Toggle LLM')

-- LLM
map('n', '<leader>a', '', ' LLM')
map('n', '<leader>ac', '', ' Add Context')
map('n', '<leader>aa', ':lua require("sllm").ask_llm()<CR>', '󰍡 Ask')
map('n', '<leader>an', ':lua require("sllm").new_chat()<CR>', '󱥁 New Chat')
map('n', '<leader>am', ':lua require("sllm").select_model()<CR>', '󰛱 Select Model')
map('n', '<leader>ar', ':lua require("sllm").reset_context()<CR>', '󰘓 Reset Context')
map('n', '<leader>ab', ':lua require("sllm").toggle_llm_buffer()<CR>', '󰓩 Toggle Buffer')
map('n', '<leader>acf', ':lua require("sllm").add_file_to_ctx()<CR>', ' File')
map('n', '<leader>acu', ':lua require("sllm").add_url_to_ctx()<CR>', '󰌷 URL')
map('n', '<leader>acv', ':lua require("sllm").add_sel_to_ctx()<CR>', '󰱼 Selection')
map('n', '<leader>acd', ':lua require("sllm").add_diag_to_ctx()<CR>', '󰒉 Diag')
map('n', '<leader>acc', ':lua require("sllm").add_cmd_out_to_ctx()<CR>', ' Cmd Out')
map('n', '<leader>act', ':lua require("sllm").add_tool_to_ctx()<CR>', '󱁤 Tool')
map('n', '<leader>acF', ':lua require("sllm").add_func_to_ctx()<CR>', '󰊕 Function')

-- Window
map('n','q', function () local b=vim.tbl_filter(function(buf) return vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf)~="" end,vim.api.nvim_list_bufs()) if #b>1 then vim.cmd("bdelete") else vim.cmd("q") end end)
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '\\', function() vim.cmd((vim.api.nvim_win_get_width(0) < vim.o.columns) and 'split' or 'vsplit') end)
map('n', '<C-\\>', function() vim.cmd((vim.api.nvim_win_get_width(0) < vim.o.columns) and 'wincmd K' or 'wincmd L') end)

-- NeoTree
map('n', '<leader>e', '', ' NeoTree')
map('n', '<M-e>', ':Neotree filesystem toggle<CR>')
map('n', '<leader>ee', ':Neotree filesystem toggle<CR>', ' Toggle')
map('n', '<leader>et', ':Neotree filesystem reveal<CR>', ' Current file')
map('n', '<leader>eb', ':Neotree buffers toggle<CR>', '󱦞 Buffers')
map('n', '<leader>es', ':Neotree git_status toggle<CR>', ' Git Status')

-- LSP
map('n', '<leader>l', '', ' LSP')
map('n', '<leader>lI', ':lua vim.lsp.buf.hover()<cr>', '󰈙 Documentation')
map('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>', '󰦨 Definition')
map('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>', '󰩳 Declaration')
map('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>', ' Implementation')
map('n', '<leader>lx', ':lua vim.lsp.buf.references()<cr>', ' References')
map('n', '<leader>lk', ':lua vim.lsp.buf.signature_help()<cr>', '󱧃 Signature')
map('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>', '󰑕 Rename')
map('n', '<leader>lf', ':lua vim.lsp.buf.format({ async = true })<cr>', '󰉡 Format')
map('n', '<leader>lA', ':lua vim.diagnostic.open_float()<cr>', ' Diag. Float')
map('n', '<leader>ll', ':lua vim.diagnostic.setloclist()<cr>', ' Diag. List')
map('n', '<leader>lm', ':Mason<cr>', ' Mason')
map({ 'n', 'v' }, '<leader>la', ':lua vim.lsp.buf.code_action()<cr>', ' Actions')
map('n', '<F2>', ':lua vim.diagnostic.jump({count = 1})<cr>')
