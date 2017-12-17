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
    p)
      pushd "$notes_dir"
      msg="Regenerated at $(date -u '+%Y-%m-%d %H:%M:%S') UTC"
      git add .
      git commit -m "$msg"
      git push origin master
      popd
      ;;
    *)
      vim "$notes_dir/$1"
  esac
}
