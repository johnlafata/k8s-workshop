# Services

- Provides a static IP so that even if pod dies and gets a new IP - the service can be accessed at same IP


Types of Services

- ClusterIP

- NodePort

- LoadBalancer

## make it available outside the cluster

```
kubectl expose deployment nginx-deployment --name=nginx-service --port=80 --target-port=8080 --type=LoadBalancer
```

### clean up
```
kubectl delete service nginx-service
kubectl delete deployment nginx-deployment
```

- ExternalName