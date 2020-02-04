# Vim-tmux-send

A plugin that lets you send text or commands from Vim/Neovim to the next tmux
pane. A minimal plugin inspired by
[vim-slime](https://github.com/jpalardy/vim-slime). Some use cases are

- Running/compiling the current vim buffer in the next tmux pane.
- Sending some text from your vim buffer to a REPL, e.g. an interactive python
  shell to quickly test part of your code.

## Installation

Use your preferred installation method for Vim plugins. With vim-plug you would
put something like the following in your vimrc:

```
call plug#begin('~/.vim/plugged')
    Plug 'slarwise/vim-tmux-send'
call plug#end()
```

## Usage

The following commands and functions are available:

- Function `SendSelection`. Takes a motion and sends the text covered by the
  motion to the next tmux pane and executes it.
- Command `SendMakeCmd`. Executes `makeprg` for the current buffer in the next
  tmux pane.
- Command `SendLine`. Sends and executes the current line in the next tmux pane.
- Command `SendKeys`. Takes a string as argument and sends that string to the
  next tmux pane. Useful for making your own commands.

The `SendKeys` command is used by all the other sommands to do the actual
sending of text so have a look at the code if you want to write your own
commands. For example, to execute `ls` in the next pane you could write
`:SendKeys "ls ENTER"`. Tmux has some special keywords, `ENTER` being one of
them which emulates pressing the enter key.

## Mappings and examples

vim-tmux-send does not come with any mappings but here is an example.

- `nnoremap <LEADER>sm :SendMakeCmd<CR>`
- `nnoremap <LEADER>ss :SendLine<CR>`
- `nnoremap <LEADER>s :set operatorfunc=SendSelection<CR>g@`

The last mapping takes a motion and sends the corresponding text. See `:h g@`
and `:h operatorfunc` for more information on how this works. With the above
mapping, pressing `<LEADER>sj` sends the current line and the line below,
`<LEADER>sap` sends the current paragraph and `<LEADER>siw` sends the current
word. Just use your regular vim motions.

## Improvements

Right now the tmux pane that the text is sent to is hard coded to be the next
pane, and if there is only one pane open an error message is given. A variable
for setting which pane to send to could be good. Visually selecting text and
sending is not supported at the moment, that shouldn't be too hard to implement.
