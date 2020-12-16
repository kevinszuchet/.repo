if which kubectl >/dev/null 2>&1 ; then
  if [ ! -f /etc/bash_completion.d/kubectl ]; then
  	kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
  fi

  alias k="kubectl"
  # CONTEXT SWITCHES
  alias kc="kubectl config current-context"
  alias kufront="kubectl config use-context kuberneteca-front"
  alias kufront2="kubectl config use-context kuberneteca-front-2"
  alias kujob="kubectl config use-context kuberneteca-jobs"
  alias kujob2="kubectl config use-context kuberneteca-jobs"
  alias kufunc="kubectl config use-context kuberneteca-functions-2"
  alias kungfu="kubectl config use-context kuberneteca-functions-2"
  alias kaws="kubectl config use-context arn:aws:eks:us-east-1:372376101692:cluster/kuberneteca" 
  alias kawsf="kubectl config use-context arn:aws:eks:us-east-1:372376101692:cluster/kuberneteca-front"
  alias kuka="kubectl config use-context kuberneteca-knative"
  # UTILS
  alias kgp="kubectl get pods"
  alias ktp="kubectl top pods"
  alias kgn="kubectl get nodes"
  alias ktn="kubectl top nodes"
  alias ktop="kufront && k top nodes && kujob && k top nodes && kufunc && k top nodes"
  alias kl="kubectl logs"
  alias kdesc="kubectl describe pod"
  alias wkgn="watch kubectl get nodes"
  alias wktn="watch kubectl top nodes"
  alias wktp="watch kubectl top pods"
  alias kx="kubectl exec -it"
  alias krep='kubectl get deploy --sort-by "spec.replicas"'
  alias kdev="kubectl get pods | grep 'Evicted' | awk '{print \$1}' | xargs kubectl delete pod"
  # SPOT and ON DEMAND
  alias kspot="kubectl get no -l eks.amazonaws.com/capacityType=SPOT"
  alias kdem="kubectl get no -l producteca/nodegroup-type=ondemand"
  alias kspotcount="kubectl get no -l eks.amazonaws.com/capacityType=SPOT --no-headers | wc -l"
  alias kdemcount="kubectl get no -l producteca/nodegroup-type=ondemand --no-headers | wc -l"

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
    kubectl get pods --selector=name=$1
  }

  kuconfigmap() {
    if [ -z $1 ] ; then
      echo "Configmap name needed!" && return 0;
    fi
    kubectl create configmap $1-config --from-env-file=$1.properties
  }

  kecm() {
    if [ -z $1 ] ; then
      echo "Configmap name needed!" && return 0;
    fi
    kubectl edit configmap $1-config
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
  
  kfp() {
    if [ "$#" -eq  "2" ];
    then
      kubectl get pods | grep $1 | grep $2
    elif [ "$#" -eq  "1" ];
    then
      kubectl get pods | grep $1
    else
      kubectl get pods
    fi
  }
  kcount() {
    kubectl get pods | grep $1 | wc -l
  }
  kimg() {
    kubectl get deployment "$1-deploy" -o=jsonpath="{$.spec.template.spec.containers[:1].image}"
  }
  kconf() {
    if [ "$#" -eq  "1" ]
    then
      kubectl get configmap "$1-config" -oyaml
    else
      kubectl get configmap "$1-config" -oyaml > $2
    fi
  }
  khpa() {
    if [ "$#" -eq  "1" ]
    then
      kubectl get hpa "$1-deploy" -oyaml
    else
      kubectl get hpa "$1-deploy" -oyaml > $2
    fi
  }

  appid(){ 
    iwannabe $1 --ls | grep PRODUCTECA_CLIENTID
  }
  kgpn() {
    kubectl get pods -owide | grep $1
  }
  kgpdem() {
    for A_NODE in $(kubectl get no -l producteca/nodegroup-type=ondemand --no-headers | awk '{print $1}');
    do
      kgpn $A_NODE
    done
  }
  kgpspot() {
    for A_NODE in $(kubectl get no -l eks.amazonaws.com/capacityType=SPOT --no-headers | awk '{print $1}');
    do
      kgpn $A_NODE
    done
  }
fi