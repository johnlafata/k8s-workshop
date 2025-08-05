
### start minikube
# minikube start --kubernetes-version=v1.25.3 --feature-gates=PodSecurity=true --extra-config=apiserver.enable-admission-plugins=PodSecurity --cpus='4'   --memory=12200MB --embed-certs
minikube start --cpus='4'   --memory=17960MB --extra-config=apiserver.enable-admission-plugins=PodSecurity 

minikube start --cpus='4'   --memory=17960MB --embed-certs


### deploy`ng nginx
kubectl apply -f nginx-simple.yaml
kubectl apply -f nginx-service-vks1.yaml

### connect to browser ui from minikube
minikube service nginx-service --url
