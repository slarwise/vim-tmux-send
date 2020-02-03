" Send keys/commands from vim to other tmux panes.

if exists("g:loaded_vim_tmux_send") || !exists("$TMUX")
    finish
endif
let g:loaded_vim_tmux_send = 1

command! -nargs=1 SendKeys :call SendKeys(<args>)
command! SendMakeCmd :call SendMakeCmd()
command! SendLine :call SendLine()

function! SendKeys(keys)
    let pane_count = str2nr(trim(system('tmux list-panes | wc -l')))
    if pane_count > 1
        let cmd = 'tmux send-keys -t+ ' . a:keys
        call system(cmd)
    else
        echohl WarningMsg | echo 'No other tmux pane exists' | echohl None
    endif
endfunction

function! SendMakeCmd()
    let make_list = split(&makeprg)
    let make_cmd = map(make_list, 'expand(v:val)')
    let make_cmd = join(make_cmd, ' SPACE ')
    let keys = make_cmd . ' ENTER'
    call SendKeys(keys)
endfunction

function! SendLine()
    let current_line = getline('.')
    let current_line = substitute(current_line, ' ', ' SPACE ', 'g')
    let keys = current_line . ' ENTER'
    call SendKeys(keys)
endfunction
