# don't edit this file, put files in the dir below.

# ensure idempotent bashrc sourcing
# if DEFAULT_PATH not set
if [[ -z "$DEFAULT_PATH" ]] ; then
  # set it!
  export DEFAULT_PATH=$PATH
else
  # reset path to default path for idempotent bashrc sourcing
  export PATH=$DEFAULT_PATH
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc" # Load the default .bashrc

if [ -d "$HOME/profile.d" ]; then
  for FN in $HOME/profile.d/*.sh ; do
    source "$FN"
  done
fi
