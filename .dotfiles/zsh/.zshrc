eval "$(oh-my-posh init zsh --config ~/.dotfiles/omp/themes/wip.omp.json)"

# prompt
#autoload -U colors && colors
#P_USER="%F{187}%K{065} %n %k%f"
#P_DIR="%F{187}%K{066} %1~ %k%f"
#P_LEAD=$'\n \U2771 '
#export PROMPT=$P_USER$P_DIR$P_LEAD

# aliases
alias l='ls -l '
alias ll='ls -l'
alias la='ls -a '
alias lla='ls -la '
alias lt='lsd --tree '
alias g=git
alias gcm='git commit -m '
alias zc='$ZDOTDIR/.zshrc '
alias so='source ' 
alias ze='~/.zshenv '
alias n='nvim '
alias v='vim '

# functions 
function update_ssh_keys(){
    ssh - keyscan -H -t rsa,dsa,ecdsa,ed25519 $(cat ~/.ssh/known_hosts | cut -d ' ' -f 1 | tr '\n' ' ') > ~/.ssh/known_hosts.new
    mv ~/.ssh/known_hosts.new ~/.ssh/known_hosts
}

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
