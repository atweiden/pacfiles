#!/bin/bash

# -----------------------------------------------------------------------------
# mkaurpkg: create new aur pkg with git clone
# -----------------------------------------------------------------------------

mkaurpkg() { git clone "git+ssh://aur@aur.archlinux.org/${1}.git"; }

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
