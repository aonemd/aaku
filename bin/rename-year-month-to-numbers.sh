#!/usr/bin/env bash

declare -A months=(
  [jan]=01 [january]=01
  [feb]=02 [february]=02
  [mar]=03 [march]=03
  [apr]=04 [april]=04
  [may]=05
  [jun]=06 [june]=06
  [jul]=07 [july]=07
  [aug]=08 [august]=08
  [sep]=09 [september]=09
  [oct]=10 [october]=10
  [nov]=11 [november]=11
  [dec]=12 [december]=12
)

for f in *.md; do
  [[ $f =~ ^([0-9]{4})-([A-Za-z]+)\.md$ ]] || continue

  year="${BASH_REMATCH[1]}"
  month_name="$(echo "${BASH_REMATCH[2]}" | tr 'A-Z' 'a-z')"

  month_num="${months[$month_name]}"
  [[ -z $month_num ]] && continue

  new="${year}-${month_num}.md"

  echo "Renaming: $f -> $new"
  mv -i "$f" "$new"
done
