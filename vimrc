call plug#begin()
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise' 
" Plug 'ervandew/supertab'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'vim-ruby/vim-ruby'
Plug 'sheerun/vim-polyglot'
Plug 'skwp/greplace.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'github/copilot.vim'
call plug#end()

" Show current filename always
set laststatus=2

" Use the theme imported above
set bg=dark
colorscheme jellybeans 

filetype plugin on
set omnifunc=syntaxcomplete@Complete

nmap 0 ^

" Code linter and fixer to use in order
let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}

" save the swapfiles to a separate location
set directory=$TMPDIR//
set backupdir=$TMPDIR//

" Use the space key as our leader. Put this near the top of your vimrc
let mapleader = "\<Space>""

map <leader>so :source $MYVIMRC<cr>
imap <C-s> <esc>:w<cr>
imap jk <esc>
imap kj <esc>
nmap <leader>d :put =strftime('%Y-%m-%d')i<cr>

" Edit another file in the same directory as the current file
" " uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>i mmgg=G`m
map <Leader>gw :!git add . && git commit -m 'WIP' && git push<cr>
map <Leader>pi :PlugInstall<cr>
map <Leader>pu :PlugUpdate<cr>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>h :nohlsearch<CR>
nnoremap <C-Del> :call delete(expand('%'))<CR>

" Show the current date in the format YYYY-MM-DD
map <leader>d :put =strftime('date: %Y-%m-%d')<CR>

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number
" set nowrap
set ignorecase smartcase
set autoindent
set smarttab
set showmatch
set autoread
set nocompatible
set incsearch
set hlsearch

" Highlight breakpoints
syn keyword Breakpoints binding
hi Breakpoints guifg=Blue ctermfg=Blue term=bold

" Use Silver Searcher instead of grep
set grepprg=ag

" fuzzy find files and text
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-p> :Files<Cr>
" show at the bottom
let g:fzf_layout = { 'down': '40%' }
nnoremap <C-q> :Ag<cr>

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Default directory for swp & tmp files 
" set directory=.,$TEMP
set directory^=$HOME/.vim/swap//

set nofoldenable " Say no to code folding...

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

" Rails
" Edit the db/schema.rb Rails file in a split
nmap <leader>sc :split db/schema.rb<cr>

" Ignore This
set wildignore+=tmp/**

" ========================================================================
" " Ruby stuff
" ========================================================================
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0

syntax on                 " Enable syntax highlighting

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml,yml setlocal ai sw=2 sts=2 et
	autocmd FileType ruby,eruby,yaml,yml setlocal path+=lib
	autocmd FileType ruby,eruby,yaml,yml setlocal colorcolumn=80
	" Make ?s part of words
	autocmd FileType ruby,eruby,yaml,yml setlocal iskeyword+=?
	" yml fix
	autocmd FileType yml,yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END

augroup vimResized
	" automatically rebalance windows on vim resize
	autocmd VimResized * :wincmd =
augroup END

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

augroup markdown
	autocmd!
	autocmd filetype markdown set wrap
augroup end
