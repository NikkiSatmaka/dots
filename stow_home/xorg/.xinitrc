#!/bin/sh

# Sourcing xprofile from a session started with xinit
[ -f ~/.xprofile ] && . ~/.xprofile

exec bspwm
