
kubectl apply -f nginx-simple.yaml
kubectl apply -f nginx-service-vks1.yaml

minikube service nginx-service --url
