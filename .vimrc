
set nocompatible

execute pathogen#infect()

set autoindent
set cindent
set hlsearch

set wildmenu

set history=1000
set undolevels=1000

set title " change the terminal's title

set tags=./tags;$HOME

"colorscheme jellybeans
" colorscheme desert_my
set background=dark
colorscheme solarized
"colorscheme enigma
"colorscheme codeschool
"colorscheme gruvbox

" autocomplete
set dictionary=/usr/share/dict/words

let mapleader=" "
set timeoutlen=500

" code style - max column
"http://vim.wikia.com/wiki/Open_vimrc_file
"http://vim.wikia.com/wiki/Highlight_long_lines
"	-1 means any search highlighting will override the match highlighting
"	highlight long lines
"let w:m1=matchadd('ErrorMsg', '\%>121v.\+', -1)
"	highlight bad spaces
let w:m2=matchadd('ErrorMsg', '[ \t]\+$', -1)
if exists('+colorcolumn')
"	set colorcolumn=121
else
"	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>121v.\+', -1)
endif
" hihlight ColorColumn ctermbg=darkgrey guibg=darkgrey
highlight ColorColumn ctermbg=238 guibg=238

" highlight whitespaces
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

" fast window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" map \| :vsplit<CR>
nnoremap \| :vsplit<CR>
nnoremap _ :split<CR>
nnoremap \ :q<CR>
nnoremap <leader>x <C-w>x

" fast tab navigation
nnoremap <leader>t :tabnew<CR>
"nnoremap <C-m> :tabnew<CR>
nnoremap <S-h> :tabNext<cr>
nnoremap <S-l> :tabnext<cr>

" go to command window
nnoremap <tab> q:
" go to command prompt
nnoremap ; :
" go to search window
nnoremap <leader>/ q/
nnoremap <leader>h :nohlsearch<CR>
nnoremap * *N

nnoremap <leader>f :MRU<CR>

" ctags
"nnoremap <leader>g <C-]>
"nnoremap <leader>b <C-t>
" rtags
nnoremap <leader>g :call rtags#JumpTo()<CR>
nnoremap <leader>b <C-o>
nnoremap <leader>l :call rtags#FindRefs()<CR>
nnoremap <leader>v :call rtags#FindVirtuals()<CR>
" rtags use vim QuickFix window
let g:rtagsUseLocationList = 0

" ignore linewrap
nmap j gj
nmap k gk

" fast airline color changes
" set timeoutlen=50

" save and build
"nnoremap <F5> :wall \| make -C ~/src/out/Release -j6<Cr>
"nnoremap <F6> :wall \| make -C ~/src/out/Debug -j6<Cr>
nnoremap <F7> :wall \| make<Cr>
nnoremap <leader>m :wall \| make<Cr>
nnoremap <leader>z :botright copen<Cr>
nnoremap <leader>e :cnext<Cr>
"set makeprg=ninja

" C++ code completion
set omnifunc=omni#cpp#complete#Main
command Ctags !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .

" commands
"command Ctags !ctags -R * /usr/include/*
command Astyle !astyle -A3 -t4 -k3 -W3 -U -H -o -xn -xc -xk -O -m0 %
command -nargs=1 G Grep -R -I --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <args> *
command -nargs=1 Gi Grep -R -I -i --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <args> *
"nnoremap & :G <cword> <CR>
nnoremap & :Grep -R -I --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <cword> * <CR>
nnoremap ^ :Grep -R -I --exclude=tags --exclude=*.o --exclude=*.a --exclude=*.d --exclude-dir=build --exclude-dir=build_dir <cword> %:h <CR>

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" nnoremap <C-[> <C-T>

" keeps the current visual block selection active after changing indent with '<' or '>'
vnoremap > >gv
vnoremap < <gv

" copy text to the end-of-line - like y$
nnoremap Y y$

" silent vim - disable beeping
set vb t_vb=

" CodeStyle
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" always show statusline
set laststatus=2

set statusline+=%F
set statusline+=%m
set statusline+=%{fugitive#statusline()}
set statusline+=%=[%l,%v]\ %p%%

" map MM :BookmarkToggle<CR>
" map <C-m> :BookmarkShowAll<CR>

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" tagbar
map <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0

" airline - powerline symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.branch = '⎇'
let g:airline_theme='bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" ctrlp
let g:ctrlp_extensions = ['tag']
let g:ctrlp_cmd = 'CtrlPTag'

