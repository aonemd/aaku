#!/usr/bin/env bash

TERM_APP_PATH="/Applications/Alacritty.app/Contents/MacOS/alacritty"
TERM_APP_NAME="Alacritty"

# detects if TERM_APP_NAME is running
if ! pgrep -f $TERM_APP_NAME > /dev/null 2>&1; then
    open -a $TERM_APP_PATH
else
    # create a new window
    script="tell application $TERM_APP_NAME to create window with default profile"
    ! osascript -e "${script}" > /dev/null 2>&1 && {
        # get pids for any app with TERM_APP_NAME and kill
        while IFS="" read -r pid; do
            kill -15 "${pid}"
        done < <(pgrep -f $TERM_APP_NAME)
        open -a $TERM_APP_PATH
    }
fi
