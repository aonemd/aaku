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
      vim "$1"
      popd
  esac
}
