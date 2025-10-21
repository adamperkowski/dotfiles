autoload -Uz select-word-style
select-word-style bash

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

stty -ixon # disable flow control to avoid conflicts
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

bindkey '^W' backward-kill-word
bindkey '^D' kill-word

bindkey '^U' backward-kill-line
bindkey '^K' kill-line

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

bindkey '^[[3~' delete-char
