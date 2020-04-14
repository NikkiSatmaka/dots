#
# ~/.zprofile
#

[[ -f $HOME/.profile ]] && . $HOME/.profile
[[ -f $ZDOTDIR/.zshrc ]] && . $ZDOTDIR/.zshrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
