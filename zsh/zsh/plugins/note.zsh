note() {
  local notes_dir=${NOTES_DIR:="$HOME/Dropbox/notes"}

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
    gp)
      pushd "$notes_dir"
      msg="Regenerated at $(date -u '+%Y-%m-%d %H:%M:%S') UTC"
      git add .
      git commit -m "$msg"
      git push origin master
      popd
      ;;
    gpu)
      pushd "$notes_dir"
      git pull origin master
      popd
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
