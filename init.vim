call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Airline
Plug 'vim-airline/vim-airline'

" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-clang'

" Neomake - Async compilation and syntax checking
Plug 'neomake/neomake'

" Better terminal
" Commands - Term, VTerm
Plug 'mklabs/split-term.vim'

" Auto open brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Comment toggling
" Keys - gc
Plug 'tomtom/tcomment_vim'

" Snipping - Automatic completion of commonly typed things (class, if, for)
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Nerdtree - Nice directory visualizer
Plug 'scrooloose/nerdtree'

" LLDB debugger
Plug 'dbgx/lldb.nvim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Might want in the future
" tpope/vim-surround For surrounding words with anything ("")
" airblade/vim-gitgutter For getting notifications which lines you've changed in a git repo

call plug#end()

" Misc -----------------------------------------------
syntax enable
set termguicolors
tnoremap <Esc> <C-\><C-n>				"For escaping out of the terminal
set number
set relativenumber
set incsearch							"Start searching immediately
set clipboard+=unnamedplus				"Copy to clipboard by default
set tabstop=4 shiftwidth=4
set nowrap
set encoding=utf8						"Needed to show glyphs
noremap <silent> <c-c> :noh<cr><esc>	"Remove search highlighting when hitting ctrl-c

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Theme -----------------------------------------------
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'
" set background=dark
colorscheme OceanicNext

" Deoplete -----------------------------------------------
set completeopt-=preview		"Gets rid of the scratch pad thing
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

" Neomake -----------------------------------------------
call neomake#configure#automake('nw', 750)

" Ultisnips -----------------------------------------------
let g:UltiSnipsSnippetsDir='/home/alex/.vim/plugged/vim-snippets/UltiSnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit='vertical'

" Nerdtree -----------------------------------------------
" Start automatically if no file specified or a folder is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close if nerdtree is the only open windows
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1

" LLDB -----------------------------------------------
nmap <M-b> <Plug>LLBreakSwitch
