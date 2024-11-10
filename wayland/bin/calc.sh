#!/usr/bin/env bash

# uses fuzzel + qalc to read query input and perform calculations
# uses wl-copy to copy result into clipboard
# keeps history of calculations

result_file="$HOME/.config/qalculate/qalc.result.history"
if [ ! -f "$result_file" ]; then
  touch $result_file
fi

last_query=""

while :
do
  qalc_hist=`tac $result_file | head -1000`

  query=`echo "" | fuzzel --dmenu --cache=/dev/null --placeholder="" --prompt="🔢 " --lines=10 <<< "$qalc_hist"`

  return_code=$?

  if test "$return_code" = "0"; then
    if [[ "$query" =~ .*=.* ]]; then
      result=`echo "$query" | awk {'print $NF'}`
      wl-copy "$result"
      exit 0
    else
      result=`qalc "$query"`
      last_query=$query
      echo $result >> $result_file
    fi
  else
    if [ ! -z "$last_query" ]; then
      result=`qalc -t "$last_query"`
      wl-copy "$result"
    fi

    exit 0
  fi
done
