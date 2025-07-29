# Services

A Kubernetes Service is a Kubernetes object that exposes a logical set of Pods as a network service, providing a stable IP address and DNS name for accessing those Pods.


## Types of Services

### ClusterIP

The ClusterIP mode is a way of exposing a Kubernetes service by assigning an IP address to the service from the Service Cluster IP range that was configured when your Kubernetes cluster was built. This range is a cluster-internal range, and not typically accessible to the rest of the
network.

### NodePort

The NodePort mode operates a little differently. Kubernetes will expose a service by mapping a random port on all of the cluster worker nodes to the application port exposed by the Pods.

### LoadBalancer

#### create a load balancer service

A Kubernetes LoadBalancer service type provides a way to expose an application running in a cluster to external traffic by provisioning an external load balancer from a cloud provider. It extends the NodePort service by automatically creating and configuring a cloud provider's load balancer to distribute traffic to the service's pods.

```
kubectl expose deployment nginx-deployment --name=nginx-service --port=80 --target-port=8080 --type=LoadBalancer
```

#### clean up Load balancer
```
kubectl delete service nginx-service
kubectl delete deployment nginx-deployment
```

### ExternalName

Services with type ExternalName work as other regular services, but when you want to access to that service name, instead of returning cluster-ip of this service, it returns CNAME record with value that mentioned in externalName: parameter of service.

As example mentioned in Kubernetes Documentation:

```yaml
kind: Service
apiVersion: v1
metadata:
  name: my-service
spec:
  type: ExternalName
  externalName: my.database.example.com
```

### Ingress

To distribute traffic to Kubernetes ClusterIP services from outside the cluster, you need an Ingress resource and an Ingress controller. Ingress acts as a reverse proxy and load balancer, routing external traffic to your services based on defined rules. 

By using Ingress, you can expose multiple ClusterIP services with a single external IP address, simplifying traffic management and reducing costs. 

example of Ingress resource:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
    rules:
    - host: myapp.example.com
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: my-app-service
              port:
                number: 80
```

### Gateway API 

With Ingress focused narrowly on HTTP traffic and Gateway API introducing a new model for managing all internal cluster traffic, there are significant differences between these Kubernetes networking approaches:

* Protocol support: Ingress only works for Layer 7 protocols like HTTP and HTTPS. Non-L7 support requires custom controller extensions. Gateway API supports both L4 protocols such as TCP and UDP as well as L7 protocols like HTTP natively within the specification.
* Traffic management: Ingress has limited built-in capabilities for advanced traffic management like A/B testing or request mirroring. These require vendor extensions and customization. Gateway API offers built-in support for traffic splitting, mirroring, injections, and fine-grained metrics.
* Portability: Ingress definitions rely on vendor specifics, with each implementation having its own syntax and capabilities around extensions. Gateway API establishes a common standard that works consistently across all compliant controller implementations.
* Resource object definitions: No new resource objects are introduced in the Ingress specification. Gateway API introduces GatewayClass for capability definitions, Gateway for instantiations, HTTPRoute for HTTP traffic rules, and more objects for other protocols.
* Routing customization: Ingress only supports path or host-based routing rules. Gateway API enables route customization based on arbitrary header fields as well as paths and hosts.
* Extending capabilities: Adding capabilities like authentication policies or rate limiting to Ingress requires vendor-specific custom annotations and extensions. These features come built-in with Gateway API as part of the overall specification.

| Feature | Ingress | Gateway API |
|---------|---------|-------------|
| Protocol support | HTTP/HTTPS only | L4 and L7 protocols |
| Traffic management | Limited, requires extensions | Built-in support for traffic splitting, mirroring, injections |
| Portability | Vendor-specific implementations | Common standard across compliant controllers |
| Resource objects | Ingress resource only | GatewayClass, Gateway, HTTPRoute, etc. |
| Routing customization | Path/host-based only | Customizable based on headers, paths, hosts    |
| Extending capabilities | Vendor-specific annotations | Built-in features like authentication, rate limiting |


example of Gateway API resource:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
    name: example-gateway
spec:
    gatewayClassName: example-gateway-class
    listeners:
    - name: http
      protocol: HTTP
      port: 80
      routes:
        kind: HTTPRoute
        name: example-http-route
```