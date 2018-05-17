
set autoread 
"共享剪贴板  

set clipboard+=unnamed  


set autowrite

 
" 在处理未保存或只读文件的时候，弹出确认

"set confirm

set autoindent

set cindent

" Tab键的宽度

set tabstop=4

" 统一缩进为4

set softtabstop=4

set shiftwidth=4

" 不要用空格代替制表符

set noexpandtab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTags的设定  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Sort_Type = "name"    " 按照名称排序  

"let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  

let Tlist_Compart_Format = 1    " 压缩方式  

let Tlist_Exist_OnlyWindow = 1 "如果只有一个buffer，kill窗口也kill掉buffer  

let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  

let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  

autocmd FileType java set tags+=D:\tools\java\tags  
"let Tlist_Show_One_File=1    "不同时显示多个文件的tag，只显示当前文件的

" 映射全选+复制 ctrl+a

map <C-A> ggVGY

map! <C-A> <Esc>ggVGY




 
set nocompatible              " be iMproved, required
filetype off                  " required

let autosave=5 "auto back

"set autoread
"set autowriteall

:set mouse=a

set ts=4  "(注：ts是tabstop的缩写，设TAB宽4个空格)
set expandtab

set ci        " 开启cindent 
"set noet   " 关闭expandtab 
set sw=4 "shiftwidth=4

set shortmess+=A




map <F4> :TagbarToggle<CR>
"let g:tagbar_right = 1                                "在右侧                                              
"let g:tagbar_width = 25                               "设置宽度      
"autocmd VimEnter * nested :TagbarOpen
"let g:tagbar_ctags_bin = '/usr/bin/ctags'
"let g:tagbar_width = 30

autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  
"设置tagbar的窗口显示的位置,为左边  
"let g:tagbar_right=1  







:map <C-c> "+y
:map <C-v> "+p

map <s-tab> :bp<cr>
map <tab> :bn<cr>




"==========================================  
" show and format  
"==========================================  
"显示行号：  
set number  
set nowrap                    " 取消换行。  
""为方便复制，用<F2>开启/关闭行号显示:  
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>  


nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
syntax enable
syntax on
set t_Co=256

" colorscheme
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme monokai
 set hlsearch
set incsearch
colorscheme freya



filetype on
filetype plugin on
filetype indent on







"  "set tags+=/home/alps/kernel-3.10/tags
"set tags+=/home/Kernel_3.0.8_TQ210_for_Android_v1.0/tags

"你必须还要在目录的后面增加上一级目录，这样才能使用，具体为啥我也不知道
"  "cs add ./cscope.out .
"cs add /home/Kernel_3.0.8_TQ210_for_Android_v1.0/cscope.out /home/Kernel_3.0.8_TQ210_for_Android_v1.0/
"cs add /home/alps/kernel-3.10/cscope.out /home/alps/kernel-3.10
"  "cs add /home/alps/cscope.out /home/alps



"set cscopequickfix=s-,c-,d-,i-,t-,e-



map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

	


" nerdtree
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"autocmd BufRead *  25vsp  ./

"open vim in edit view
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w

nn <silent><F2> :exec("NERDTree ".expand('%:h'))<CR>





filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Plugin 'gmarik/vundle'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()
filetype plugin indent on     " required

" it can record the mouse postion when you close the file
 if has("autocmd")
 	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
   	\| exe "normal g'\"" | endif
 endif


"--------------------------------------------------------------------------------
" cscope:建立数据库：cscope -Rbq；  F5 查找c符号； F6 查找字符串；   F7 查找函数谁调用了，
"--------------------------------------------------------------------------------
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif


:set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>




"F5 查找函数谁调用了， F6 查找c符号； F6 查找字符串；   
nmap <silent> <F5> :cs find c <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR>
nmap <silent> <F6> :cs find s <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR> 
nmap <silent> <F7> :cs find t <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR>

"  自动加载ctags: ctags -R
if filereadable("tags")
      set tags=tags
endif



"set tags=tags;


"  自动保存 kernel 的ctags文件
if isdirectory("kernel/") && isdirectory("mm/")
	au BufWritePost *.c,*.h silent! !ctags -L tags.files&
	au BufWritePost *.c,*.h silent! !cscope -bkq -i tags.files&
endif

"--------------------------------------------------------------------------------
" global:建立数据库
"--------------------------------------------------------------------------------
if filereadable("GTAGS")
	set cscopetag
	set cscopeprg=gtags-cscope
	cs add GTAGS
	au BufWritePost *.c,*.cpp,*.h silent! !global -u &
endif


 "--------------------------------------------------------------------------------
 " QuickFix
 "--------------------------------------------------------------------------------
 nmap <F9> :cn<cr>   " 切换到下一个结果
 nmap <F10> :cp<cr>   " 切换到上一个结果

"cd ~/mysession   "这里加入你自己的目录地址  
"set sessionoptions-=curdir   
"set sessionoptions+=sesdir   
"autocmd VimLeave * mks! yy.vim    "这里可以加入你自己默认保存的文件

" #####YouCompleteMe Configure   
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  
" 自动补全配置  
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)  
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口  
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项  
 
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项  

let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全  

"在注释输入中也能补全  
let g:ycm_complete_in_comments = 1  
"在字符串输入中也能补全  
let g:ycm_complete_in_strings = 1  
"注释和字符串中的文字也会被收入补全  
let g:ycm_collect_identifiers_from_comments_and_strings = 0  
let g:clang_user_options='|| exit 0'  

" #####YouCompleteMe Configure   

"  ":inoremap ) ((<Esc>li          
"  ":inoremap ( ()<Esc>i  
"  ":inoremap { {}<Esc>i  
"  ":inoremap } {}<Esc>i  
"  ":inoremap [ []<Esc>i  
"  ":inoremap ] []<Esc>i  
"  ":inoremap < <><Esc>i  
"  ":inoremap > <><Esc>i  
"  ":inoremap " ""<Esc>i  
"  ":inoremap ' ''<Esc>i 
          

