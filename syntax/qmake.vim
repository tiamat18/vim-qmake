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


" Comments
syn match qmakeComment "#.*"

" Escape characters
syn match qmakeEscapedChar /\\['"$\\]/

" Quoted string literals
syn region qmakeQuotedString start=/"/ end=/"/ contains=@qmakeExpansion,qmakeEscapedChar
syn region qmakeQuotedString start=/'/ end=/'/ contains=@qmakeExpansion,qmakeEscapedChar


" QMake variable declarations
syn match qmakeVarDecl /\(\i\|\.\)\+\s*=/he=e-1 contains=qmakeBuiltinVarName nextgroup=qmakeVarAssign
syn match qmakeVarDecl /\(\i\|\.\)\+\s*\(+\|-\||\|*\|\~\)=/he=e-2 contains=qmakeBuiltinVarName nextgroup=qmakeVarAssign

" QMake variable assignments
syn region qmakeVarAssign start=/\s*\ze[^[:space:]}]/ skip=/\\$/ end=/\(\ze}\|$\)/ contained contains=@qmakeData


" QMake variable values / macro expansions
syn match qmakeVarValue /$$\(\i\|\.\)\+/ contains=qmakeBuiltinVarVal,qmakeBuiltinMacro nextgroup=qmakeMacroArgs
syn match qmakeVarValue /$${\(\i\|\.\)\+}/ contains=qmakeBuiltinVarVal
syn region qmakeMacroArgs matchgroup=qmakeMacroParens start=/(/ skip=/\\$/ excludenl end=/)\|$/ contained contains=@qmakeData,qmakeMacroComma
syn match qmakeMacroComma /,/ contained

" Environment variable values
syn match qmakeEnvValue /$(\(\i\|\.\)\+)/
syn match qmakeEnvValue /$$(\(\i\|\.\)\+)/

" QMake property values
syn match qmakePropValue /$$\[\(\i\|\.\)\+\]/ contains=qmakeBuiltinProp

" All possible variable/macro/property expansions
syn cluster qmakeExpansion contains=qmakeVarValue,qmakeEnvValue,qmakePropValue

" All possible data values
syn cluster qmakeData contains=@qmakeExpansion,qmakeQuotedString,qmakeEscapedChar


" User-defined macros
syn keyword qmakeUserMacroDecl defineReplace nextgroup=qmakeUserMacroName
syn region qmakeUserMacroName matchgroup=none start=/\s*(/ end=/)\|$/ contained

" User-defined functions
syn keyword qmakeUserFuncDecl defineTest nextgroup=qmakeUserFuncName
syn region qmakeUserFuncName matchgroup=none start=/\s*(/ end=/)\|$/ contained
syn keyword qmakeFuncReturn return nextgroup=qmakeFuncReturnArgs
syn region qmakeFuncReturnArgs matchgroup=none start=/\s*(/ skip='\\$' end=/)\|$/ contained contains=@qmakeData


" Function arguments
syn region qmakeFuncArgs start=/(/ skip=/\\$/ excludenl end=/)\|$/ contains=@qmakeData


" Built-in variables (as of Qt 5.8)
let s:builtInVars = [ 'CONFIG', 'DEFINES', 'DEF_FILE', 'DEPENDPATH', 'DEPLOYMENT_PLUGIN', 'DESTDIR', 'DISTFILES', 
                    \ 'DLLDESTDIR', 'FORMS', 'GUID', 'HEADERS', 'ICON', 'IDLSOURCES', 'INCLUDEPATH', 'INSTALLS', 'LEXIMPLS', 
                    \ 'LEXOBJECTS', 'LEXSOURCES', 'LIBS', 'LITERAL_HASH', 'MAKEFILE', 'MAKEFILE_GENERATOR', 'MOC_DIR', 
                    \ 'OBJECTS', 'OBJECTS_DIR', 'POST_TARGETDEPS', 'PRE_TARGETDEPS', 'PRECOMPILED_HEADER', 'PWD', 
                    \ 'OUT_PWD', 'QMAKE', 'QMAKESPEC', 'QMAKE_AR_CMD', 'QMAKE_BUNDLE_DATA', 'QMAKE_BUNDLE_EXTENSION', 
                    \ 'QMAKE_CC', 'QMAKE_CFLAGS', 'QMAKE_CFLAGS_DEBUG', 'QMAKE_CFLAGS_RELEASE', 'QMAKE_CFLAGS_SHLIB', 
                    \ 'QMAKE_CFLAGS_THREAD', 'QMAKE_CFLAGS_WARN_OFF', 'QMAKE_CFLAGS_WARN_ON', 'QMAKE_CLEAN', 'QMAKE_CXX', 
                    \ 'QMAKE_CXXFLAGS', 'QMAKE_CXXFLAGS_DEBUG', 'QMAKE_CXXFLAGS_RELEASE', 'QMAKE_CXXFLAGS_SHLIB', 
                    \ 'QMAKE_CXXFLAGS_THREAD', 'QMAKE_CXXFLAGS_WARN_OFF', 'QMAKE_CXXFLAGS_WARN_ON', 'QMAKE_DISTCLEAN', 
                    \ 'QMAKE_EXTENSION_SHLIB', 'QMAKE_EXTENSION_STATICLIB', 'QMAKE_EXT_MOC', 'QMAKE_EXT_UI', 
                    \ 'QMAKE_EXT_PRL', 'QMAKE_EXT_LEX', 'QMAKE_EXT_YACC', 'QMAKE_EXT_OBJ', 'QMAKE_EXT_CPP', 'QMAKE_EXT_H', 
                    \ 'QMAKE_EXTRA_COMPILERS', 'QMAKE_EXTRA_TARGETS', 'QMAKE_FAILED_REQUIREMENTS', 
                    \ 'QMAKE_FRAMEWORK_BUNDLE_NAME', 'QMAKE_FRAMEWORK_VERSION', 'QMAKE_HOST', 'QMAKE_INCDIR', 
                    \ 'QMAKE_INCDIR_EGL', 'QMAKE_INCDIR_OPENGL', 'QMAKE_INCDIR_OPENGL_ES2', 'QMAKE_INCDIR_OPENVG', 
                    \ 'QMAKE_INCDIR_X11', 'QMAKE_INFO_PLIST', 'QMAKE_LFLAGS', 'QMAKE_LFLAGS_CONSOLE', 
                    \ 'QMAKE_LFLAGS_DEBUG', 'QMAKE_LFLAGS_PLUGIN', 'QMAKE_LFLAGS_RPATH', 'QMAKE_LFLAGS_REL_RPATH', 
                    \ 'QMAKE_REL_RPATH_BASE', 'QMAKE_LFLAGS_RPATHLINK', 'QMAKE_LFLAGS_RELEASE', 'QMAKE_LFLAGS_APP', 
                    \ 'QMAKE_LFLAGS_SHLIB', 'QMAKE_LFLAGS_SONAME', 'QMAKE_LFLAGS_THREAD', 'QMAKE_LFLAGS_WINDOWS', 
                    \ 'QMAKE_LIBDIR', 'QMAKE_LIBDIR_FLAGS', 'QMAKE_LIBDIR_EGL', 'QMAKE_LIBDIR_OPENGL', 
                    \ 'QMAKE_LIBDIR_OPENVG', 'QMAKE_LIBDIR_X11', 'QMAKE_LIBS', 'QMAKE_LIBS_EGL', 'QMAKE_LIBS_OPENGL', 
                    \ 'QMAKE_LIBS_OPENGL_ES1,', 'QMAKE_LIBS_OPENGL_ES2', 'QMAKE_LIBS_OPENVG', 'QMAKE_LIBS_THREAD', 
                    \ 'QMAKE_LIBS_X11', 'QMAKE_LIB_FLAG', 'QMAKE_LINK_SHLIB_CMD', 'QMAKE_LN_SHLIB', 
                    \ 'QMAKE_OBJECTIVE_CFLAGS', 'QMAKE_POST_LINK', 'QMAKE_PRE_LINK', 'QMAKE_PROJECT_NAME', 
                    \ 'QMAKE_MAC_SDK', 'QMAKE_MACOSX_DEPLOYMENT_TARGET', 'QMAKE_MAKEFILE', 'QMAKE_QMAKE', 
                    \ 'QMAKE_RESOURCE_FLAGS', 'QMAKE_RPATHDIR', 'QMAKE_RPATHLINKDIR', 'QMAKE_RUN_CC', 
                    \ 'QMAKE_RUN_CC_IMP', 'QMAKE_RUN_CXX', 'QMAKE_RUN_CXX_IMP', 'QMAKE_SONAME_PREFIX', 'QMAKE_TARGET',
                    \ 'QMAKE_TARGET_COMPANY', 'QMAKE_TARGET_DESCRIPTION', 'QMAKE_TARGET_COPYRIGHT', 
                    \ 'QMAKE_TARGET_PRODUCT', 'QT', 'QTPLUGIN', 'QT_VERSION', 'QT_MAJOR_VERSION', 'QT_MINOR_VERSION', 
                    \ 'QT_PATCH_VERSION', 'RC_FILE', 'RC_CODEPAGE', 'RC_DEFINES', 'RC_ICONS', 'RC_LANG', 
                    \ 'RC_INCLUDEPATH', 'RCC_DIR', 'REQUIRES', 'RESOURCES', 'RES_FILE', 'SIGNATURE_FILE', 'SOURCES', 
                    \ 'SUBDIRS', 'TARGET', 'TEMPLATE', 'TRANSLATIONS', 'UI_DIR', 'VERSION', 'VERSION_PE_HEADER', 
                    \ 'VER_MAJ', 'VER_MIN', 'VER_PAT', 'VPATH', 'WINRT_MANIFEST', 'YACCSOURCES', 
                    \ '_PRO_FILE_', '_PRO_FILE_PWD_' ]
execute "syn keyword qmakeBuiltinVarName ".join(s:builtInVars)." contained"
execute "syn keyword qmakeBuiltinVarVal ".join(s:builtInVars)." contained"
syn match qmakeBuiltinVarName /\v<(TARGET_(EXT|x(\.y\.z)?))>/ contained
syn match qmakeBuiltinVarVal /\v<(TARGET_(EXT|x(\.y\.z)?))>/ contained

" Built-in properties (as of Qt 5.8)
let s:builtInProps = [ 'QMAKE_SPEC', 'QMAKE_VERSION', 'QMAKE_XSPEC', 'QT_HOST_BINS', 'QT_HOST_DATA', 'QT_HOST_PREFIX',
                     \ 'QT_INSTALL_ARCHDATA', 'QT_INSTALL_BINS', 'QT_INSTALL_CONFIGURATION', 'QT_INSTALL_DATA', 
                     \ 'QT_INSTALL_DOCS', 'QT_INSTALL_EXAMPLES', 'QT_INSTALL_HEADERS', 'QT_INSTALL_IMPORTS', 
                     \ 'QT_INSTALL_LIBEXECS', 'QT_INSTALL_LIBS', 'QT_INSTALL_PLUGINS', 'QT_INSTALL_PREFIX', 
                     \ 'QT_INSTALL_QML', 'QT_INSTALL_TESTS', 'QT_INSTALL_TRANSLATIONS', 'QT_SYSROOT', 'QT_VERSION' ]
execute "syn keyword qmakeBuiltinProp ".join(s:builtInProps)." contained"

" Built-in macros (as of Qt 5.8)
let s:builtInMacros = [ 'absolute_path', 'basename', 'cat', 'clean_path', 'dirname', 'enumerate_vars', 'escape_expand',
                      \ 'find', 'first', 'format_number', 'fromfile', 'getenv', 'join', 'last', 'list', 'lower', 
                      \ 'member', 'num_add', 'prompt', 'quote', 're_escape', 'relative_path', 'replace', 'sprintf', 
                      \ 'resolve_depends', 'reverse', 'section', 'shadowed', 'shell_path', 'shell_quote', 'size', 
                      \ 'sort_depends', 'sorted', 'split', 'str_member', 'str_size', 'system', 'system_path', 
                      \ 'system_quote', 'take_first', 'take_last', 'unique', 'upper', 'val_escape' ]
execute "syn keyword qmakeBuiltinMacro ".join(s:builtInMacros)." contained"

" Built-in functions (as of Qt 5.8)
let s:builtInFuncs = [ 'cache', 'CONFIG', 'contains', 'count', 'debug', 'defined', 'equals', 'error', 'eval', 'exists', 
                     \ 'export', 'files', 'for', 'greaterThan', 'if', 'include', 'infile', 'isActiveConfig', 'isEmpty', 
                     \ 'isEqual', 'lessThan', 'load', 'log', 'message', 'mkpath', 'packagesExist', 
                     \ 'prepareRecursiveTarget', 'qtCompileTest', 'qtHaveModule', 'requires', 'system', 'touch', 
                     \ 'unset', 'warning', 'write_file' ]
execute 'syn match qmakeBuiltinFunc /\v<('.join(s:builtInFuncs, '|').')>\s*(\(.*\))@=/'


" Scopes
syn match qmakeScope /[0-9A-Za-z_+-]\+:/he=e-1
syn match qmakeScope /[0-9A-Za-z_+-]\+|\@=/
syn match qmakeScope /|\@<=[0-9A-Za-z_+-]\+/
syn match qmakeScope /[0-9A-Za-z_+-]\+\s*{/he=e-1


hi def link qmakeComment Comment
hi def link qmakeEscapedChar Special
hi def link qmakeQuotedString String
hi def link qmakeVarDecl Identifier
hi def link qmakeVarAssign String
hi def link qmakeVarValue PreProc
hi def link qmakeMacroParens PreProc
hi def link qmakeMacroArgs String
hi def link qmakeMacroComma PreProc
hi def link qmakeEnvValue PreProc
hi def link qmakePropValue PreProc
hi def link qmakeUserMacroDecl Keyword
hi def link qmakeUserMacroName Identifier
hi def link qmakeUserFuncDecl Keyword
hi def link qmakeUserFuncName Identifier
hi def link qmakeFuncReturn Keyword
hi def link qmakeFuncReturnArgs String
hi def link qmakeBuiltinVarName Type
hi def link qmakeBuiltinVarVal Special
hi def link qmakeBuiltinProp Special
hi def link qmakeBuiltinMacro Special
hi def link qmakeBuiltinFunc Function
hi def link qmakeScope Conditional

let b:current_syntax = "qmake"
