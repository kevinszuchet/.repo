if which eksctl >/dev/null 2>&1 ; then
  if [ ! -f /etc/bash_completion.d/eksctl ]; then
  	eksctl completion bash | sudo tee /etc/bash_completion.d/eksctl > /dev/null
  fi
fi