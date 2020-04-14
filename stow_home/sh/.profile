# Profile file. Runs on login. Environmental variables are set here.

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export XDG_CONFIG_DIRS="/etc/xdg"

for File in "$HOME"/.config/sh/*; do
	. "$File"
done

# [ ! -f $HOME/.local/shortcuts/shortcuts ] && $HOME/.local/shortcuts/shortcuts >/dev/null 2>&1 &

# Start graphical server on tty1 if not already running.
if command -v startx > /dev/null 2>&1; then
	[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx
	# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
fi

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
