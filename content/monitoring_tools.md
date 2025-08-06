
# Kubernetes Monitoring Tools

## Node Health Monitoring

Based on the Kubernetes documentation, node health monitoring involves:

- **Node Problem Detector**: A DaemonSet that detects and reports node problems to the cluster
- **Health checks**: Monitors system daemons, hardware, and kernel issues
- **Problem reporting**: Surfaces node conditions and events for cluster management
- **Integration**: Works with cluster autoscaler and other management tools

## Monitoring Tools by Category

### Cluster-Level Monitoring
- **Prometheus + Grafana**: Complete metrics collection and visualization
- **Kubernetes Dashboard**: Web-based cluster management interface  
- **Lens**: Desktop application for cluster management
- **k9s**: Terminal-based cluster management

### Node & Resource Monitoring
- **Node Problem Detector**: Hardware and kernel issue detection
- **cAdvisor**: Container resource usage and performance metrics
- **Metrics Server**: Resource usage APIs for autoscaling
- **kube-state-metrics**: Cluster state metrics

### Application Performance
- **Jaeger**: Distributed tracing
- **Zipkin**: Request tracing and latency analysis
- **New Relic**: APM with Kubernetes integration
- **Datadog**: Infrastructure and application monitoring

### Log Management
- **ELK Stack**: Elasticsearch, Logstash, Kibana for log aggregation
- **Fluentd/Fluent Bit**: Log forwarding and processing
- **Loki**: Log aggregation system by Grafana

### Security & Compliance
- **Falco**: Runtime security monitoring
- **OPA Gatekeeper**: Policy enforcement
- **Aqua Security**: Container security platform
