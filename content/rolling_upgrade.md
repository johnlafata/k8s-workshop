# Rolling Upgrades with Labels in Kubernetes

## Overview
Rolling upgrades allow you to update deployments gradually without downtime by using labels to control which pods are updated.

## Basic Rolling Upgrade Process

### 1. Update Deployment with New Labels
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: my-app
spec:
    replicas: 3
    selector:
        matchLabels:
            app: my-app
            version: v2  # Update version label
    template:
        metadata:
            labels:
                app: my-app
                version: v2  # New version label
        spec:
            containers:
            - name: my-app
                image: my-app:v2  # New image version
```

### 2. Apply the Update
```bash
kubectl apply -f deployment.yaml
```

### 3. Monitor the Rolling Update
```bash
# Check rollout status
kubectl rollout status deployment/my-app

# Watch pods being updated
kubectl get pods -l app=my-app --watch
```

## Advanced Strategies

### Blue-Green with Labels
```bash
# Deploy green version alongside blue
kubectl label deployment my-app version=green

# Update service selector to switch traffic
kubectl patch service my-app -p '{"spec":{"selector":{"version":"green"}}}'
```

### Canary Deployment
```yaml
# Create canary deployment with different labels
metadata:
    labels:
        app: my-app
        track: canary
        version: v2
```

## Rollback if Needed
```bash
kubectl rollout undo deployment/my-app
```