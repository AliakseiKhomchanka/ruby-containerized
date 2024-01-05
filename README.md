# Containerized Ruby Server
[![build-deploy-test](https://github.com/AliakseiKhomchanka/ruby-containerized/actions/workflows/main.yml/badge.svg)](https://github.com/AliakseiKhomchanka/ruby-containerized/actions/workflows/main.yml)

A simple Ruby TCP server with socket connection with a pipeline that builds a Docker image, pushes it to an open repository, then deploys the app (consisting of a service and a deployment) to a local KIND cluster via Helm and runs a couple of tests on it.

The task mentions a "local kubernetes cluster" which I interpreted as "local to the job agent" and used KIND to simulate something of an integration test scenario with a local KIND cluster launched on an agent machine with some tests running on it.

Considerations (that would need to be addressed in production, but haven't been addressed here due to time constraints):
1. Some values, like the DockerHub repository, are hard-coded, rather than being repository-level values, in production they should be adjusted.
2. Some simple logging entries have ben added to the server code for local debugging, otherwise the code has been left untouched.
3. An alpine Ruby image is used for the sake of saving space and security, reducing potential attack surface.
4. KIND doesn't fully implement load balancing by default, but the nominal service type is LoadBalancer, which in a production environment would need to correcpond to an actual load balancer.
5. Access to the service on the local cluster is done via port forwarding, in a production case there would most likely be an ingress on top of the service.
6. There are 4 replicas of the server pod for availability, their individual resource usage is intentionally set low.
7. For time and money saving, assuming there's already some cloud provider used by the product (AWS, Azure etc.), it would also make sense to have a specialized image for the job agent with all the prerequisites like KIND or Helm installed already to save time on each job.
8. Testing in production should be done via a more specialised tool.
