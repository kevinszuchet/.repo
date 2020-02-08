# thefuck command line fixer
# https://github.com/nvbn/thefuck
if which thefuck >/dev/null 2>&1 ; then
  eval $(thefuck --alias fuck);
fi
