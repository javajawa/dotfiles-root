set nocompatible

set showmatch
set showcmd

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

set incsearch
set ruler

set bg=dark
syntax on
set spell

set cul
set hlsearch

set mouse=a

set modeline
set modelines=5

set number
set numberwidth=5
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE

" Highlights lines in green that
"  - Are over 80 characters long
"  - Have trailing whitespace
"  - Have tabs (except before all other characters)
"  - Begin with spaces (probably meant to be tabs)
highlight OverlongLine    ctermbg=Blue guibg=LightBlue
au BufWinEnter * let w:m1=matchadd('OverlongLine', '\%<91v.\%>80v', -1)
highlight ExtraWhitespace ctermbg=Green guibg=LightGreen
au BufWinEnter * let w:m2=matchadd('ExtraWhitespace', '\s\+$', -1)
au BufWinEnter * let w:m3=matchadd('ExtraWhitespace', '[^\t]\zs\t(\t\+)?', -1)
au BufWinEnter * let w:m4=matchadd('ExtraWhitespace', '^  \+', -1)

" Home/End/Up/Down act based on text wrapping
" rather than on actual line wrapping. Useful for editing
" longer lines on smaller screens
nnoremap <Down> gj
vnoremap <Down> gj
inoremap <Down> <C-o>gj
nnoremap <Up> gk
vnoremap <Up> gk
inoremap <Up> <C-o>gk
nnoremap <Home> g^
vnoremap <Home> g^
inoremap <Home> <C-o>g^
nnoremap <End> g$
vnoremap <End> g$
inoremap <End> <C-o>g$

" Shift is sometimes a little too much for me to manage
map ; :

" And, sometimes, I don't let of shift when I should
command W :w
command Wq :wq

" Run external spell check over file
" Currently, assumes that TeX is the format
" F7 is bound to this command
set spellfile=~/.dict.en.utf-8.add
command Spell :!aspell -c -x -t %
noremap <F7> :Spell<Return>
inoremap <F7> <C-o>:Spell<Return>

" This is what KiTTY gives me for Ctrl-Left and Ctrl-Right
" You can check this with od -a <C-Left><C-Right><C-d>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

" <C-Left> and <C-Right> jump one word left/right
nnoremap <C-Left> b
vnoremap <C-Left> b
inoremap <C-Left> <C-o>b
nnoremap <C-Right> w
vnoremap <C-Right> w
inoremap <C-Right> <C-o>w

" <C-w> should always be window switching
" And not delete word under cursor
inoremap <C-w> <C-o><C-w>

" Maps <C-b> to make
nnoremap <C-b> :w<Return>:make<Return>
vnoremap <C-b> :w<Return>:make<Return>
inoremap <C-b> <C-o>:w<Return><C-o>:make<Return>

" Wildcard rules
set wildignore=*.class,*.pyc,*.obj,*.pdf,*.aux,*.dvi,*.eps,*.out,*.log,*.so
set wildmode=longest,list,full
set wildmenu

au BufNewFile,BufRead */DEBIAN/control setf debcontrol
au BufNewFile,BufRead httpd.conf,.htaccess,/etc/apcahe2/*.conf setf apache
au BufNewFile,BufRead /etc/iptables.d/* setf iptables
au BufNewFile,BufRead httpd.conf,.htaccess,/etc/apache2/*.conf,/etc/iptables.d/* set nospell
