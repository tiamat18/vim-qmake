Qt project file syntax plugin for Vim
------
Forked from [askbriar/vim-qmake](https://github.com/arkbriar/vim-qmake),
which was itself a fork of 
[artoj/qmake-syntax-vim](https://github.com/artoj/qmake-syntax-vim)

Copyright (C) 2017 tiamat18 <tiamatX18@gmail.com>

Copyright (C) 2015-2016 ArkBriar <arkbriar@gmail.com>

Copyright (C) 2011-2012 Arto Jonsson <artoj@iki.fi>

###ABOUT

**qmake** is a Makefile generator used by the Qt toolkit.

The 'qmake.vim' file provides syntax coloring for qmake project files.

###INSTALLATION

Put the 'syntax/qmake.vim' file to your $VIMRUNTIME/syntax/ directory.
Then you can use:

```vim
:set syntax=qmake
```

To use the syntax in the current buffer.

To set the syntax automatically for certain file types, such as '.pro' in
this case, put the 'ftdetect/pro.vim' in $VIMRUNTIME/ftdetect/ directory.

See `:help ftdetect` for more information.

Alternatively you can use bundle manager such as Vundle or Pathogen.

