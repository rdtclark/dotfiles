call plug#begin()
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise' 
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
Plug 'vimwiki/vimwiki'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'TabbyML/vim-tabby'
call plug#end()

" Plug 'github/copilot.vim'

" --- LSP Configuration ---
lua << EOF
-- LSP key mappings
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- Jump to definition
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- Other useful mappings
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- docs
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- get references
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	end,
})

-- Tab completion setup with TabbyML compatibility
local cmp = require('cmp')
cmp.setup({
mapping = {
	['<Tab>'] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	    	cmp.select_next_item()
	    else
	    	fallback() -- TabbyML fallback
	    end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<Esc>'] = cmp.mapping.close(),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
})

-- Enable LSP completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Ruby LSP
require'lspconfig'.ruby_lsp.setup{
	capabilities = capabilities
}

-- TypeScript LSP
require'lspconfig'.ts_ls.setup{
	capabilities = capabilities,
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_dir = require('lspconfig').util.root_pattern("package.json", "tsconfig.json", ".git"),
}
EOF

" --- TabbyML Configuration ---
let g:tabby_agent_start_command = ["npx", "tabby-agent", "--stdio"]
let g:tabby_inline_completion_trigger = "auto"
let g:tabby_inline_completion_keybinding_accept = "<Tab>"
let g:tabby_inline_completion_keybinding_trigger_or_dismiss = "<C-\>"

" vimwiki
let g:vimwiki_list = [{'path': '~/k/', 'syntax': 'markdown', 'ext': 'md', 'diary_rel_path': 'Notes'}]

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

" fuzzy find files
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-p> :Files<Cr>
" fuzzy find within files
nnoremap <C-q> :Ag<cr>
" show at the bottom
let g:fzf_layout = { 'down': '40%' }

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

" ========================================================================
" TypeScript/React stuff
" ========================================================================
augroup typescript
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType typescript,typescriptreact,javascript,javascriptreact setlocal ai sw=2 sts=2 et
	autocmd FileType typescript,typescriptreact,javascript,javascriptreact setlocal colorcolumn=100
	" Enable JSX syntax in .tsx and .jsx files
	autocmd FileType typescriptreact,javascriptreact setlocal syntax=javascript.jsx
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
