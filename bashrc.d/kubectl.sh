echo 'source <(kubectl completion bash)' >>~/.bashrc

alias k="kubectl"
alias kgp="kubectl get pods"
alias kufront="kubectl config use-context kuberneteca-front"
alias kujob="kubectl config use-context kuberneteca2"
alias kufunc="kubectl config use-context kuberneteca-functions-2"
alias kungfu="kubectl config use-context kuberneteca-functions-2"
alias kc="kubectl config current-context"
alias ktop="kufront && k top nodes && kujob && k top nodes && kufunc && k top nodes"
alias kl="kubectl logs"

klw() {
  if [ -z $1 ] ; then
    echo "Pod name is needed!" && return 0;
  fi
  kl $1 > logs.txt
}

kfp() {
  if [ -z $1 ] ; then
    echo "Pod name is needed!" && return 0;
  fi
  kgp --selector=name=$1
}

kuconfigmap() {
  if [ -z $1 ] ; then
    echo "Configmap name needed!" && return 0;
  fi
  kubectl create configmap $1-config --from-env-file=$1.properties
}
