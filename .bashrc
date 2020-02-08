# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't edit this file, put files in the dir below.
if [ -d "$HOME/bashrc.d" ]; then
  for FN in $HOME/bashrc.d/*.sh ; do
    source "$FN"
  done
fi
