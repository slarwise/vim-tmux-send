" Utility functions for working with tmux

if exists("g:loaded_vim_tmux_send") || !exists("$TMUX")
    finish
endif
let g:loaded_vim_tmux_send = 1

" command -nargs=1 TmuxClearLineAndSendKeysNextPane
"             \ :call TmuxClearLineAndSendKeysNextPane(<args>)
command SendMakeCmd :call SendMakeCmd()

" function! TmuxNextPaneExists()
"     let pane_count = str2nr(trim(system('tmux list-panes | wc -l')))
"     return pane_count > 1
" endfunction

" function! TmuxSendKeysNextPane(keys)
"     if TmuxNextPaneExists()
"         let cmd = 'tmux send-keys -t+ ' . a:keys
"         call system(cmd)
"     else
"         echohl WarningMsg | echo 'No other tmux pane exists' | echohl None
"     endif
" endfunction

" function! TmuxClearLineNextPane()
"     if TmuxNextPaneExists()
"         let cmd = 'C-u'
"         call TmuxSendKeysNextPane(cmd)
"     else
"         echohl WarningMsg | echo 'No other tmux pane exists' | echohl None
"     endif
" endfunction

" function! TmuxClearLineAndSendKeysNextPane(keys)
"     if TmuxNextPaneExists()
"         call TmuxClearLineNextPane()
"         call TmuxSendKeysNextPane(a:keys)
"     else
"         echohl WarningMsg | echo 'No other tmux pane exists' | echohl None
"     endif
" endfunction

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
    let keys = &makeprg . ' ENTER '
    call SendKeys(keys)
endfunction
