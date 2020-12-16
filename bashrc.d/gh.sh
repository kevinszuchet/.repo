if which gh >/dev/null 2>&1 ; then
  if [ ! -f /etc/bash_completion.d/gh ]; then
  	gh completion -s bash | sudo tee /etc/bash_completion.d/gh > /dev/null
  fi
fi