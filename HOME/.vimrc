"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"     chenpeng08@baidu.com
"
" Adress:
"     https://github.com/smwyzi/LinuxEnv
"
" Brief:
"     -> all in one vimrc
"     -> graceful default configs, easy to use out-of-the-box
"     -> auto install plugins, even include plugin manager itself
"
" Sections:
"     -> Plugin
"     -> Dispaly
"     -> KeyBindings
"     -> Others
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" plug list
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/LeaderF'
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
"Plug 'tpope/vim-unimpaired'
Plug 'skywind3000/asyncrun.vim'

Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'

Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'fatih/vim-go'
call plug#end()

""" set leader key
let mapleader = ','

""" plug settings
"" NERDTree
nmap <F1> :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeFind<CR>
"" show hidden file
let NERDTreeShowHidden=1
"" hide help menu
let NERDTreeMinimalUI=1
"" close vim if NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" tagbar
nmap <F2> :TagbarToggle<CR>
"set tags=./.tags;,.tags
set autochdir

"" gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
 endif

"" LeaderF
let g:Lf_ShortcutF = '<c-p>'
noremap <leader>m :LeaderfMru<cr>
noremap <leader>b :LeaderfBuffer<cr>
noremap <leader>f :LeaderfFunction<cr>
noremap <leader>t :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

"" AsyncRun
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun g++ --std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"" ycm
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_complete_in_strings=1
"let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
"noremap <c-z> <NOP>
nnoremap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

"" ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

"" solarized
syntax enable
set background=dark
colorscheme solarized

"" lightline
set laststatus=2
set noshowmode

"" go
let g:go_version_warning = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set cc=100
set wrap
set hlsearch
set incsearch

"" tabs
set expandtab                   " expand tab to spaces
set tabstop=2                   " press tab will generate four spaces
set shiftwidth=2                " shift by four spaces
set softtabstop=2               "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => KeyBindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" paste mode
set pastetoggle=<F12>

"" better window switch
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <C-L> <C-W>l<C-W>
map <C-H> <C-W>h<C-W>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Others
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
set updatetime=100
set backspace=2

"" jump to last position when vim start
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre * :call CleanExtraSpaces()
endif

