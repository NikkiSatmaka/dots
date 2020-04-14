#
# ~/.bash_profile
#

[[ -f $HOME/.profile ]] && . $HOME/.profile
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
