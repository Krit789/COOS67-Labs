# Kubernetes Lab #14

# Section 0: Introduction

# Section 1: Preparation

Install Minikube

[Link Install Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download)

![Install Minikube](./image/install-minikube.png)

# Section 2: Start Kubernetes


# Section 3: MiniKube

## 3.1: Start MiniKube

![Start MiniKube](./image/minikube-start.png)

## 3.2: Check Kubectl nodes

![](./image/kubectl-get-nodes-2.png)

## 3.3: Check Kubectl pods

![](./image/kubectl-get-pods-2.png)

## 3.4 MiniKube Dashboard

![](./image/minikube-dashboard.png)
### Click on ```Namespace``` on the left panel
![](./image/minikube-dashboard-2.png)

## 3.5 Create Sample application

### Create a application
![](./image/kubectl-create-1.png)

### Expose the application in port 80
![](./image/kubectl-expose.png)

### Check the application
![](./image/kubectl-get-services.png)

## 3.6 Launch the service name ```balanced```

![](./image/minikube-service-1.png)
Ctrl + c to terminate the service

![](./image/minikube-service-2.png)


## 3.7 Load Balancer deployment
![](./image/kubectl-create-2.png)

![](./image/kubectl-expose-2.png)

## 3.7 minikube tunnel
![](./image/minikube-tunnel.png)

### To know the external IP of service ```balanced```

![](./image/kubectl-get-services-2.png)


## 3.8 Show all  pods in the cluster

![](./image/kubectl-get-pods-3.png)

## 3.9 Show all  nodes in the cluster

![](./image/kubectl-get-nodes-3.png)

## 3.10 Show all namespaces

![](./image/kubectl-get-namespaces.png)

## 3.11 Show all deployments

![](./image/kubectl-get-deployments.png)

## 3.12 Show all services

![](./image/kubectl-get-services-3.png)

## Show cluster info

![](./image/kubectl-cluster-info.png)

## Show staus of the cluster

![](./image/minikube-status.png)

## List the event log 

![](./image/kubectl-get-events.png)

## Pause the cluster

![](./image/minikube-pause.png)

![](./image/minikube-status-2.png)

## Resume the cluster

![](./image/minikube-unpause.png)

![](./image/minikube-status-3.png)

## Stop the cluster

![](./image/minikube-stop.png)

![](./image/minikube-status-4.png)

## update activate context

![](./image/docker-context-use-default.png)



# Section 4: Uninstall Minikube

```shell
minikube stop
```

```shell
miniube delete
```
## Delete the ```.minikube``` and ```.kube``` folder

```shell
C:\Users\{user}\.minikube (rm $HOME/.minikube)
```

```shell
C:\Users\{user}\.kube (rm $HOME/.kube)
```

## Delete All the images (IT WILL DELETE ALL THE IMAGES)

```shell
docker rmi -f $(docker images -aq)
```


