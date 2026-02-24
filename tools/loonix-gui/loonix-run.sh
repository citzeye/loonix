#!/bin/bash

# Path ke binary manusiawi
APP="$HOME/loonix/tools/loonix-login/finishapp"

# Coba GUI
cage -s -- "$APP"

# Fallback ke TUI
if [ $? -ne 0 ]; then
    clear
    "$APP" --tui
fi