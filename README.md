# CAT Assignment
This repository contains the Assigment work done for CAT Devops/SRE Role .



## API Service 

A simple API service is create using  flask & gunicorn WSGI . This api renders randomdom data mocked from data inside data.json file . 
Enhancements can be done to point them to fetch records from Database as required .


### 1. Steps for Containerising the app & Running Docker structure Test

##### Dockerization

Containerising and deployment process is simplified using the makefile . some of the default parameters like appname and ports are harcoded in the Makefile .

1. pre-requisites : Docker CE should be installed and running on the latop or the box where this is executed.

2. Potential Enhancements : TO-DDO
    * some of the hardcoded parameters in the makefile can be made as arguments ( e.g make tag-version VERSION="1.1.0")
    

3. Create Image

        
        make build

4. [ OPTIONAL]  If you want to push the image to your repository . update the DOCKER_REPO variable in makefile and run  . The images which can used for Kubernetes deployments are already pushed to public docker repo .

        make tag
        make push


4. Perform docker structure test ( NOTE: This command may ask you for placing container-structure-test-darwin-amd64 in appropriate bin paths if you dont have them in /usr/local/bin/container-structure-test)

        make test



### 2. Helm Charts for Kubernetes Deployment

Helm Charts are in the helm folder of the repository root .  Few items focused during helm chart creation 

*   security context - nonroot user , readonly filesystem 
*   Prod and dev segregation
    



1. pre-requisites : Make sure you have helm binary installed on your local machine . 

    * Make sure you have admin permission to install on the Kubernetes Cluster , export the user kubeconfig with admin permissions.*

        `export KUBECONFIG=<location of kubeconfig file>`

2. Prod / Dev Environments can be distinguish based on different Values spec files 

    * Dev

        `helm upgrade -i flaskapp ./helm -f ./helm/overrides/dev-values.yml`


    * Prod

        `helm upgrade -i flaskapp ./helm -f ./helm/overrides/prod-values.yml`


3. Helm Testing 

        helm test flaskapp


4. Helm Hooks 

    Helm Hooks are configured using the job.yaml in helm templates directory , Currently it a simple job which makes a pre-upgrade / pre-install step invoking a curl GET call to api , this can be enhanced to Load datasets into DB or any pre or post deployment actions .


5. Potential Enhancements : TO-DO
    * Appropriate --set commands can be passed to change image tag as necessary in the cicd build .
    * Configmap can be created for the .ini file which is used by the Api 
    * Helm Hooks can be customised to trigger custom db action.
    * DB Charts can be added as dependency to the chart as well and the hooks executed against those Database as per use cases .
    * from security perspective imagePullSecrets can be configured.


### 3. Deploy to Kubernetes Deployment

1. pre-requisites : Make sure you have helm binary installed on your local machine . 
    * Make sure you have admin permission to install on the Kubernetes Cluster , export the user kubeconfig with admin permissions.*

    `export KUBECONFIG=<location of kubeconfig file>`

    [OPA Deployments](./opa/README.md)





