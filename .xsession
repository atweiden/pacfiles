#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

/bin/bash --login -i "$HOME/.xinitrc"
