#  <% .Name %> Backend service

# Getting Started
### Essentials steps to get your backend server deployed
A helloworld example has been shipped with the template to show the bare minimum setup, server that listens on the configured port and a dockerfile. (`main.py`, `requirements.txt`, `Dockerfile`)
- Webserver that listens on a port <% index .Params `containerPort` %>
- Dockerfile builds and serves on port <% index .Params `containerPort` %>


# Deployment
### Things that happened behind the scene
- The Github-Org has been configured with secrets that has access to deploy to the Onboarding cluster
- CI/CD will run in Github actions to deploy your application
- It will build an image and push to ECR repository
- it will creates an ingress, service and deployment in Kubernetes cluster using kustomize during the CI pipeline
- It will update deployment image to use the most recent built Image

# Structure
## Kubernetes
The setup of kubernetes uses kustomize and is ran during theCI pipeline, it is setup in the [`/kubernetes`](./kubernetes/deploy/) folder
Your application is deployed on your EKS cluster through CI pipeline, you can see the pod status on kubernetes in your application namespace:
```
kubectl -n <% .Name %> get pods
```
### Configuring
You can update the resource limits in the [kubernetes/deploy/deployment.yml][deployment], and control fine-grain customizations based on environment and specific deployments such as Scaling out replicas and environment variables. And the [ingress] and [service] are also setup during the CI pipeline using Kustomize to setup the api on the infrastructure.

## Github actions
Your repository comes with a end-to-end CI/CD pipeline, which includes the following steps:
1. Checkout
2. Unit Tests
3. Build Image
4. Upload Image to ECR
4. Deploy image cluster

<!-- Links -->
[deployment]: ./kubernetes/deploy/deployment.yml
[service]: ./kubernetes/deploy/service.yml
[ingress]: ./kubernetes/deploy/ingress.yml
[circleci-details]: ./.circleci/README.md
