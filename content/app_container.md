# From fast_api to Kubernetes in 60 seconds

## fast_api

- A simple python fast_api app which services a list of books from a memory database

## Dockerfile

- Containerizes the application so it can run elsewhere


## Building and running container locally

```
cd app/fast-api-app
docker build  -t fast_api .

# if necessary on macbook, specify platform as linux/amd64

docker build --platform linux/amd64 -t fast_api .
```

runt the container locally
```bash
docker run -it --rm -p 8000:8000 fast_api
```

## Pushing image to your registry

```

docker tag fast_api harbor.lab.agi-explorer.com/library/fast_api

docker push harbor.lab.agi-explorer.com/library/fast_api 
```

## deploy in privileged namespace
```bash
kubectl apply -f deployment-privileged.yaml

kubectl expose deployment my-fast-api --name=my-fast-api-service --port=8081 --target-port=8000 --type=LoadBalancer
```

## deploy in restricted namespace
```bash
kubectl apply -f deployment-restricted.yaml

kubectl expose deployment my-fast-api --name=my-fast-api-service --port=8081 --target-port=8000 --type=LoadBalancer
```

## Validate fast_api application works

```
$ kubectl get service

```

## on minikube, issue the following command to use the load balancer service, this is different that other cloud providers, like tanzu or EKS
```bash
minikube service my-fast-api-service --url
```
