#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# # Start GNOME Keyring and export controls
# eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# feh
~/.fehbg

# Compositing
compton -b --config ~/.comptonrc

# activating extra fonts
xset +fp /usr/share/fonts/local
xset fp rehash

# Increase keyboard repeat rate
xset r rate 250 33

# Keyboard, activate numlock
xmodmap ~/.Xmodmap
numlockx &

# Load cursor before xmonad
xrdb ~/.Xresources &

# Inform java that we're using a tiling WM
export _JAVA_AWT_WM_NONREPARENTING=1

# Redshift
redshift &

# Remove the mouse after lack of use
unclutter -root -grab &

## Starts emacs server
# emacs --daemon &


# Run Xmonad
exec xmonad
