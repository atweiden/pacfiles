#!/bin/bash

# -----------------------------------------------------------------------------
# qrshow: create and display QR code with qrencode
#
# Credit: https://news.ycombinator.com/item?id=5332843
# -----------------------------------------------------------------------------

qrshow() { qrencode -s 10 "$1" -o - | "$VIEWER" - ; }

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
