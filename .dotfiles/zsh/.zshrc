# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# prompt
autoload -U colors && colors
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:*' unstagedstr " *"
zstyle ':vcs_info:*' stagedstr " +"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "(%b%u%c)"
add-zsh-hook precmd vcs_info
P_GIT="%F{7}${vcs_info_msg_0_}%f"
P_TIME="%F{15} %t %f"
export RPROMPT=$P_GIT$P_TIME
P_USER="%F{7}%K{5} %n %k%f"
P_HOST="%F{7}%K{5} %m %k%f"
P_DIR="%F{7}%K{6} %~ %k%f"
P_LEAD=$'\n ❱ '
export PROMPT="$P_HOST$P_DIR$P_LEAD"


# aliases
#alias ls='ls --color=auto' #Linux
alias ls='ls -G' #MacOS
alias ll='ls -l '
alias la='ls -a '
alias lt='lsd --tree '
alias g=git
alias gcm='git commit -m '
alias zc='$ZDOTDIR/.zshrc '
alias so='source ' 
alias ze='$HOME/.zshenv '
alias n='nvim '
alias v='vim '

# functions 
function update_ssh_keys(){
    ssh - keyscan -H -t rsa,dsa,ecdsa,ed25519 $(cat ~/.ssh/known_hosts | cut -d ' ' -f 1 | tr '\n' ' ') > ~/.ssh/known_hosts.new
    mv ~/.ssh/known_hosts.new ~/.ssh/known_hosts
}

autoload -Uz compinit && compinit
function globalias(){
    zle _expand_alias
    zle expand-word
    zle self-insert
}
zle -N globalias

function h() {
    #check if we passed any args
    if [ -z "$*" ]; then
        # if no args were passed, print entire history
        history 1
    else
        #if args passed
        history 1 | egrep --color=auto "$@"
    fi
}

function which(){
   (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot 
}

# keybinds
bindkey -M viins " " globalias
bindkey -M viins "^ " globalias
bindkey -M isearch " " magic-space

# history options
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

bash ~/.dotfiles/tty_themes/init_theme.sh
