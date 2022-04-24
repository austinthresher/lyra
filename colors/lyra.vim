"Copyright (c) 2020 Austin Thresher
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

highlight clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'lyra'

" Wrapper for setting highlights
function! s:hi(group, fg, bg, attr)
    let l:cmd = [ 'hi', a:group, 'guifg='.a:fg[0], 'guibg='.a:bg[0],
                \ 'gui='.a:attr, 'ctermfg='.a:fg[1], 'ctermbg='.a:bg[1],
                \ 'cterm='.a:attr ]
    execute join(l:cmd, ' ')
endfunc

" Set palette based on t_Co
if &t_Co || &termguicolors
    if &t_Co < 16 || &t_Co is# ''
        let s:pal = range(0, 7) + range(0, 7)
        let s:grays = [0, 0, 0, 0, 0, 0, 7, 7, 7, 7]
    elseif &t_Co < 256
        let s:pal = range(0, 15)
        let s:grays = [0, 0, 8, 8, 8, 7, 7, 7, 7, 15]
    else
        if exists('g:lyra_use_system_colors') && g:lyra_use_system_colors
            let s:pal = [   0,   1,   2,   3,   4,   5,   6,   7,
                        \   8,   9,  10,  11,  12,  13,  14,  15]
        else
            let s:pal = [ 233,  52,  22, 208,  32, 199,  49, 252,
                        \  59, 196,  41, 220,  45, 170, 159, 231]
        endif
        let s:grays = [0, 232, 235, 237, 239, 243, 245, 247]
    endif
else
    finish
endif

" Map palette to names

" 16 ANSI colors
let s:xterm_black      = s:pal[0]
let s:xterm_red        = s:pal[1]
let s:xterm_green      = s:pal[2]
let s:xterm_yellow     = s:pal[3]
let s:xterm_blue       = s:pal[4]
let s:xterm_magenta    = s:pal[5]
let s:xterm_cyan       = s:pal[6]
let s:xterm_white      = s:pal[7]
let s:xterm_br_black   = s:pal[8]
let s:xterm_br_red     = s:pal[9]
let s:xterm_br_green   = s:pal[10]
let s:xterm_br_yellow  = s:pal[11]
let s:xterm_br_blue    = s:pal[12]
let s:xterm_br_magenta = s:pal[13]
let s:xterm_br_cyan    = s:pal[14]
let s:xterm_br_white   = s:pal[15]
" Darker than black
let s:xterm_hard_black = s:grays[0]
let s:xterm_blacker    = s:grays[1]
" Darker than br_black, lighter than black
let s:xterm_darkest    = s:grays[2]
let s:xterm_darker     = s:grays[3]
let s:xterm_dark       = s:grays[4]
" Lighter than br_black, darker than white
let s:xterm_light      = s:grays[5]
let s:xterm_lighter    = s:grays[6]
let s:xterm_lightest   = s:grays[7]

" Associate truecolor values with color names
let s:black      = ['#121212', s:xterm_black]
let s:red        = ['#5F0000', s:xterm_red]
let s:green      = ['#005F00', s:xterm_green]
let s:yellow     = ['#FF8700', s:xterm_yellow]
let s:blue       = ['#0087DF', s:xterm_blue]
let s:magenta    = ['#FF00AF', s:xterm_magenta]
let s:cyan       = ['#00FFAF', s:xterm_cyan]
let s:white      = ['#D0D0D0', s:xterm_white]
let s:br_black   = ['#5F5F5F', s:xterm_br_black]
let s:br_red     = ['#FF0000', s:xterm_br_red]
let s:br_green   = ['#00DF5F', s:xterm_br_green]
let s:br_yellow  = ['#FFDF00', s:xterm_br_yellow]
let s:br_blue    = ['#00DFFF', s:xterm_br_blue]
let s:br_magenta = ['#DF5FDF', s:xterm_br_magenta]
let s:br_cyan    = ['#AFFFFF', s:xterm_br_cyan]
let s:br_white   = ['#FFFFFF', s:xterm_br_white]
let s:blacker    = ['#080808', s:xterm_blacker]
let s:hard_black = ['#000000', s:xterm_hard_black]
let s:darkest    = ['#1C1C1C', s:xterm_darkest]
let s:darker     = ['#262626', s:xterm_darker]
let s:dark       = ['#3A3A3A', s:xterm_dark]
let s:light      = ['#808080', s:xterm_light]
let s:lighter    = ['#9E9E9E', s:xterm_lighter]
let s:lightest   = ['#BCBCBC', s:xterm_lightest]

let s:none = ['NONE', 'NONE']



" We control syntax highlighting ourselves
syntax on 


let transparent = exists('g:lyra_transparent') && g:lyra_transparent
let dim_inactive = has('nvim') && !transparent
            \ && exists('g:lyra_dim_inactive') && g:lyra_dim_inactive
if dim_inactive
    call s:hi('NormalFocused', s:br_white, s:hard_black, 'NONE')
    call s:hi('NormalUnfocused', s:white, s:blacker, 'NONE')
    set winhl=Normal:NormalFocused,NormalNC:NormalUnfocused
else
    if transparent
        call s:hi('Normal', s:br_white, s:none, 'NONE')
    else
        call s:hi('Normal', s:br_white, s:black, 'NONE')
    endif
endif


" Highlights
if exists('g:lyra_no_highlighting') && g:lyra_no_highlighting
    call s:hi('Comment',      s:green,   s:none,       'NONE')
    for group in ['Constant', 'Character', 'Boolean', 'Number', 'Float',
		\ 'Statement', 'Conditional', 'Repeat', 'Label', 'Exception',
		\ 'Keyword', 'String', 'SpecialChar', 'Operator',
		\ 'Todo', 'Error', 'Type', 'StorageClass', 'Typedef',
		\ 'Structure', 'Delimiter', 'Identifier', 'PreProc',
		\ 'Include', 'Define', 'PreCondit', 'cIncluded', 'Function',
		\ 'Macro', 'Special' ]
	call s:hi(group, s:none, s:none, 'NONE')
    endfor
else 
    call s:hi('Comment', s:br_green, s:none, 'italic')
    for group in ['Constant', 'Character', 'Boolean', 'Number', 'Float']
        call s:hi(group, s:br_red, s:none, 'NONE')
    endfor
    
    for group in ['Statement', 'Conditional', 'Repeat', 'Label',
                \ 'Exception', 'Keyword']
        call s:hi(group, s:blue, s:none, 'bold')
    endfor
    
    if exists('g:lyra_string_bg') && g:lyra_string_bg
        call s:hi('String',       s:cyan,      s:darkest, 'NONE')
        call s:hi('SpecialChar',  s:br_yellow, s:darkest, 'italic')
    else
        call s:hi('String',       s:cyan,   s:none, 'NONE')
        call s:hi('SpecialChar',  s:br_yellow, s:none, 'italic')
    endif
    
    call s:hi('Operator',     s:white,      s:none,       'NONE')
    call s:hi('Todo',         s:br_yellow,  s:black,      'bold')
    call s:hi('Error',        s:br_red,     s:none,       'bold')
    call s:hi('Type',         s:br_blue,    s:none,       'NONE')
    call s:hi('StorageClass', s:br_blue,    s:none,       'NONE')
    call s:hi('Typedef',      s:br_blue,    s:none,       'NONE')
    call s:hi('Structure',    s:br_blue,    s:none,       'NONE')
    call s:hi('Delimiter',    s:white,      s:none,       'NONE')
    call s:hi('Identifier',   s:br_white,   s:none,       'NONE')
    call s:hi('PreProc',      s:yellow,     s:none,       'NONE')
    call s:hi('Include',      s:yellow,     s:none,       'NONE')
    call s:hi('Define',       s:yellow,     s:none,       'NONE')
    call s:hi('PreCondit',    s:yellow,     s:none,       'NONE')
    call s:hi('cIncluded',    s:br_cyan,    s:none,       'italic')
    call s:hi('Function',     s:magenta,    s:none,       'NONE')
    call s:hi('Macro',        s:br_red,     s:none,       'NONE')
    call s:hi('Special',      s:yellow,     s:none,       'NONE')
endif 

" Shared between syntax on / off {{{
    call s:hi('Cursor', s:none, s:none, 'reverse')
    hi! link vCursor Cursor
    hi! link iCursor Cursor
    hi! link lCursor Cursor

    call s:hi('Visual', s:hard_black, s:blue, 'NONE')
    hi! link VisualNOS Visual

    call s:hi('Search', s:hard_black, s:light, 'NONE')
    call s:hi('IncSearch', s:hard_black, s:br_yellow, 'NONE')

    call s:hi('Pmenu',        s:white,      s:hard_black, 'NONE')
    call s:hi('PmenuSel',     s:br_white,   s:magenta,    'bold')
    "call s:hi('CursorLine',   s:none,       s:none,       'underline')

    call s:hi('MatchParen',   s:br_magenta, s:none,       'bold')
    call s:hi('Conceal',      s:darker,     s:none,       'NONE')
    call s:hi('StatusLine',   s:br_white,   s:darkest,    'NONE')
    call s:hi('StatusLineNC', s:dark,       s:hard_black, 'NONE')
    call s:hi('VertSplit',    s:br_white,   s:none,       'NONE')
    call s:hi('WildMenu',     s:blue,       s:black,      'bold')
    call s:hi('ErrorMsg',     s:br_white,   s:red,        'NONE')
    call s:hi('Directory',    s:blue,       s:none,       'bold')
    call s:hi('Title',        s:br_yellow,  s:none,       'bold')
    call s:hi('MoreMsg',      s:yellow,     s:none,       'bold')
    call s:hi('Question',     s:br_yellow,  s:none,       'bold,reverse')
    call s:hi('Warning',      s:yellow,     s:none,       'NONE')

    call s:hi('Folded',       s:white,      s:black,      'NONE')
    call s:hi('SignColumn',   s:white,      s:hard_black, 'NONE')
    call s:hi('LineNr',       s:lightest,   s:dark,       'NONE')
    call s:hi('CursorLineNr', s:red,        s:none,       'NONE')
    call s:hi('DiffDelete',   s:light,      s:br_red,     'NONE')
    call s:hi('DiffAdd',      s:light,      s:br_green,   'NONE')
    call s:hi('DiffChange',   s:light,      s:br_yellow,  'NONE')
    call s:hi('DiffText',     s:light,      s:br_yellow,  'NONE')
    call s:hi('EndOfBuffer',  s:black,      s:hard_black, 'NONE')

    " vim-gitgutter
    call s:hi('GitGutterDeleteLine',       s:dark, s:br_red,    'NONE')
    call s:hi('GitGutterAddLine',          s:dark, s:br_green,  'NONE')
    call s:hi('GitGutterChangeLine',       s:dark, s:br_yellow, 'NONE')
    call s:hi('GitGutterChangeDeleteLine', s:dark, s:br_yellow, 'NONE')
    hi! link GitGutterAddLineNr GitGutterAddLine
    hi! link GitGutterDeleteLineNr GitGutterDeleteLine
    hi! link GitGutterChangeLineNr GitGutterChangeLine
    hi! link GitGutterChangeDeleteLineNr GitGutterChangeDeleteLine

    " conflict-marker.vim
    call s:hi('ConflictMarkerBegin',     s:green,   s:none,       'bold')
    call s:hi('ConflictMarkerOurs',      s:none,    s:hard_black, 'NONE')
    call s:hi('ConflictMarkerSeparator', s:yellow,  s:none,       'bold')
    call s:hi('ConflictMarkerTheirs',    s:none,    s:hard_black, 'NONE')
    call s:hi('ConflictMarkerEnd',       s:br_magenta, s:none,       'bold')

    if has('spell')
	call s:hi('SpellCap',   s:none, s:magenta, 'underline')
	call s:hi('SpellBad',   s:none, s:red,     'underline')
	call s:hi('SpellLocal', s:none, s:yellow,  'underline')
	call s:hi('SpellRare',  s:none, s:cyan,    'underline')
    endif

    if has('terminal')
	call s:hi('Terminal', s:br_white, s:hard_black, 'NONE')
    endif

    for group in ['NonText', 'SpecialKey']
        call s:hi(group, s:light, s:none, 'NONE')
    endfor

    call s:hi('QuickFixLine', s:none, s:black, 'NONE')
    augroup QuickFixColors
	autocmd!
	autocmd Syntax qf syntax match qfWarning "warning" contained nextGroup=qfSeparator
	autocmd Syntax qf syntax match qfLineNr "[^|]*" contained contains=qfError,qfWarning
	autocmd Syntax qf syntax match clangTidyCheck "\[.*\]$"
	autocmd Syntax qf highlight link clangTidyCheck Conceal
	autocmd Syntax qf highlight link qfFileName cIncluded
	autocmd Syntax qf highlight link qfWarning Warning 
	autocmd Syntax qf highlight link qfSeparator Normal
    augroup END
" }}}
