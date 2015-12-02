" Vim indent file
" Language: QMAKE
" Author:   ArkBriar
" Last Change: 2015-12-02 (Not a good day for me)
"
" Set indent for project file

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=QMakeIndent(v:lnum)

" Only define functions once per session
if exists("*QMakeIndent")
    finish
endif

function! QMakeIndent(lnum)
    let prevlnum = prevnonblank(a:lnum - 1)
    if prevlnum == 0
        " top of file
        return 0
    endif

    " grab the previous and current line, stripping comments.
    let prevl = substitute(getline(prevlnum), '#.*$', '', '')
    let thisl = substitute(getline(a:lnum), '#.*$', '', '')
    let previ = indent(prevlnum)

    let ind = previ

    if prevl =~ '[{[(]\s*$'
        let ind += &sw
    endif
    if thisl =~ '^\s*[}\])]'
        let ind -= &sw
    endif

    return ind
endfunc
