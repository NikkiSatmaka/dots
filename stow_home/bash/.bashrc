#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1 Setup
# PS1='[\u@\h \W]\$ '
# PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
# PS1="\[\e[33m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$ "

shopt -s autocd		# Automatically cd into typed directory.
shopt -s checkwinsize		# Automatically cd into typed directory.

# Load aliases and shortcuts if existent.
[ -f "$HOME/.local/bin/shortcuts/shortcuts" ] && source "$HOME/.local/bin/shortcuts/shortcuts"
[ -f "$HOME/.local/bin/shortcuts/commands" ] && source "$HOME/.local/bin/shortcuts/commands"
[ -f "$HOME/.local/bin/shortcuts/zshnameddirs" ] && source "$HOME/.local/bin/shortcuts/zshnameddirs"

# [ -r /usr/share/bash-completion/bash_completion ] && . usr/share/bash-completion/bash_completion

# Set Vi mode in bash shell
set -o vi

# Starship Prompt
eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
