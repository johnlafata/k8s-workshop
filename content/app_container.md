# From fast_api to Kubernetes in 60 seconds

## fast_api

- A simple go fast_api which just says hello

## Dockerfile

- A multistage Dockerfile - first part builds source code into binary

- Second part takes binary from first part and creates an image


## Building and running container locally

```
cd app/fast-api-app
# on my macbook, I need to specify platform as linux/amd64
# because the image is built for linux and I am on macOS

docker build --platform linux/amd64 -t fast_api .

# you maybe able to skip the platform flag
docker build  -t fast_api .


docker run -it --rm -p 8000:8000 fast_api

```

## Pushing image

```

docker tag fast_api harbor.lab.agi-explorer.com/library/fast_api

docker push harbor.lab.agi-explorer.com/library/fast_api 
```

## deploy 

```bash
kubectl apply -f deployment.yaml

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
