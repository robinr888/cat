
# H1 OPA Setup and Policy Examples 


*Make sure you have admin permission to install on the Kubernetes Cluster.*
`export KUBECONFIG=<location of kubeconfig file>`

# H2 Install OPA Gatekeeper using helm .

`helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts`
`helm install gatekeeper/gatekeeper --name-template=gatekeeper --namespace gatekeeper-system --create-namespace`

