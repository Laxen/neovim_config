call plug#begin('~/.vim/plugged')

" Themes
" Plug 'morhetz/gruvbox'
" Plug 'mhartington/oceanic-next'
Plug 'kaicataldo/material.vim'

" Airline
Plug 'vim-airline/vim-airline'

" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-clang'

" Neomake - Async compilation and syntax checking
" Plug 'neomake/neomake'

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
" Plug 'dbgx/lldb.nvim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Might want in the future
" tpope/vim-surround For surrounding words with anything ("")
" airblade/vim-gitgutter For getting notifications which lines you've changed in a git repo

call plug#end()

" CScope --------------------------------------------
source ~/.config/nvim/cscope_maps.vim
set cscoperelative "Use relative paths based on the location of cscope.out

" Misc -----------------------------------------------
syntax enable
set termguicolors
tnoremap <Esc> <C-\><C-n>				"For escaping out of the terminal
set number
set norelativenumber
set incsearch							"Start searching immediately
set clipboard+=unnamedplus				"Copy to clipboard by default
set tabstop=4 shiftwidth=4
set nowrap
set encoding=utf8						"Needed to show glyphs
noremap <silent> <c-c> :noh<cr><esc>	"Remove search highlighting when hitting ctrl-c
set diffopt=vertical

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" Use max 80 columns
set tw=80

" Theme -----------------------------------------------
" Gruvbox
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'

" OceanicNext
" set background=dark
" colorscheme OceanicNext

" Material
set background=dark
let g:airline_theme = 'material'
let g:material_theme_style = 'palenight'
colorscheme material

" Neater folding --------------------------------------
function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()
highlight Folded guibg=base01 guifg=darkgrey
autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent! loadview

vmap zd zdgv

" Deoplete -----------------------------------------------
set completeopt-=preview		"Gets rid of the scratch pad thing
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

" Neomake -----------------------------------------------
" call neomake#configure#automake('nw', 750)

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
" nmap <M-b> <Plug>LLBreakSwitch

" Custom cscope init
" function! CSinit()
"   !cscope -Rb
"   cs add cscope.out
" endfunction
" command CSinit call CSinit()

" Finds the parent 'sources' directory, cd's to it, builds cscope
" cross-reference, removes all other cscope connections and adds the new one,
" cd's back to previous directory
" If 'sources' is not found does nothing
function! CS()
  let file = expand('%:p')
  let move = ""
  let head = "null"
  let i = 0
  while i < 100
    let i += 1
    let move .= ":h"
    let head = fnamemodify(file, ":p" . move . ":t")

    if head == "sources"
      echohl None
      let sources = fnamemodify(file, ":p" . move)
      echo "sources directory found"
      echo sources
      echo
      echo "Building cross-reference and adding connection to vim..."
      execute 'cd ' . sources
      !cscope -Rb
      cs kill -1 " Remove all cscope connections
      cs add cscope.out
      execute 'cd -'
      break
    elseif head == ""
      echohl WarningMsg
      echo "No sources directory found!"
      echohl None
      break
    endif
  endwhile
endfunction
command! CS call CS()

" Run ffbuild for recipe that is being edited
function! FFBuild()
  let recipe = expand('%:p:h:t')
  execute "!ffbuild " . recipe
endfunction
command! FFBuild call FFBuild()
nmap <M-b> :FFBuild<CR>

" Deploy current recipe using devtool to AXIS_TARGET_IP (NOT USED)
function! DeployTarget()
  if $AXIS_TARGET_IP == ""
    echo "ERROR: AXIS_TARGET_IP not set"
  else
    let recipe = expand('%:p:h:t')
    execute "!devtool deploy-target --no-check-space " . recipe . " root@" . $AXIS_TARGET_IP
  endif
endfunction

" Deploy current recipe using ffbuild to AXIS_TARGET_IP
function! Deploy()
  if $AXIS_TARGET_IP == ""
    echo "ERROR: AXIS_TARGET_IP not set"
  else
    let recipe = expand('%:p:h:t')
    execute "!ffbuild " . recipe . " --deploy root@" . $AXIS_TARGET_IP
  endif
endfunction
command! Deploy call Deploy()
nmap <M-d> :Deploy<CR>

" Run gitk --all on folder where current open file is located
function! Gk()
  let dir = expand('%:p:h')
  execute 'cd ' . dir
  execute '!gitk --all'
  execute 'cd -'
endfunction
command! Gk call Gk()

" Call git pull --rebase in folder where current open file is located
function! Gpr()
  let dir = expand('%:p:h')
  execute 'cd ' . dir
  execute '!git pull --rebase'
  execute 'cd -'
endfunction
command! Gpr call Gpr()
