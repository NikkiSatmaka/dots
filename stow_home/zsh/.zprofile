#
# ~/.zprofile
#

[[ -f $HOME/.profile ]] && . $HOME/.profile

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
