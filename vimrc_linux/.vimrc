set nocompatible
filetype on

let $VIMRUNTIME = "/usr/share/vim/vim82"
"let $TOOLS = $VIMRUNTIME . "\\tools"   " Add a whitespace for the sake of PATH concatenation. Must use escape char for special chars like slash etc
let $TOOLS = "/usr/bin"   " Add a whitespace for the sake of PATH concatenation. Must use escape char for special chars like slash etc
let $PATH = $PATH . ";" . $TOOLS

"let Tlist_Ctags_Cmd = $TOOLS . "\\ctags.exe"
let Tlist_Ctags_Cmd = $TOOLS . "//ctags"
let Tlist_Inc_Winwidth=0
let $PETER = Tlist_Ctags_Cmd
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

"set nu
set tags=./tags,./../tags,./../*/tags,./../../tags,./cscope.out
"set tags=.\tags,.\..\tags,.\..\*\tags,.\..\..\tags,.\cscope.out
:colorscheme desert

set expandtab           "insert a tab as spaces
set softtabstop=4       "set tab as 4 spaces, don't use tabstop!!
set bs=2                " allow backspacing over everything in insert mode
"set ai                  " always set autoindenting on
"if has("vms")
"  set nobackup         " do not keep a backup file, use versions instead
"else
"  set backup           " keep a backup file
"endif
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
fixdel                  " fix the delete button.
set noswf               " no swap file
set nowrap              " no word wrapping to see code clearly

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

if has("cscope")
"    set csprg=$TOOLS\cscope.exe
    set csprg=$TOOLS/cscope
"    set csto=0
"    set cst
"    set nocsverb
    " add any database in current directory
"    if filereadable("cscope.out")
"        colorscheme morning
"        cs add .\cscope.out
    " else add database pointed to by environment
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif
"    set csverb
endif


" Don't use Ex mode, use Q for formatting
map Q gq
map <F2> :Tlist<CR>
map <F3> :VTreeExplore<CR>
map <F5> <C-W><S->>     " decrease window width
map <F6> <C-w><S-<>     " increase window width
map <F9> :call MakeFullCscope()<CR>
"map <F9> :! scope.bat<CR>
map <F11> :call MakeExistingCscope()<CR><CR> :cs reset<CR><CR>
"map <F11> :! cscope -b -k<CR><CR> :cs reset<CR><CR>
map <F12> :cs add .<CR>
map <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
map <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
map <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
map <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
map <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
map <C-\>i :cs find i <C-R>=expand("<cword>")<CR><CR>
map <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
map <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
if has("unix") 
    map ,e :e <C-R>=expand("%:p:h") . "/"<CR> 
    cmap ,p <C-R>=expand("%:p:h")."/"<cr> 
else 
    map ,e :e <C-R>=expand("%:p:h") . "\\"<CR> 
    cmap ,p <C-R>=expand("%:p:h")."\\"<cr> 
endif 


" Make p in Visual mode replace the selected text with the "" register.
" vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
"  set number
  syn on
"  hi Comment ctermfg=blue
endif


if !exists("*MakeFullCscope")
    function! MakeFullCscope()
        :cs kill .
"        silent execute '!' . 'del .\cscope*'
"        silent execute '!' . 'dir/s/b/a:-d *.c *.cpp *.h *.s > .\cscope.files'
"        silent execute '!' . $TOOLS . '\cscope -b -k'
        silent execute '!' . 'rm ./cscope*'
        silent execute '!' . 'find $PWD -type f -name *.c -o -name *.cpp -o -name *.h -o -name *.s > ./cscope.files'
        silent execute '!' . $TOOLS . '/cscope -b -k'
        :cs add .
    endfunc
endif

if !exists("*MakeExistingCscope")
    function! MakeExistingCscope()
        :cs kill .
"        silent execute '!' . $TOOLS . '\cscope -b -k'
        silent execute '!' . $TOOLS . '/cscope -b -k'
        :cs add .
    endfunc
endif

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

if !exists("*ShowFunc") 
  function! ShowFunc() 
    let gf_s = &grepformat 
    let gp_s = &grepprg 
    if ( &filetype == "c" ) 
      let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --c-types=f --sort=no' 
    elseif ( &filetype == "perl" ) 
      let &grepformat='%*\k%*\ssubroutine%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --perl-types=s --sort=no' 
    elseif ( &filetype == "php" ) 
      let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --php-types=f --sort=no' 
    elseif ( &filetype == "python" ) 
      let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --python-types=f --sort=no' 
    elseif ( &filetype == "sh" ) 
      let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --sh-types=f --sort=no' 
    elseif ( &filetype == "vim" ) 
      let &grepformat='%*\k%*\sfunction!%*\s%l%*\s%f %m' 
      let &grepprg = 'ctags -x --vim-types=f --sort=no' 
    endif 
    if (&readonly == 0) | update | endif 
    silent! grep % 
    cwindow 
    redraw 
    let &grepformat = gf_s 
    let &grepprg = gp_s 
    set nu
  endfunc 
endif 

