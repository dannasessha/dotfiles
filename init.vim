" --- // experimental features // ---- "
"
"  map jj to exit insert mode
inoremap jj <ESC>

" remap tab switches crtl (or shift) + direction.
"nnoremap <C-Left> gT 
"nnoremap <C-Right> gt 
nnoremap <S-Left> gT 
nnoremap <S-Right> gt 

" remap window focus to tab key in normal mode
nnoremap <C-i> <C-w><C-w>
" more specfic window focus 
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" retool ctrl_ left.right.up.down to move between windows?
nnoremap <C-Up> <C-w>k 
nnoremap <C-Down> <C-w>j 
nnoremap <C-Right> <C-w>l 
nnoremap <C-Left> <C-w>h 

" in the words of grr DOOM DOOM DOOM DOOM
"nnoremap <S-a> <C-w>h
"nnoremap <S-w> <C-w>k
"nnoremap <S-d> <C-w>l
"nnoremap <S-s> <C-w>j
"nnoremap <C-a> <C-w>h
"nnoremap <C-w> <C-w>k
"nnoremap <C-d> <C-w>l
"nnoremap <C-s> <C-w>j

command Q q
command W w

" leader /shortcut key to `'`
let mapleader = "'"

" polyglot suggests this.
set nocompatible

" // ---- Plugins ---- // "

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/pack/')
    " using (apparently) junegunn vim-plug 
    
    " experimental clang-format megr
    Plug '~/backport-clang'

    "" for testing
    Plug 'https://github.com/junegunn/vader.vim'

    " Declare the list of plugins.
    " rust.vim provides (3rd party) checker for syntastic.
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/vim-syntastic/syntastic'

    "Plug octol/vim-cpp-enhanced-highlight
    "Plug 'neovim/nvim-lspconfig'   " ... gateway to lsp...?
    "Plug 'https://github.com/ycm-core/YouCompleteMe' 
    "Plug 'https://github.com/racer-rust/vim-racer'

    Plug 'https://github.com/mhinz/vim-grepper'
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'https://github.com/sheerun/vim-polyglot'
    " Plug 'https://github.com/rhysd/vim-clang-format.git'
    " 'highly recommended by vim-clang-format 
    "Plug 'https://github.com/kana/vim-operator-user'

    "" Use deoplete.
    let g:deoplete#enable_at_startup = 1

    " For Codequery
    "Unite is a prerequisite for codequery. from github: The unite or unite.vim plug-in can search and display information 
    "from arbitrary sources like files, buffers, recently used files or registers....
    Plug 'https://github.com/Shougo/unite.vim'
    " Codequery
    Plug 'devjoe/vim-codequery'
    " enabling ack-from-vim, with enhanced results list... 
    Plug 'mileszs/ack.vim'

    " List ends here. Plugins become visible to Vim after this call.
call plug#end()

autocmd BufWritePre *.rs :RustFmt

set number
"highlight LineNr ctermbg=black cterm=strikethrough
"highlight LineNr cterm=standout 
set foldmethod=syntax
" set colorcolumn=80
set tabstop=4
"set shiftwidth=4
set shiftwidth=2
set expandtab

" cool statusline with modificiation [+]
hi ModStatus ctermbg=White ctermfg=Red
set statusline=%F::%#ModStatus#%m%#StatusLine#::{%p%%,%l,%c}

" syntastic 
" 'suggestions for beginners that is not default':
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_vim_checkers = ['vint']

"autocmd BufWritePre *.c :ClangFormat
"autocmd BufWritePre *.h :ClangFormat
"autocmd BufWritePre *.cpp :ClangFormat

" notes towards LSP - might only be for nightly
" thanks to yorickpeterse
" Rust {{{1
" let g:rust_recommended_style = 0

" LSP {{{2
"map <silent> <leader>h :lua vim.lsp.buf.hover()<CR>
"map <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
"map <silent> <leader>d :lua vim.lsp.buf.definition()<CR>
"map <silent> <leader>i :lua vim.lsp.buf.references()<CR>
"map <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>

syntax on

" for exercism easy-testing with vader, using :Test from
" .vim or .vader files.

function! s:exercism_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()

