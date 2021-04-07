"found in ~/.config/nvim/

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/pack/')

" Declare plugins.
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/mhinz/vim-grepper'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Use deoplete.
let g:deoplete#enable_at_startup = 1
"Plug 'neovim/nvim-lspconfig'   " ... gateway to lsp, needs nightly
"Plug 'https://github.com/ycm-core/YouCompleteMe' 
"Plug 'https://github.com/racer-rust/vim-racer'

" Plugins become visible to Vim after this call.
call plug#end()

autocmd BufWritePre *.rs :RustFmt

" notes towards lsp, unachieved
" thanks to yorickpeterse
" Rust {{{1
" let g:rust_recommended_style = 0

" LSP {{{2
"map <silent> <leader>h :lua vim.lsp.buf.hover()<CR>
"map <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
"map <silent> <leader>d :lua vim.lsp.buf.definition()<CR>
"map <silent> <leader>i :lua vim.lsp.buf.references()<CR>
"map <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>

