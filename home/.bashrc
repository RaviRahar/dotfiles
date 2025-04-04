# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

###################################
# Custom
###################################
source ~/.git_prompt.sh
GIT_PS1_SHOWDIRTYSTATE=false
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=verbose
# PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
BASH_PROMPT_SEPARATOR="" #  # 

if [ "$color_prompt" = yes ] && [ "$TERM" = "xterm-256color" ]; then
  PS1='\[\033[00m\]\n \w \[\033[03m\]$(__git_ps1 "(%s)") \n\[\033[01;38;5;238;48;5;109m\]   \[\033[00;38;5;109m\]${BASH_PROMPT_SEPARATOR}\[\033[00m\] '
elif [ "$TERM" = "foot" ]; then
  PS1='\[\033[00m\]\n \w \[\033[03m\]$(__git_ps1 "(%s)") \n\[\033[01;38;5;238;48;5;109m\]   \[\033[00;38;5;109m\]${BASH_PROMPT_SEPARATOR}\[\033[00m\] '
##########################################################fg;######bg#######################fg###########reset##
elif [ "$color_prompt" = yes ]; then
  PS1='\[\033[0om\]\n \w \[\033[03m\]$(__git_ps1 "(%s)") \n\[\033[00;46m\]    \[\033[00;36m\]${BASH_PROMPT_SEPARATOR}\[\033[00m\] '
else
  PS1='\n [\w] $(__git_ps1 "(%s)") \n\$ '
  PS1='\[\033[00m\]\n \w \[\033[03m\]$(__git_ps1 "(%s)") \n\[\033[01;38;5;238;48;5;109m\]   \[\033[00;38;5;109m\]${BASH_PROMPT_SEPARATOR}\[\033[00m\] '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}Bash:\w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

###################################
# FZF
###################################
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#source $HOME/.local/opt/fzf-obc/bin/fzf-obc.bash
#source $HOME/.local/opt/fzf-tab-completion/bash/fzf-bash-completion.sh
#bind -x '"\t": fzf_bash_completion'
#PROMPT_COMMAND="stty $(stty -g)"
#. "$HOME/.cargo/env"

###################################
# JDTLS NEOVIM JAVA COMPLETION
###################################
# export JDTLS_HOME=/usr/share/java/jdtls

####################################
## ANDROID-SDK
####################################
#export ANDROID_HOME=/opt/android-sdk
#export ANDROID_SDK_ROOT=/opt/android-sdk
#export ANDROID_NDK_HOME=/opt/android-ndk
#export PATH=$PATH:$ANDROID_HOME/platform-tools
##export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest
##export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
#export PATH=$PATH:$ANDROID_HOME/tools
#export PATH=$PATH:$ANDROID_HOME/tools/bin
#export PATH=$PATH:$ANDROID_HOME/emulator

#PATH=$ANDROID_HOME/emulator:$PATH

# export JAVA_HOME='/usr/lib/jvm/java-11-openjdk'
#export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

###################################
# Git
###################################
export GPG_TTY=$(tty)
export EDITOR=nvim

###################################
# Emacs
###################################
# export PATH=$PATH:$HOME/.emacs.d/bin
# export DOOMDIR=/home/user/.config/doom
# export DOOMLOCALDIR=/home/user/.emacs.r/local/

###################################
# General
###################################
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/scripts
cdrive="/run/media/shush/C"
ddrive="/run/media/shush/D"
edrive="/run/media/shush/E"
source ~/.bash_completion

# foot: open new window in current working dir
osc7_cwd() {
  local strlen=${#PWD}
  local encoded=""
  local pos c o
  for ((pos = 0; pos < strlen; pos++)); do
    c=${PWD:$pos:1}
    case "$c" in
    [-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
    *) printf -v o '%%%02X' "'${c}" ;;
    esac
    encoded+="${o}"
  done
  printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

# foot: jump to prompts (changes in ~/.inputrc too)
prompt_marker() {
  printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker
