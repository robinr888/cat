
## OPA Setup and Policy Examples 
---

* Make sure you have admin permission to install on the Kubernetes Cluster , export the user kubeconfig with admin permissions.*

`export KUBECONFIG=<location of kubeconfig file>`

### 1. Install OPA Gatekeeper using helm .
---

*Make sure helm binary is available on your laptop or bastion host from where you execute the commands*

    helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts

    helm install gatekeeper/gatekeeper --name-template=gatekeeper --namespace gatekeeper-system --create-namespace

### 2. Deploy OPA policy and Constraints 

* Policy to restrict deployments if serviceAccountName is "default" or automountServiceAccountToken is set to "True" . This is applied in Pod Level .

    kubectl apply -f disallow-defaultsvctoken/template.yaml

    kubectl apply -f disallow-defaultsvctoken/constraint.yaml

* Verify Policy 

    kubectl apply -f disallow-defaultsvctoken/allow.yaml

    kubectl apply -f disallow-defaultsvctoken/disallow.yaml

    kubectl apply -f disallow-defaultsvctoken/disallow-v2.yaml


### 3. Policy to restrict deployments trying to run containers as root user.

* Policy to restrict deployments if runAsNonRoot is not declared or runAsNonRoot is set to "False" . This is applied in Pod Level .

    kubectl apply -f disallow-runasnonroot/template.yaml

    kubectl apply -f disallow-runasnonroot/constraint.yaml

* Verify Policy 

    kubectl apply -f disallow-runasnonroot/allow.yaml

    kubectl apply -f disallow-runasnonroot/disallow.yaml











