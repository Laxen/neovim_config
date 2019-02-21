" TODO
" In-editor Pylint and PEP8

call plug#begin('~/.vim/plugged')

" Themes
" Plug 'morhetz/gruvbox'
" Plug 'mhartington/oceanic-next'
Plug 'kaicataldo/material.vim'

" Airline
Plug 'vim-airline/vim-airline'

" Auto open brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Comment toggling
" Keys - gc
Plug 'tomtom/tcomment_vim'

" Snipping - Automatic completion of commonly typed things (class, if, for)
" Plug 'sirver/ultisnips'
" Plug 'honza/vim-snippets'

" Nerdtree - Nice directory visualizer
Plug 'scrooloose/nerdtree'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Ez window swapping
" Keys - <leader>ww in window 1, same in window 2 to swap the windows
Plug 'wesQ3/vim-windowswap'

" Autocompletion for many languages
Plug 'Valloric/YouCompleteMe'

" Fuzzy searching
Plug 'kien/ctrlp.vim'

" Might want in the future
" tpope/vim-surround For surrounding words with anything ("")
" airblade/vim-gitgutter For getting notifications which lines you've changed in a git repo

call plug#end()

" CScope --------------------------------------------
source ~/.config/nvim/cscope_maps.vim
set cscoperelative "Use relative paths based on the location of cscope.out

" General vim settings -----------------------------------------------
filetype plugin indent on
syntax on
set termguicolors
"For escaping out of the terminal
tnoremap <Esc> <C-\><C-n>
set number
set incsearch							"Start searching immediately
set clipboard+=unnamedplus				"Copy to clipboard by default
set nowrap
set encoding=utf8						"Needed to show glyphs
"Remove search highlighting when hitting esc
noremap <silent> <Esc> :noh<cr>
set diffopt=vertical,filler             "Vertical vimdiffs
let mapleader = " "                     "Rebind leader to space instead of \

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
" Yank to the end of a string
nmap ys yt"
" Re-select the block after deleting a fold
vmap zd zdgv

" Make the backspace work like normal
set backspace=indent,eol,start
" Show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert spaces
set expandtab
" Don't automatically break lines
set tw=0

"Search for text in visual mode using //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
" When searching with *, highlight without moving to next word
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

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

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

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

" YouCompleteMe ------------------------------------------
" leader+g Goes to definition or declaration
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" leader+leader+g does the same as above but in a vertical split
map <leader><leader>g :vs \| YcmCompleter GoToDefinitionElseDeclaration<CR>

" Add api-toolbox to YCM sys_path
let g:ycm_python_sys_path = ["/home/alexanga/.atf/src/api-toolbox", 
                           \ "/home/alexanga/.atf/src/atf-common",
                           \ "/home/alexanga/.atf/src/atf-decorator"]
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '/home/alexanga/.config/nvim/ycm_global_extra_conf.py'

" Deoplete -----------------------------------------------
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'
" set completeopt-=preview                                		" Gets rid of the scratch pad thing
" set completeopt+=longest                                        " Doesn't select the first completion item
" set completeopt+=menuone                                        " Show menu even if there's only one item
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"        " Tab completion
" inoremap <expr> j pumvisible() ? "\<C-n>" : "j"                 " Use j as down in autocomplete box
" inoremap <expr> k pumvisible() ? "\<C-p>" : "k"                 " Use k as up in autocomplete box

" Neomake -----------------------------------------------
" call neomake#configure#automake('nw', 750)

" Ultisnips -----------------------------------------------
" let g:UltiSnipsSnippetsDir='/home/alexanga/.vim/plugged/vim-snippets/UltiSnips'
" let g:UltiSnipsSnippetDirectories=['UltiSnips']
" let g:UltiSnipsExpandTrigger='<C-tab>'
" let g:UltiSnipsJumpForwardTrigger='<C-tab>'
" let g:UltiSnipsJumpBackwardTrigger='<C-s-tab>'
" let g:UltiSnipsEditSplit='vertical'

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

" Finds the parent 'sources' directory, cd's to it, builds cscope
" cross-reference, removes all other cscope connections and adds the new one,
" cd's back to previous directory
" If 'sources' is not found does nothing
" TODO: Remake this to work from the current working directory, or use something else instead of cscope...
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
