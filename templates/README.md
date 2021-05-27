#  <% .Name %> Backend service

# Getting Started
### Essential steps to get your backend service deployed
A helloworld example has been shipped with the template to show the bare minimum setup - a server that listens on the configured port, a dockerfile, and some kubernetes manifests.
- Webserver that listens on port <% index .Params `containerPort` %>
- Dockerfile builds and serves on port <% index .Params `containerPort` %>


# Deployment
### Things that happened behind the scenes
- The Github Org has already been configured with secrets that allow this project to deploy to the Onboarding cluster
- CI/CD will run in Github actions to deploy your application
- It will build an image and push to ECR (Elastic Container Registry)
- it will create an ingress, service, and deployment in the Kubernetes cluster using kustomize during the CI pipeline
- It will update the deployment to use the newly built docker image

# Your local environment
To set up your local environment with access to AWS and Kubernetes, just run:
```
./scripts/setup-env.sh
```
This script will open a web browser and prompt you to log in with your Commit Gmail account, and then will configure an AWS profile and a Kubernetes context.

# Structure
## Kubernetes
The configuration of your application in Kubernetes uses [https://kustomize.io/](kustomize) and is run by the CI pipeline, the configuration is in the [`/kubernetes`](./kubernetes/deploy/) directory.
Once the CI pipeline is finished, you can see the pod status on kubernetes in your application namespace:
```
kubectl -n <% .Name %> get pods
```
### Configuring
You can update the configuration of the [deployment] and adjust things like increasing the number of replicas and adding new environment variables in the [kustomization] file. The [ingress] and [service] control routing traffic to your application.

## Github actions
Your repository comes with a end-to-end CI/CD pipeline, which includes the following steps:
1. Checkout
2. Unit Tests
3. Build Image
4. Upload Image to ECR
4. Deploy image to cluster

<!-- Links -->
[deployment]: ./kubernetes/deploy/deployment.yml
[service]: ./kubernetes/deploy/service.yml
[ingress]: ./kubernetes/deploy/ingress.yml
[kustomization]: ./kubernetes/deploy/kustomization.yml
