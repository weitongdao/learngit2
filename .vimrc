" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料

set nocompatible                                      "禁用 Vi 兼容模式
filetype off                                          "禁用文件类型侦测

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" 使用Vundle来管理Vundle，这个必须要有。
Bundle 'gmarik/vundle'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
Bundle 'a.vim'
Bundle 'Align'
Bundle 'jiangmiao/auto-pairs'
Bundle 'bufexplorer.zip'
"Bundle 'ccvext.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'Mark--Karkat'
Bundle 'Shougo/neocomplete'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'OmniCppComplete'
Bundle 'Lokaltog/vim-powerline'
Bundle 'msanders/snipmate.vim'
Bundle 'wesleyche/SrcExpl'
Bundle 'std_c.zip'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'ZoomWin'
"Bundle 'tpope/vim-markdown'
Plugin 'shawncplus/phpcomplete.vim'
" Bundle 'ctrlpvim/ctrlp.vim'
" Bundle 'cSyntaxAfter'
" Bundle 'javacomplete'
" Bundle 'vim-javacompleteex'               "更好的 Java 补全插件
" Bundle 'mattn/emmet-vim'
" Bundle 'fholgado/minibufexpl.vim'         "好像与 Vundle 插件有一些冲突
" Bundle 'Shougo/neocomplcache.vim'
" Bundle 'repeat.vim'
" Bundle 'ervandew/supertab'                "有时与 snipmate 插件冲突
 Bundle 'taglist.vim'
 Bundle 'TxtBrowser'
" Bundle 'Valloric/YouCompleteMe'
" Plugin 'exvim/ex-minibufexpl'                "exvim插件之一。修复BUG
Bundle 'WolfgangMehner/vim-plugins'
"Bundle 'Tabular'
Bundle 'godlygeek/tabular'
Bundle 'YankRing.vim'
Bundle 'Stormherz/tablify'
Bundle 'vim-voom/VOoM'
Bundle 'winmanager'
"Bundle 'vim-scripts/txt.vim' "这句会让:help产生错误
Bundle 'VimIM'
Bundle 'simplyzhao/cscope_maps.vim'
""Bundle 'itchyny/calendar.vim'
Bundle 'mattn/calendar-vim'
Bundle 'DrawIt'
Bundle 'vimwiki/vimwiki'
Bundle 'sk1418/HowMuch'
Bundle 'vim-scripts/VisIncr'
Bundle 'The-NERD-tree'
"Bundle 'vim-scripts/AutoClose'
Bundle 'yegappan/mru'
Bundle 'kien/ctrlp.vim'
Bundle 'ggreer/the_silver_searcher'
"L9 is requirement for FuzzyFinder
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'plasticboy/vim-markdown'
Bundle 'easymotion/vim-easymotion'
"Bundle 'tylingsoft/markdown-plus'
"Bundle 'suan/vim-instant-markdown'
"Bundle 'kannokanno/previm'
"Bundle 'iamcco/markdown-preview.vim'
"Bundle 'jiazhoulvke/MarkdownView'
"Bundle 'greyblake/vim-preview'
"Bundle 'waylan/vim-markdown-extra-preview'
"Bundle 'isnowfy/python-vim-instant-markdown'
"Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
"Bundle 'vim-latex/vim-latex'
"
"Bundle 'lervag/vimtex'
"Bundle 'ying17zi/vim-live-latex-preview'
"Bundle 'vim-scripts/latex-support.vim'
Bundle 'gerw/vim-latex-suite'
" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
" set foldmethod=marker                                "marker 折叠方式

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
"------------------------------自定义操作-----------------------------------------------
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rww :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"
" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
" set guifont=YaHei_Consolas_Hybrid:h10                 "设置字体:字号（字体名称空格用下划线代替）
set guifont=DejaVu_Sans_Mono:h14
set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
set gcr=a:block-blinkon0                              "禁止光标闪烁
" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
    winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif

" 设置代码配色方案
if g:isGUI
"    colorscheme Tomorrow-Night-Eighties               "Gvim配色方案
     " colorscheme molikai
     colorscheme solarized
else
    colorscheme Tomorrow-Night-Eighties               "终端配色方案
endif

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" -----------------------------------------------------------------------------
"  < 单文件编译、连接、运行配置 >
" -----------------------------------------------------------------------------
" 以下只做了 C、C++ 的单文件配置，其它语言可以参考以下配置增加
" F5编译QT程序-----------------------------------------------------------------
"map <F5> :call CompileRunQT5()<CR><CR><CR>
":copen<CR><CR><CR>
func! CompileRunQT5()
    exec "w"
    exec "!qmake -project QT+=widgets"
    exec "!qmake"
    exec "!make"
endfunc
"----------------------编译QT5--------------------------------------
func! CompileQt5()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc
" F9 一键保存、编译、连接存并运行
map <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    endif
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc
" -------------------------------php预览---------------------------------------
" -----------------------------------------------------------------------------
"  < 在浏览器中预览 Html 或 PHP 文件 >
" -----------------------------------------------------------------------------
" 修改前请先通读此模块，明白了再改以避免错误

" F5 加浏览器名称缩写调用浏览器预览，启用前先确定有安装相应浏览器，并在下面的配置好其安装目录
if g:iswindows
    "以下为只支持Windows系统的浏览器

    " 调用系统IE浏览器预览，如果已卸载可将其注释
    nmap <F5>ie :call ViewInBrowser("ie")<cr>
    imap <F5>ie <ESC>:call ViewInBrowser("ie")<cr>

    " 调用IETester(IE测试工具)预览，如果有安装可取消注释
    " nmap <F5>ie6 :call ViewInBrowser("ie6")<cr>
    " imap <F5>ie6 <ESC>:call ViewInBrowser("ie6")<cr>
    " nmap <F5>ie7 :call ViewInBrowser("ie7")<cr>
    " imap <F5>ie7 <ESC>:call ViewInBrowser("ie7")<cr>
    " nmap <F5>ie8 :call ViewInBrowser("ie8")<cr>
    " imap <F5>ie8 <ESC>:call ViewInBrowser("ie8")<cr>
    " nmap <F5>ie9 :call ViewInBrowser("ie9")<cr>
    " imap <F5>ie9 <ESC>:call ViewInBrowser("ie9")<cr>
    " nmap <F5>ie10 :call ViewInBrowser("ie10")<cr>
    " imap <F5>ie10 <ESC>:call ViewInBrowser("ie10")<cr>
    " nmap <F5>iea :call ViewInBrowser("iea")<cr>
    " imap <F5>iea <ESC>:call ViewInBrowser("iea")<cr>
elseif g:islinux
    "以下为只支持Linux系统的浏览器
    "暂未配置，待有时间再弄了
endif

"以下为支持Windows与Linux系统的浏览器

" 调用Firefox浏览器预览，如果有安装可取消注释
 nmap <F5>ff :call ViewInBrowser("ff")<cr>
 imap <F5>ff <ESC>:call ViewInBrowser("ff")<cr>

" 调用Maxthon(遨游)浏览器预览，如果有安装可取消注释
" nmap <F5>ay :call ViewInBrowser("ay")<cr>
" imap <F5>ay <ESC>:call ViewInBrowser("ay")<cr>

" 调用Opera浏览器预览，如果有安装可取消注释
" nmap <F5>op :call ViewInBrowser("op")<cr>
" imap <F5>op <ESC>:call ViewInBrowser("op")<cr>

" 调用Chrome浏览器预览，如果有安装可取消注释
" nmap <F5>cr :call ViewInBrowser("cr")<cr>
" imap <F5>cr <ESC>:call ViewInBrowser("cr")<cr>

" 浏览器调用函数
function! ViewInBrowser(name)
    if expand("%:e") == "php" || expand("%:e") == "html"
        exe ":update"
        if g:iswindows
            "获取要预览的文件路径，并将路径中的'\'替换为'/'，同时将路径文字的编码转换为gbk（同cp936）
            let file = iconv(substitute(expand("%:p"), '\', '/', "g"), "utf-8", "gbk")

            "浏览器路径设置，路径中使用'/'斜杠，更改路径请更改双引号里的内容
            "下面只启用了系统IE浏览器，如需启用其它的可将其取消注释（得先安装，并配置好安装路径），也可按需增减
            let SystemIE = "C:/progra~1/intern~1/iexplore.exe"  "系统自带IE目录
            " let IETester = "F:/IETester/IETester.exe"           "IETester程序目录（可按实际更改）
            " let Chrome = "F:/Chrome/Chrome.exe"                 "Chrome程序目录（可按实际更改）
            let Firefox = "D:/PortarbleStartup/yangguangheziFirefox/Firefox/firefox.exee"              "Firefox程序目录（可按实际更改）
            " let Opera = "F:/Opera/opera.exe"                    "Opera程序目录（可按实际更改）
            " let Maxthon = "C:/Progra~2/Maxthon/Bin/Maxthon.exe" "Maxthon程序目录（可按实际更改）

            "本地虚拟服务器设置，我测试的是phpStudy2014，可根据自己的修改，更改路径请更改双引号里的内容
            let htdocs ="F:/phpStudy2014/WWW/"                  "虚拟服务器地址或目录（可按实际更改）
            let url = "localhost"                               "虚拟服务器网址（可按实际更改）
        elseif g:islinux
            "暂时还没有配置，有时间再弄了。
        endif

        "浏览器调用缩写，可根据实际增减，注意，上面浏览器路径中没有定义过的变量（等号右边为变量）不能出现在下面哟（可将其注释或删除）
        let l:browsers = {}                             "定义缩写字典变量，此行不能删除或注释
        " let l:browsers["cr"] = Chrome                   "Chrome浏览器缩写
        let l:browsers["ff"] = Firefox                  "Firefox浏览器缩写
        " let l:browsers["op"] = Opera                    "Opera浏览器缩写
        " let l:browsers["ay"] = Maxthon                  "遨游浏览器缩写
        let l:browsers["ie"] = SystemIE                 "系统IE浏览器缩写
        " let l:browsers["ie6"] = IETester."-ie6"         "调用IETESTER工具以IE6预览缩写（变量加参数）
        " let l:browsers["ie7"] = IETester."-ie7"         "调用IETESTER工具以IE7预览缩写（变量加参数）
        " let l:browsers["ie8"] = IETester."-ie8"         "调用IETESTER工具以IE8预览缩写（变量加参数）
        " let l:browsers["ie9"] = IETester."-ie9"         "调用IETESTER工具以IE9预览缩写（变量加参数）
        " let l:browsers["ie10"] = IETester."-ie10"       "调用IETESTER工具以IE10预览缩写（变量加参数）
        " let l:browsers["iea"] = IETester."-al"          "调用IETESTER工具以支持的所有IE版本预览缩写（变量加参数）

        if stridx(file, htdocs) == -1   "文件不在本地虚拟服务器目录，则直接预览（但不能解析PHP文件）
           exec ":silent !start ". l:browsers[a:name] ." file://" . file
        else    "文件在本地虚拟服务器目录，则调用本地虚拟服务器解析预览（先启动本地虚拟服务器）
            let file = substitute(file, htdocs, "http://".url."/", "g")    "转换文件路径为虚拟服务器网址路径
            exec ":silent !start ". l:browsers[a:name] file
        endif
    else
        echohl WarningMsg | echo " please choose the correct source file"
    endif
endfunction
" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                              "设置无临时文件
" set vb t_vb=                                "关闭提示音


" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================
"----------------------PHP函数自动补全----------------------------------------
set dictionary-=$VIM/vimfiles/TXT/php_funclist.txt dictionary+=$VIM/vimfiles/TXT/php_funclist.txt
set complete-=k complete+=k
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
    set dictionary-=$VIM/vimfiles/TXT/php_funclist.txt dictionary+=$VIM/vimfiles/TXT/php_funclist.txt
    set complete-=k complete+=k
endfunction
" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < Align 插件配置 >
" -----------------------------------------------------------------------------
" 一个对齐的插件，用来——排版与对齐代码，功能强大，不过用到的机会不多

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
" 所以我就没有加入echofunc插件

" -----------------------------------------------------------------------------
"  < BufExplorer 插件配置 >
" -----------------------------------------------------------------------------
" 快速轻松的在缓存中切换（相当于另一种多个文件间的切换方式）
" <Leader>be 在当前窗口显示缓存列表并打开选定文件
" <Leader>bs 水平分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
" <Leader>bv 垂直分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件

" -----------------------------------------------------------------------------
"  < ccvext.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于对指定文件自动生成tags与cscope文件并连接
" 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
" 如果是Linux系统, 则生成的文件在~/.symbs/目录下
" 具体用法可参考www.vim.org中此插件的说明
" <Leader>sy 自动生成tags与cscope文件并连接
" <Leader>sc 连接已存在的tags与cscope文件

" -----------------------------------------------------------------------------
"  < cSyntaxAfter 插件配置 >
" -----------------------------------------------------------------------------
" 高亮括号与运算符等
"au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()
" -----------------------------------------------------------------------------
"  < ctrlp.vim 插件配置 >
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h ctrlp
" 常规模式下输入：Ctrl + p 调用插件
" -----------------------------------------------------------------------------
"  < emmet-vim（前身为Zen coding） 插件配置 >
" -----------------------------------------------------------------------------
" HTML/CSS代码快速编写神器，详细帮助见 :h emmet.txt

"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 在终端上会有屏幕刷新的问题，这个问题能解决有更好了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>

" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif

" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
" let g:indentLine_color_gui = '#A4E57E'

" -----------------------------------------------------------------------------
"  < Mark--Karkat（也就是 Mark） 插件配置 >
" -----------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt

" " -----------------------------------------------------------------------------
" "  < MiniBufExplorer 插件配置 >
" " -----------------------------------------------------------------------------
" " 快速浏览和操作Buffer
" " 主要用于同时打开多个文件并相与切换

"let g:miniBufExplMapWindowNavArrows = 1     "用Ctrl加方向键切换到上下左右的窗口中去
"let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
"let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强（不过好像只有在Windows中才有用）
" "                                            <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
" "                                            <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
" let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
" let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
" 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好
"
" <neocomplete 插件配置>
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 Ctrl-F8 调用插件
"nmap <C-F8> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -----------------------------------------------------------------------------
" 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
" 说明可以参考帮助或网络教程等
" 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
" 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
set completeopt=menu                        "关闭预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["_GLIBCXX_STD"]
" -----------------------------------------------------------------------------
"  < powerline 插件配置 >
" -----------------------------------------------------------------------------
" 状态栏插件，更好的状态栏效果

" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令

" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀

" -----------------------------------------------------------------------------
"  < SrcExpl 插件配置 >
" -----------------------------------------------------------------------------
" 增强源代码浏览，其功能就像Windows中的"Source Insight"
nmap <F3> :SrcExplToggle<CR>                "打开/闭浏览窗口


" -----------------------------------------------------------------------------
"  < std_c 插件配置 >
" -----------------------------------------------------------------------------
" 用于增强C语法高亮

" 启用 // 注视风格
let c_cpp_comments = 0

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
"  < Syntastic 插件配置 >
" -----------------------------------------------------------------------------
" 用于保存文件时查检语法

" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
"nmap tb :TlistClose<CR>:TagbarToggle<CR>

let g:tagbar_width=30                       "设置窗口宽度
" let g:tagbar_left=1                         "在左侧窗口中显示
let g:tagbar_sort = 0
" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

" 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
nmap tl :TagbarClose<CR>:Tlist<CR>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < txtbrowser 插件配置 >
" -----------------------------------------------------------------------------
" 用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
"au BufRead,BufNewFile *.txt setlocal ft=txt

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 常规模式下按快捷键 <c-w>o 在最大化与还原间切换
"-------------------------------------------------------------
"For Ycm
"-------------------------------------------------------------
"let g:ycm_global_ycm_extra_conf = '$VIM\vimfiles\bundle\YouCompleteMe\python\.ycm_extra_conf.py'
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 开启标签补全
let g:ycm_collect_identifiers_from_tags_files = 1
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
"离开插入模式后自动关闭预览窗口
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;
let g:ycm_key_invoke_completion = '<M-;>'
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
" 因为下面的这个if,本文件中的与Cscope_map.vim中都有，要注释掉一个，避免冲突错误提示
"""""""if has("cscope")
""""""    "设定可以使用 quickfix 窗口来查看 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-
""""""    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
"""""""    set cscopetag
""""""    "如果你想反向搜索顺序设置为1
"""""""    set csto=0
""""""    "在当前目录中添加任何数据库
"""""""    if filereadable("cscope.out")
"""""""        cs add cscope.out
""""""    "否则添加数据库环境中所指出的
"""""""    elseif $CSCOPE_DB != ""
"""""""        cs add $CSCOPE_DB
"""""""    endif
"""""""    set cscopeverbose
""""""    "快捷键设置
"""""""    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"""""""    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"""""""    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"""""""    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"""""""    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"""""""    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"""""""    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"""""""    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"""""""endif
"------grep工具配置------------------------------------------------------------
"定义快捷键关闭当前分割窗口
"nmap<Leader>q :q<CR>
"使用Grep.vim插件在工程内全局查找，设置快捷键。快捷键速记法：searchin project
nnoremap<Leader>sp :Grep<CR>
"使用Grep.vim插件在工程内全局查找，设置快捷键。快捷键速记法：searchin buffer
nnoremap <Leader>sbb :GrepBuffer -ir<CR><CR>
" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
set tags+=tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）
"set tags+=./addtags/qt5_h
"set tags+=./addtags/cpp_stl
"set tags+=./addtags/qt5_cpp
" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口，可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
if (g:iswindows && g:isGUI)
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" -----------------------------------------------------------------------------
"  < vimtweak 工具配置 > 请确保以已装了工具
" -----------------------------------------------------------------------------
" 这里只用于窗口透明与置顶
" 常规模式下 Ctrl + Up（上方向键） 增加不透明度，Ctrl + Down（下方向键） 减少不透明度，<Leader>t 窗口置顶与否切换
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "快捷键设置
    map <c-up> :call Alpha_add()<CR>
    map <c-down> :call Alpha_sub()<CR>
    map <leader>t :call Top_window()<CR>
endif
" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

" =============================================================================
"                     << windows 下解决 Quickfix 乱码问题 >>
" =============================================================================
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉

" if g:iswindows
"     function QfMakeConv()
"         let qflist = getqflist()
"         for i in qflist
"            let i.text = iconv(i.text, "cp936", "utf-8")
"         endfor
"         call setqflist(qflist)
"      endfunction
"      au QuickfixCmdPost make call QfMakeConv()
" endif

" =============================================================================
"                          << 其它 >>
" =============================================================================

" 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键
"
"
"
"""" =============================================================================
"                          << 自己的配置 >>
" =============================================================================
" 水平滚动
" 向左
"map <F7> 10zh
"imap <F7> <ESC>10zhi
" 向右
"map <F8> 10zl
"imap <F8> <ESC>10zli



set guicursor=i:ver1   "鼠标变形状"
"插入模式时是红色
au InsertLeave * hi Cursor guibg=red
"离开插入模式时是绿色
au InsertEnter * hi Cursor guibg=green

""""""""""""""""""""""""""""ctags的配置及使用"""
"http://blog.csdn.net/lhf_tiger/article/details/7216500
"""1 把ctags.exe放在gvim.exe同目录下（版本 > 5.6）;因为vim74已经加入系统变量，所以ctags.exe能够被cmd识别了
"""2 然后去你的源码目录, 如果你的源码是多层的目录, 就去最上层的目录(cmd，cd命令), 在该目录下运行命令: ctags -R

"""“”我现在以 vim71 的源码目录做演示
"""""""$ cd/home/wooin/vim71
"""""""$ ctags -R

"""""""此时在/home/wooin/vim71目录下会生成一个 tags 文件, 现在用vim打开/home/wooin/vim71/src/main.c
"""""""$ vim/home/wooin/vim71/src/main.c

"""""""再在vim中运行命令:
"set tags=/home/wooin/vim71/tags      "上面已经大神默认配置了ctags 和cscope所以不用自己加了
"""""""该命令将tags文件加入到vim中来, 你也可以将这句话放到~/.vimrc中去, 如果你经常在这个工程编程的话.



"""""""""""""""""""""Taglist配置与使用说明""""""""""""""
"http://blog.csdn.net/lhf_tiger/article/details/7216500
"""""""首先请先在你的~/.vimrc文件中添加下面两句:
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"""""""此时用vim打开一个c源文件试试:
"""""""$ vim~/vim/src/main.c
"""""""进入vim后用下面的命令打开taglist窗口, 如图5:
""""""":Tlist

""""""""""""""""""""""""""""""使用cscope"
"1、首先，我们要做的是生成cscope文件。
"Windows和Linux下都一样，首先定位到你的源代码所在的目录。如果你的源文件里只有.c和.h文件，那么运行下面的命令。
"1 cmd:
"cscope -Rbq
"就会生成cscope.out文件。
"
"==如果有.cpp的源文件，请参照下面的步骤。Windows在本文下面下载find.exe程序，暂时替代系统自带的find.exe程序。在源代码目录下运行如下的命令：
"==1 cmd:
"==find ./ -name "*.c" -o -name "*.cpp" -o -name "*.h" &gt;cscope.files
"==生成cscope.files后再运行命令：
"==1 cmd:
"==cscope -bq
"==就会生成三个文件，cscope.out以外的其他两个是加快索引的。
"2、在vimrc里配置cscope的使用
"首先，打开vimrc文件，这是vim的配置文件。不明白的请参见本系列的前面几篇文章。
"在vimrc文件里添加如下的语句：
"=================
"一：cmd:cd 源代码目录
"二：find ./ -name “*.cpp” –o “*.h” –o “*.c” –o >cscope.files
"三：cscope –bq
"四：其它vim:cs运用
"五：DONE
"=================

function Do_CsTags()
    if(executable("cscope") && has("cscope") )
        cs kill -1
        if(has('win32'))
            silent! execute "!dir /b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        else
            silent! execute "!find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files"
        endif
        silent! execute "!cscope -bq"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
        cs reset
    endif
endf
map <C-F12> :call Do_CsTags()<CR>
"
"cscope设置
"set cscopequickfix=s-,c-,d-,i-,t-,e-
"cs a c:\Users\JOHN_PC\Dropbox\c++\apra/cscope.out c:\Users\JOHN_PC\Dropbox\c++\aprae
"当然，你得把路径改成你自己的源代码路径。好了，在命令行里输入：
":cs f g boot
"就可以查看boot()这个函数的定义了。再输入:

"快捷配置
"nmap <C-_>s :cs find s =expand("") :cw    "查找声明
"nmap <C-_>g :cs find g =expand("") :cw     "查找定义
"nmap <C-_>c :cs find c =expand("") :cw    "查找调用
"nmap <C-_>t :cs find t =expand("") :cw    "查找指定的字符串
"nmap <C-_>e :cs find e =expand("") :cw    "查找egrep模式，相当于egrep功能，但查找速度快多了
"nmap <C-_>f :cs find f =expand("") :cw    "查找文件
"nmap <C-_>i :cs find i ^=expand("")$ :cw   "查找包含本文件的文件
"nmap <C-_>d :cs find d =expand("")  :cw   "查找本函数调用的函数
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"使用上面的快捷键的方法是，将光标定位到你要查找的变量，函数名或者宏定义名处。
"先按下Ctrl + shift + -，松开后快速按下相应的键，比如按下g，表示查找该函数或者变量的定义；
"按下c表示查找本函数被调用的地方。功能很强大。
"
"如： nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap 表示在vim的普通模式下，即相对于：编辑模块和可视模式，以下是几种模式
"        :map            普通，可视模式及操作符等待模式
"        :vmap           可视模式
"        :omap           操作符等待模式
"        :map!           插入和命令行模式
"        :imap           插入模式
"        :cmap           命令行模式
"<C-\>表示：Ctrl+\
"s表示输入(即按：s)s
": 表示输入':'
"“cs find s"表示输入"cs find s"也即是要输入的命令
"<C-R>=expand("cword")总体是为了得到：光标下的变量或函数。
"cword 表示：cursor word, 类似的还有：cfile表示光标所在处的文件名"
"
"
"
"""""""""""""""日历插件配制""""""""""""""""
let g:calendar_diary="$HOME\Dropbox\mywiki\calendar"
map calen :Calendar<cr>
let g:calendar_week_number=1
let g:calendar_task=1
""let g:calendar_google_calendar = 1
"""""""""""""""WiKi配置"""""""""""""""
"" vimwiki
let g:vimwiki_use_mouse = 1
""let g:vimwiki_list = {'path': 'd:/vimwiki/',
""\ 'path_html': 'd:/vimwiki/html/’,
""\ 'html_header': 'd:/vimwiki/template/header.htm',
""\ 'html_header': 'd:/vimwiki/template/footer.htm',
""\ 'css_name':'css/style.css',}
""最后3句分别指定了：
""– 存放Vimwiki文件的路径（Vimwiki的文件后缀为.wiki）
""– 从Vimwiki转换为Html网页时的保存路径；
""– Vimwiki转换网页时使用的网页模板的路径。
""set nocompatible
map <s-F4> :VimwikiAll2HTML<cr>
map <s-F5> :Vimwiki2HTMLBrowse<cr>
""let g:vimwiki_camel_case =0
""let g:vimwiki_hl_cb_checked=1
""let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,hl'
""map <leader>dd <Plug>VimwikiDeleteLink
""map <leader>rr <Plug>VimwikiRenameLink

let g:vimwiki_list = [{'path': '$HOME/Dropbox/mywiki/vimwiki-1/vimwiki/',
  \ 'path_html': '$HOME/Dropbox/mywiki/vimwiki_html/',
  \ 'html_header': '$HOME/Dropbox/mywiki/vimwiki_template/header.htm',
  \ 'html_footer': '$HOME/Dropbox/mywiki/vimwiki_template/footer.htm',
  \ 'diary_link_count': 5},
  \{'path': '$HOME/Dropbox/mywiki/vimwiki-2/vimwiki/'}]





"进行版权声明的设置
"添加或更新头
map <F4> :call TitleDet()<cr>'s
function AddTitle()
    call append(0,"///*=============================================================================")
    call append(1,"//#")
    call append(2,"//# Author:  Chow Shilve")
    call append(3,"//#")
    call append(4,"//# Contects:QQ-893801252, Email-yhft08@sina.com")
    call append(5,"//#")
    call append(6,"//# Last modified:  ".strftime("%Y-%m-%d %H:%M"))
    call append(7,"//#")
    call append(8,"//# Filename:       ".expand("%:t"))
    call append(9,"//#")
    call append(10,"//# Description:     ")
    call append(11,"//#")
    call append(12,"//=============================================================================*/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    "默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^\/\/\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction


"""TxtBrowser配置
"安装TxtBrowser前，请先安装Taglist, 因为Txt需要借助它生成目录树
"
"设置打开txt自动加载颜色，不必再手动写:set ft=txt
"syntax on
"filetype plugin on
au BufEnter *.txt setlocal ft=txt

"""Tabular配置
"let mapleader=','
    if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
    endif
"自动对齐，很好
"注意输入格式
"－－－－正确示例(前个和最后都要有|)
"|1|2|3|
"|12 |34|56|
"－－－－错误示例
"1|2|3
"12 | 34|56
"－－－－
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction



"==================打开文件目录NERDTree====
"vim；输入：NERDTree ，回车。
" 设置NerdTree
map <C-F6> :NERDTreeMirror<CR>
map <C-F6> :NERDTreeToggle<CR>

"""==========自己配置的mingw
"定义CompileRun函数，用来调用进行编译和运行
"func CompileRun()
"exec "w"
""C程序
"if &filetype == 'c'
"exec "!gcc -Wall -enable-auto-import % -g -o %<.exe"
""c++程序
"elseif &filetype == 'cpp'
"exec "!g++ -Wall -enable-auto-import  % -g -o %<.exe"
""Java程序
"elseif &filetype == 'java'
"exec "!javac %"
"endif
"endfunc
""结束定义CompileRun
""定义Run函数
"func Run_g()
"if &filetype == 'c' || &filetype == 'cpp'
"exec "!%<.exe"
"elseif &filetype == 'java'
"exec "!java %<"
"endif
"endfunc
""定义Debug函数，用来调试程序
"func Debug()
"exec "w"
""C程序
"if &filetype == 'c'
"exec "!gcc % -g -o %<.exe"
"exec "!gdb %<.exe"
"elseif &filetype == 'cpp'
"exec "!g++ % -g -o %<.exe"
"exec "!gdb %<.exe"
""Java程序
"elseif &filetype == 'java'
"exec "!javac %"
"exec "!jdb %<"
"endif
"endfunc
""结束定义Debug
""设置程序的运行和调试的快捷键F5和Ctrl-F5
"map <F5> :call CompileRun()<CR>
"map <F6> :call Run_g()<CR>
"map <C-F5> :call Debug()<CR>


"""""Parenquote".vim
" Vim plugin to create parenthesizing, bracketing, and quoting operators
" Maintainer:   Tim Pope <vimNOSPAM@tpope.info>
" GetLatestVimScripts: 1545 1 :AutoInstall: parenquote.vim
" $Id: parenquote.vim,v 1.4 2006/08/18 20:11:58 tpope Exp $

" This plugin uses Vim 7's new |:map-operator| feature to create mappings for
" enquoting and parenthesizing text.  Pick your desired operation and follow
" it with any motion of your choosing.  For example, to parenthesize from the
" cursor to the end of the line, use \($ .  To quote the word under the
" cursor, you can do \"iw .
"
" There are also visual mode mappings: V\{ puts the whole line in { }.  It
" works by entering visual line mode (thus selecting the entire line), and
" then activating the mapping.  These visual mode mappings are available in
" older versions of Vim, too.
"
" The default mappings are as follows (<Leader> is typically backslash):
"
"  <Leader>( => (text)
"  <Leader>{ => {text}
"  <Leader>[ => [text]
"  <Leader>< => <text>
"  <Leader>' => 'text'
"  <Leader>" => "text"
"  <Leader>` => `text`
"
" To disable the built-in mappings, put the following in your .vimrc:
"
"  let g:parenquote_no_mappings = 1
"
" Creating your own mappings is simple.  Create a new file called
" ~/.vim/after/plugins/parenquote.vim and put your mappings in it.  To create
" a g< mapping to enclose text <like this>, you add something like the
" following:
"
"  ParenquoteMap g< < >
"
" Of course, g< could actually become a a built-in vim command sometime in the
" future, so you might not want to use that.  Instead, you can start your
" mappings with <Leader>.  A handy shortcut for this is provided.  Both of the
" following produce a <Leader>/ mapping for creating regexes:
"
"  ParenquoteMap <Leader>/ / /
"  ParenquoteMap!        / / /
"
" You can also create mappings local to a buffer.  This is most useful in
" autocmds.
"
"  autocmd FileType perl,ruby ParenquoteMapLocal <LocalLeader>/ / /
"  autocmd FileType perl,ruby ParenquoteMapLocal!             / / /
"
" Remember, this plugin is still in development and the interface is subject
" to change.  Good luck and enjoy parenquote!

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if exists("g:loaded_parenquote") || &cp
  finish
endif
let g:loaded_parenquote = 1
let s:keepcpo = &cpo
set cpo&vim

function! <SID>DoSurround(type,beg,end)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  let common_end = "`>a" . a:end . "\<Esc>`<i" . a:beg . "\<Esc>`["
  if strlen(a:type) == 1  " Invoked from Visual mode
    silent exe "normal! " . common_end
  elseif a:type == 'line'
    silent exe "normal! '[V']V" . common_end
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]\<C-V>" . common_end
  else
    silent exe "normal! `[v`]v" . common_end
  endif
  let &selection = sel_save
  let @@ = reg_save
endfunction

function! s:escstr(str)
  return substitute(a:str,"[\\\"]","\\\\\\0","g")
endfunction


if version >= 700
  function! ParenQuoteDoSurround(type) dict
    return s:DoSurround(a:type,self.begin,self.end)
  endfunction
endif

if version >= 700
  if !exists("s:ID")
    let s:ID = 0
  endif
  function! s:FunctionFactory(beg,end)
    let s:ID = s:ID + 1
    let s:ParenBegin{s:ID} = a:beg
    let s:ParenEnd{s:ID}   = a:end
    function! s:ParenFunc{s:ID}(type)
      try
        ^ " raise error
      catch
        let throwpoint = v:throwpoint
      endtry
      let id = matchstr(throwpoint,'\C_ParenFunc\zs\d\+')
      return s:DoSurround(a:type,s:ParenBegin{id},s:ParenEnd{id})
    endfunction
    return "<SID>ParenFunc".s:ID
  endfunction
endif

function! s:ParenquoteMap(bang,map,beg,end)
  if a:bang
    let amap = "<Leader>" . a:map
  else
    let amap = a:map
  endif
  if version >= 700
    let funcname = s:FunctionFactory(a:beg,a:end)
    exe "nnoremap <silent> ".amap." :set opfunc=".funcname."<CR>g@"
  endif
  exe "vnoremap <silent> ".amap." :<C-U>call <SID>DoSurround(visualmode(),\"".s:escstr(a:beg)."\",\"".s:escstr(a:end)."\")<CR>"
endfunction

function! s:ParenquoteMapLocal(bang,map,beg,end)
  if a:bang
    let amap = "<LocalLeader>" . a:map
  else
    let amap = a:map
  endif
  if version >= 700
    let funcname = s:FunctionFactory(a:beg,a:end)
    exe "nnoremap <silent> <buffer> ".amap." :set opfunc=".funcname."<CR>g@"
  endif
  exe "vnoremap <silent> <buffer> ".amap." :<C-U>call <SID>DoSurround(visualmode(),\"".s:escstr(a:beg)."\",\"".s:escstr(a:end)."\")\<CR>"
endfunction

command! -bang -nargs=+ ParenquoteMap      call s:ParenquoteMap(<bang>0,<f-args>)
command! -bang -nargs=+ ParenquoteMapLocal call s:ParenquoteMapLocal(<bang>0,<f-args>)

function! s:Init()
  if !exists("g:parenquote_no_mappings")
    ParenquoteMap! ( ( )
    ParenquoteMap! { { }
    " } "<-- Syntax highlighting fix, for older versions of Vim
    ParenquoteMap! [ [ ]
    ParenquoteMap! < < >
    ParenquoteMap! ' ' '
    ParenquoteMap! " " "
    ParenquoteMap! ` ` `
  ParenquoteMap! = = =
  endif
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

call s:Init()


""""YankRing"""
nnoremap <silent> <F7> :YRShow<CR>

"""设置默认启动工作目录
"方便写程序时，:e 新建文件名.cpp
"方便写程序时，:.w !cmd
"相当于命令模式切换目录（:cd c:\Users\Administrator\OneDrive\c++\apra）
"cd $HOME\OneDrive\c++\apra
cd $HOME\SkyDrive\c++\apra
"Change work dir to current dir
"autocmd BufEnter * cd %:p:h

""" 带入当前行至cmd运行
":sh
":!cmd
":!start cmd
":.w !cmd
nnoremap <C-F7> :.w !cmd<CR>
nnoremap <S-F7> :r !cmd<CR>


"""MRU插件配置
"记录历史文件的位置
"let MRU_File=$VIM.'\Data\mru_files.txt'
"记录的条数
let MRU_Max_Entries=100
"分割窗口的大小
let MRU_Window_Height=10
"选择文件后打开此窗口自动关闭
let MRU_Auto_Close=1
"简化：,h 打开MRU
map <silent> <leader>hh :MRU<CR>

"""vim显示命令行：conque_2.2.zip
nnoremap <Leader>cmd :ConqueTermTab cmd<CR>

"""ctrlp集成ag.vim配置
map <leader>fk :CtrlP <CR>
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

  let g:ctrlp_switch_buffer = 'Et'
  let g:ctrlp_tabpage_position = 'ac'
  let g:ctrlp_open_multiple_files = 'tjr'
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
  let g:ctrlp_regexp = 1

"""tagbar的非Bundle安装与配置
"1 下载tagbar.vmb于电脑，http://www.vim.org/scripts/script.php?script_id=3465
"2 用gvim打开tagbar.vmb
"3 命令:so% <enter>
"4 Done
nmap <C-F8> :TagbarToggle<CR>
"let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

"""复制文件名字
" 奇怪必须要带走命令栏命令才复制有用，加：i<Esc> 什么也不做,而且句末不能有空格，不然带了折叠提示。
" 半名
nmap <F12> :let @"=expand("%:t")<CR>i<Esc>
"全名
"nmap <F12> :let @"=expand("%")<CR>i<Esc>

"保存文件时自动删除行尾空格或Tab
au BufWritePre * sil %s/\s\+$//e
"自动为文件加上最后修改时间
au BufWritePre * exe 'sil! 1,' . min([line('$'), 20]) . 's/^\S\+\s\+Last modified: \zs.*/\=strftime("%y-%m-%d %H:%M:%S")/e'
"删除文件尾多余的空行
au BufWritePre * %s/^$\n\+\%$//ge

"""把标签改成简短文件名
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction

set guitablabel=%{ShortTabLabel()}

"""vimIM设置
"设置不明宽度符号为2，以正确显示（要在utf-8下才有效）
   autocmd BufEnter *.txt set ambiwidth=double
let g:vimim_insertmode_toggle=1
set pastetoggle=<C-H>

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.

""""""""""""""""""""""""""""""
" FuzzyFinder
""""""""""""""""""""""""""""""
map <silent> <leader>bb :FufBuffer<CR>
map <silent> <leader>bl :FufLine<CR>
map <silent> <leader>bf :FufFile<CR>
":FufBuffer
":FufFile
":FufCoverageFile
":FufDir
":FufMruFile
":FufMruCmd
":FufBookmarkFile
":FufBookmarkDir
":FufTag
":FufBufferTag
":FufTaggedFile
":FufJumpList
":FufChangeList
":FufQuickfix
":FufLine
":FufHelp

""""""""""""""""""""""""""""""
" Insert_Enter
""""""""""""""""""""""""""""""
map <leader>p a<CR><Esc>


""""""""""""""""""""""""""""""
" switch splict windows( :vs, :sp )
""""""""""""""""""""""""""""""
nmap <silent> <Leader>q <C-W><left>
nmap <silent> <Leader>l <C-W><right>
nmap <silent> <Leader>k <C-W><up>
nmap <silent> <Leader>j <C-W><down>

""""""""""""""""""""""""""""""
" set linespace
""""""""""""""""""""""""""""""
set linespace=6

""""""""""""""""""""""""""""""
" 让光标停留在中央，固定视觉的重点/编辑区域：
""""""""""""""""""""""""""""""
"autocmd! CursorMoved * normal zz
"set scrolloff=10
set scrolloff=999

""""""""""""""""""""""""""""""
" C-N for dictionary
""""""""""""""""""""""""""""""
set dictionary-=$VIMRUNTIME/dict/engspchk.txt dictionary+=$VIMRUNTIME/dict/engspchk.txt
set complete-=k complete+=k

""""""""""""""""""""""""""""""
" set for neocomplete
""""""""""""""""""""""""""""""
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6
let g:neocomplete#enable_insert_char_pre = 1
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions',
    \ 'txt' : $VIMRUNTIME.'/dict/txt.dic'
    \ }


""""""""""""""""""""""""""""""
" iamcco/markdown-preview.vim
""""""""""""""""""""""""""""""
"let g:mkdp_path_to_chrome = "c:\Program Files\Google\Chrome\Application\chrome.exe"
"    " path to the chrome or the command to open chrome(or other modern browsers)
"
"    let g:mkdp_auto_start = 1
"    " set to 1, the vim will open the preview window once enter the markdown
"    " buffer
"
"    let g:mkdp_auto_open = 1
"    " set to 1, the vim will auto open preview window when you edit the
"    " markdown file
"
"    let g:mkdp_auto_close = 1
"    " set to 1, the vim will auto close current preview window when change
"    " from markdown buffer to another buffer
"
"    let g:mkdp_refresh_slow = 0
"    " set to 1, the vim will just refresh markdown when save the buffer or
"    " leave from insert mode, default 0 is auto refresh markdown as you edit or
"    " move the cursor

""""""""""""""""""""""""""""""
" latex-1st
""""""""""""""""""""""""""""""

    " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
    filetype plugin on

    " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
    " can be called correctly.
    set shellslash

    " IMPORTANT: grep will sometimes skip displaying the file name if you
    " search in a singe file. This will confuse Latex-Suite. Set your grep
    " program to always generate a file-name.
    set grepprg=grep\ -nH\ $*

    " OPTIONAL: This enables automatic indentation as you type.
    filetype indent on

    " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
    "
    "let g:tex_flavor='latex'
    let g:tex_flavor='xelatex'
    "
    let g:Tex_DefaultTargetFormat='pdf'
    "
    "let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
    "因为形状包\usepackage{pstricks} 只能用xelatex方式编译，和用下面的
    let g:Tex_CompileRule_pdf = 'xelatex --synctex=-1 --src-specials -interaction=nonstopmode $*'
    "
    "let g:Tex_ViewRule_pdf = 'sumatrapdf -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\"" '
    "let g:Tex_ViewRule_pdf = 'sumatrapdf -reuse-instance -inverse-search "d:\gvim-pro\vim74\gvim -c \":RemoteOpen +\%l \%f\"" '
    let g:Tex_ViewRule_pdf = 'd:\gvim-pro\user_tools\SumatraPDF\SumatraPDF.exe -reuse-instance -inverse-search "d:\gvim-pro\vim74\gvim.exe -c\":RemoteOpen +\%l \%f\"" '

    " this is mostly a matter of taste. but LaTeX looks good with just a bit
    " of indentation.
    autocmd BufEnter *.tex set sw=2

    " TIP: if you write your /label's as /label{fig:something}, then if you
    " type in /ref{fig: and press <C-n> you will automatically cycle through
    " all the figure labels. Very useful!
    set iskeyword+=:
