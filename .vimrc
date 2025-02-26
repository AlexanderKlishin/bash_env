set nocompatible

set noswapfile

set autoindent
set cindent
set hlsearch

set wildmenu

set history=1000
set undolevels=1000

set title " change the terminal's title

set tags=./tags;$HOME

let mapleader=" "
set timeoutlen=500

" enable python3 on start
" https://robertbasic.com/blog/force-python-version-in-vim/
" Vim can have both of them, but use only one at a time.
" If you start using one version, there is no way to switch to the other one.
if has('python3')
endif

" ignore linewrap
nmap j gj
nmap k gk

" folders
nnoremap <leader><leader> za

" open new split on the right side
set splitright

" fast window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" map \| :vsplit<CR>
nnoremap \| :vsplit<CR>
nnoremap _ :split<CR>
nnoremap \ :q<CR>
"nnoremap - :MBEbd<CR>
nnoremap - :bd<CR>
nnoremap <leader>x <C-w>x
nnoremap <leader>\ :%bd \| e#<CR>

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" fast tab navigation
nnoremap <leader>t :tabnew<CR>
"nnoremap <C-m> :tabnew<CR>
"TODO: moving fo tabs
"nnoremap <S-h> :tabNext<cr>
"nnoremap <S-l> :tabnext<cr>
"nnoremap <S-h> :MBEbp<cr>
"nnoremap <S-l> :MBEbn<cr>
"nnoremap <S-h> :bprev<cr>
"nnoremap <S-l> :bnext<cr>
" skip quickfix window in bnext bprev
function! BpSkipTerm()
  let start_buffer = bufnr('%')
  bp
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    bp
  endwhile
endfunction
function! BnSkipTerm()
  let start_buffer = bufnr('%')
  bn
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    bn
  endwhile
endfunction
nnoremap <S-h> :call BpSkipTerm()<cr>
nnoremap <S-l> :call BnSkipTerm()<CR>

" go to command window
nnoremap <tab> q:
" go to command prompt
nnoremap ; :

" go to next difference
nnoremap <leader>d ]c

nnoremap <leader>l :GV!<CR>
nnoremap <leader>L :GV --all<CR>

" keeps the current visual block selection active after changing indent with '<' or '>'
vnoremap > >gv
vnoremap < <gv

" CodeStyle
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" copy text to the end-of-line - like y$
nnoremap Y y$

" silent vim - disable beeping
set vb t_vb=

" Searching
" open search history
nnoremap <leader>/ q/
nnoremap <leader>h :nohlsearch<CR>
nnoremap * *N
" search selected
vnoremap * y/<C-R>"<CR>N
" search selected in all files
vnoremap & y:Ack "<C-R>""<CR>/<C-R>"<CR>

" autocomplete
set dictionary=/usr/share/dict/words

execute pathogen#infect()
" pathogen - generate help tags for modules
Helptags

" fix background
let g:solarized_termcolors=256
" set t_Co=256
" set background=dark
" colorscheme solarized
" colorscheme solarized8_dark_flat
colorscheme Atelier_SavannaDark
" to fix solarized color scheme in tmux
" set t_ut=

nnoremap <leader>f :MRU<CR>
let MRU_Filename_Format = {
    \   'formatter': 'fnamemodify(v:val, ":t") . " (" . fnamemodify(v:val, ":.:~") . ")"',
    \   'parser': '(\zs.*\ze)',
    \   'syntax': '^.\{-}\ze('
    \}
" formatter
" clang-format -dump-config
let g:clang_format#style_options = {
            \ "Standard" : "C++11",
            \ "IndentWidth": 4,
            \ "TabWidth": 4 }
vnoremap <Leader>f :ClangFormat<CR>
nnoremap <leader>F :Format<CR>

"let g:jedi#auto_vim_configuration = 0
"remove conflict with nerd tree key binding
"let g:jedi#usages_command = ""
let g:jedi#usages_command = "<leader>r"

" ctags
"nnoremap <leader>g <C-]>
"nnoremap <leader>b <C-t>
" rtags
autocmd FileType c,cpp nnoremap <leader>g :call rtags#JumpTo(g:SAME_WINDOW)<CR>
autocmd FileType c,cpp nnoremap <leader>G :call rtags#JumpTo(g:V_SPLIT)<CR>
nnoremap <leader>b <C-o>
autocmd FileType c,cpp nnoremap <leader>r :call rtags#FindRefs()<CR>
autocmd FileType c,cpp nnoremap <leader>R :call rtags#FindRefsCallTree()<CR>
autocmd FileType c,cpp nnoremap <leader>v :call rtags#FindVirtuals()<CR>
autocmd FileType c,cpp nnoremap <Leader>w :call rtags#RenameSymbolUnderCursor()<CR>
" rtags use vim QuickFix window
let g:rtagsUseLocationList = 0

" fast airline color changes
" set timeoutlen=50

" save and build
"nnoremap <F5> :wall \| make -C ~/src/out/Release -j6<Cr>
"nnoremap <F6> :wall \| make -C ~/src/out/Debug -j6<Cr>
nnoremap <F7> :wall \| make<Cr>
"nnoremap <leader>m :wall \| make -C build<Cr>
nnoremap <leader>m :wall \| make -j 8<Cr>
nnoremap <leader>M :!rc -J build<Cr>
nnoremap <leader>z :botright copen<Cr>
nnoremap <leader>e :cnext<Cr>
"set makeprg=ninja
"set makeprg=ninja

" C++ code completion
set omnifunc=omni#cpp#complete#Main
command Ctags !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .

" by default - order is reversed
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'

" commands
"command Ctags !ctags -R * /usr/include/*
command Astyle !astyle -A3 -t4 -k3 -W3 -U -H -o -xn -xc -xk -O -m0 %
command -nargs=1 G Grep -R -I --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <args> *
command -nargs=1 Gi Grep -R -I -i --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <args> *
"nnoremap & :G <cword> <CR>
nnoremap & :Grep -R -I
    \ --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d
    \ --exclude-dir=build --exclude-dir=build_dir --exclude-dir=ns_build_env --exclude-dir=bin
    \ <cword> * <CR>
nnoremap ^ :Grep -R -I
    \ --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d
    \ --exclude-dir=build --exclude-dir=build_dir --exclude-dir=ns_build_env
    \ <cword> %:h <CR>

command Format !clang-format -i %

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" always show statusline
set laststatus=2

set statusline+=%F
set statusline+=%m
set statusline+=%{fugitive#statusline()}
set statusline+=%=[%l,%v]\ %p%%

" map MM :BookmarkToggle<CR>
" map <C-m> :BookmarkShowAll<CR>

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

if empty(maparg(']', 'n'))
    nmap ] <Plug>VinegarUp
endif

" tagbar
map <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0

" airline - powerline symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_theme='bubblegum'
let g:airline#extensions#whitespace#enabled = 0
" remove branch info
let g:airline_section_b=''
" remove 'fileencoding, fileformat' section
let g:airline_section_y=''

" ctrlp
"let g:ctrlp_extensions = ['tag']
"let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_cmd = 'CtrlPMixed'

filetype on
syntax on
