#!/bin/sh
alias cls="clear -x"
alias ls="ls -F --color=auto"
alias su="su -"
alias IP='(ip route get 8.8.8.8 | cut -d " " -f 7 |xargs)'
alias pd="pushd > /dev/null"
alias pp="popd > /dev/null"
alias dl="dirs -v"

alias dmpv="devour mpv"
alias dimvr="devour imvr"
alias dnemo="devour nemo"

alias op="xdg-open"

alias fur_elise="mpv --no-video --loop https://www.youtube.com/watch?v=s71I_EWJk7I"
