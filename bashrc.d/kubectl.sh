if which kubectl >/dev/null 2>&1 ; then
  source <(kubectl completion bash)

  alias k="kubectl"
  alias kgp="kubectl get pods"
  alias ktp="kubectl top pods"
  alias kgn="kubectl get nodes"
  alias ktn="kubectl top nodes"
  alias kufront="kubectl config use-context kuberneteca-front"
  alias kufront2="kubectl config use-context kuberneteca-front-2"
  alias kujob="kubectl config use-context kuberneteca2"
  alias kujob2="kubectl config use-context kuberneteca-jobs"
  alias kufunc="kubectl config use-context kuberneteca-functions-2"
  alias kungfu="kubectl config use-context kuberneteca-functions-2"
  alias kuka="kubectl config use-context kuberneteca-knative"
  alias kc="kubectl config current-context"
  alias ktop="kufront && k top nodes && kujob && k top nodes && kufunc && k top nodes"
  alias kl="kubectl logs"
  alias kdesc="kubectl describe pod"
  alias wkgn="watch kubectl get nodes"
  alias kx="kubectl exec -it"
  alias wktn="watch kubectl top nodes"
  alias wktp="watch kubectl top pods"
  alias kaws="kubectl config use-context arn:aws:eks:us-east-1:372376101692:cluster/kuberneteca" 
  alias kawsf="kubectl config use-context arn:aws:eks:us-east-1:372376101692:cluster/kuberneteca-front"

  klw() {
    if [ -z $1 ] ; then
      echo "Pod name is needed!" && return 0;
    fi
    kl $1 > logs.txt
  }
  
  wkgp() {
    if [ "$#" -eq  "1" ]
    then
      watch kgp --selector=name=$1
    else
      watch kubectl get pods
    fi
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
  
  kcliconfig() {
    if [ -z $1 ] ; then
      echo "Configmap name needed!" && return 0;
    fi
    kubectl edit hpa $1 
  }
  
  ksh() {
    kubectl exec -it $1 /bin/sh
  }
  
  kbash() {
    kubectl exec -it $1 /bin/bash
  }
  
  kimg() {
    kubectl get deployment "$1-deploy" -o=jsonpath="{$.spec.template.spec.containers[:1].image}"
  }
 fi
 
