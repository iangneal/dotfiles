:set number
:colo elflord
:syntax on

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

command Latex execute "silent !pdflatex % > /dev/null && open %:r.pdf > /dev/null 2>&1 &" | redraw!
map <F2> :Latex<CR>
