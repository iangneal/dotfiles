:set number
:colo elflord
:syntax on
:set autoindent
:set cindent

command Latex execute "silent !pdflatex % > /dev/null && open %:r.pdf > /dev/null 2>&1 &" | redraw!
map <F2> :Latex<CR>
