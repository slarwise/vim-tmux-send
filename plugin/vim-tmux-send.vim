" Send keys/commands from vim to other tmux panes.

if exists("g:loaded_vim_tmux_send") || !exists("$TMUX")
    finish
endif
let g:loaded_vim_tmux_send = 1

command! -nargs=1 SendKeys :call vimtmuxsend#send_keys(<args>)
command! SendMakeCmd :call vimtmuxsend#send_make_cmd()
command! SendLine :call vimtmuxsend#send_line()
