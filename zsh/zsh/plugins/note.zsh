note () {
  local notes_dir="$HOME/Dropbox/notes"

  case "$1" in
    c)
      cd "$notes_dir"
      ;;
    l)
      ls "$notes_dir"
      ;;
    t)
      tree --noreport "$notes_dir"
      ;;
    *)
      pushd "$notes_dir"
      if [ $# -eq 0 ]; then
        vim "$1"
      else
        vim "$1".md
      fi
      popd
  esac
}
