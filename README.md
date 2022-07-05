## catassignment
This repository contains the Assigment work done for CAT Devops/SRE Role .



## API Service 

A simple API service is create using  flask & gunicorn WSGI . This api renders randomdom data mocked in data.json file . 
Enhancements can be done to point them to fetch records from Database as required .


### 1. Steps for Containerising the app & Running Docker structure Test

##### Dockerization

Containerising and deployment process is simplified by using the makefile . some of the default parameters like appname and ports are harcoded in the Makefile .

Docker CE should be installed and running on the latop or the box where this is executed.


```
make build
```

##### Docker structure Test Setup

```
make test
```


### 2. Helm Charts for Kubernetes Deployment

Helm Charts are in the helm folder of the repository root .  Make sure you have helm binary installed on your local machine . 

*Make sure you have admin permission to install on the Kubernetes Cluster , export the user kubeconfig with admin permissions.*

`export KUBECONFIG=<location of kubeconfig file>`

##### Dev
```
helm upgrade -i flaskapp ./helm -f ./helm/overrides/dev-values.yml
```

#### Prod
```
helm upgrade -i flaskapp ./helm -f ./helm/overrides/prod-values.yml
```

### Helm Testing 

```
helm test flaskapp
```

### Helm Hooks 

Helm Hooks are configured using the job.yaml in helm templates directory , Currently it a simple job which makes a pre-upgrade / pre-install step invoking a curl GET call to api , this can be enhanced to Load datasets into DB or any pre or post deployment actions . DB Charts can be added as dependency to the chart as well and the hooks executed against those Database as per use cases .


### 3. Deploy to Kubernetes Deployment


*Make sure you have admin permission to install on the Kubernetes Cluster , export the user kubeconfig with admin permissions.*

`export KUBECONFIG=<location of kubeconfig file>`


[OPA Deployments](../opa/README.md)





