:set number
:set ruler
:colo elflord
:syntax on

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Highlights the 80th column
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

command Latex execute 'silent !pdflatex % > /dev/null && open %:r.pdf 
            \ > /dev/null 2>&1 &' | redraw!
map <F2> :Latex<CR>
