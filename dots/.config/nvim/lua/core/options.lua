local opt = vim.opt

-- Visual
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = 'auto'
opt.winblend = 0
opt.pumblend = 0
opt.pumheight = 8
opt.fillchars = { eob = " " }

-- Ident
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8

-- Searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Behavior
opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 300
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.conceallevel = 0
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append "c"

-- Undodir
local undodir_path = os.getenv("HOME") .. "/.cache/nvim/undodir"
opt.undofile = true
opt.undodir = undodir_path
if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, "p")
end
