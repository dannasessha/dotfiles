-- tab between windows, etc
vim.cmd [[
nnoremap <C-i> <C-w><C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
command Q q
command W w
]]

vim.o.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- cool statusline with modificiation [+]

--syntax on

