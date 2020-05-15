# $Id: .zshrc,v 1.1 2007/10/27 19:05:57 dope Exp $
#
# README!
#
# Filename       : ~/.zshrc
# Purpose        : setup file for the shell 'zsh'
# Author         : Christian Schneider <strcat@gmx.net>
# Homepage       : http://www.strcat.de/zsh/
# Latest release : <http://strcat.de/dotfiles/#zsh>
#
# Structure of this file:
#  Lines starting with '#' are comments.
#
# Take a quick (haha) look on zshbuiltins(1), zshcompwid(1),
# zshcompsys(1), zshcompctl(1), zshexpn(1), zshmisc(1), zshmodules(1),
# zshoptions(1), zshparam(1), zshzle(1) or - for hardliner -
# zshall(1).
#
# ,----[ man -k zsh ]
# |
# | zsh (1)              - the Z shell
# | zshall (1)           - the Z shell meta-man page
# | zshbuiltins (1)      - zsh built-in commands
# | zshcalsys (1)        - zsh calendar system
# | zshcompctl (1)       - zsh programmable completion
# | zshcompsys (1)       - zsh completion system
# | zshcompwid (1)       - zsh completion widgets
# | zshcontrib (1)       - user contributions to zsh
# | zshexpn (1)          - zsh expansion and substitution
# | zshmisc (1)          - everything and then some
# | zshmodules (1)       - zsh loadable modules
# | zshoptions (1)       - zsh options
# | zshparam (1)         - zsh parameters
# | zshroadmap (1)       - informal introduction to the zsh manual
# | zshtcpsys (1)        - zsh tcp system
# | zshzftpsys (1)       - zftp function front-end
# | zshzle (1)           - zsh command line editor
# `----
#
# # Zsh start up sequence:
#  1) /etc/zshenv   -> Always run for every zsh.   (login + interactive + other)
#  2)   ~/.zshenv   -> Usually run for every zsh.  (login + interactive + other)
#  3) /etc/zprofile -> Run for login shells.       (login)
#  4)   ~/.zprofile -> Run for login shells.       (login)
#  5) /etc/zshrc    -> Run for interactive shells. (login + interactive)
#  6)   ~/.zshrc    -> Run for interactive shells. (login + interactive)
#  7) /etc/zlogin   -> Run for login shells.       (login)
#  8)   ~/.zlogin   -> Run for login shells.       (login)
#
# Last modified: [ 2008-11-25 00:26:47 ]
#
#
# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT
# EDITING!
#
# This file is based on ideas of:
#  Michael Prokop: <http://www.michael-prokop.at/computer/config/.zshrc>
#  Marijan Peh...: <http://free-po.hinet.hr/MarijanPeh/files/zshrc>
#  Adam Spiers...: <http://adamspiers.org/computing/shells/>
#
# Tested and used under {Net,Open}BSD, Slackware, Gentoo, Debian and LFS
# with Zsh 4.0.7, 4.0.9, 4.1.1, 4.2.0. 4.2.1, 4.2.4, 4.2.5, 4.2.6 and
# 5.0.0
#
# Login shell? If you want to know, you can type the following which will
# do nothing it's a login shell or warn you if not.
#--------------------------------------------------
# if [[ ! -o login ]]; then
#         print "Warning: It is *not* a login-Shell\!"
# fi
#--------------------------------------------------

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Load aliases and shortcuts if existent.
[ -f "$XDG_CONFIG_HOME/shortcuts/aliases" ] && source "$XDG_CONFIG_HOME/shortcuts/aliases"
[ -f "$XDG_CONFIG_HOME/shortcuts/zshnameddirs" ] && source "$XDG_CONFIG_HOME/shortcuts/zshnameddirs"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -l\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
