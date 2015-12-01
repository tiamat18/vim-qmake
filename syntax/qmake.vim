" qmake project syntax file
" Language:     qmake project
" Maintainer:   Arto Jonsson <ajonsson@kapsi.fi>
" http://gitorious.org/qmake-project-syntax-vim

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax case match

" Comment
syn match qmakeComment "#.*"

" Variables
syn match qmakeVariable /[A-Z_]\+\s*=/he=e-1
syn match qmakeVariable /[A-Z_]\+\s*\(+\|-\||\|*\|\~\)=/he=e-2

" Value of a variable
syn match qmakeValue /$$[A-Z_]\+/
syn match qmakeValue /$${[A-Z_]\+}/

" Environment variable
syn match qmakeEnvVariable /$([A-Z_]\+)/
syn match qmakeEnvVariable /$$([A-Z_]\+)/

" Qt build configuration
syn match qmakeQtConfiguration /$$\[[A-Z_]\+\]/

" Builtins
"syn keyword qmakeBuiltin basename count dirname error exists
"syn keyword qmakeBuiltin find for join member message
"syn keyword qmakeBuiltin prompt quote sprintf system unique warning

" Test functions
syn match qmakeTestFunctions /\(cache\|CONFIG\|include\|error\|eval\|exists\|export\|if\|isEmpty\|load\|log\|message\|mkpath\|requires\|system\|unset\|warning\|contains\|count\|debug\|equals\|greaterThan\|for\|lessThan\|touch\|defined\|files\|infile\|write_file\|packagesExist\|prepareRecursiveTarget\|qtCompileTest\|qtHaveModule\)\((.*)\)\@=/

" Scopes
syn match qmakeScope /[0-9A-Za-z_-]\+:/he=e-1
syn match qmakeScope /[0-9A-Za-z_-]\+|\@=/
syn match qmakeScope /|\@<=[0-9A-Za-z_-]\+/
syn match qmakeScope /[0-9A-Za-z_-]\+\s*{/he=e-1

hi def link qmakeComment Comment
hi def link qmakeVariable Identifier
hi def link qmakeBuiltin Macro
hi def link qmakeTestFunctions Macro
hi def link qmakeValue PreProc
hi def link qmakeEnvVariable PreProc
hi def link qmakeQtConfiguration PreProc
hi def link qmakeScope Conditional

let b:current_syntax = "qmake"
